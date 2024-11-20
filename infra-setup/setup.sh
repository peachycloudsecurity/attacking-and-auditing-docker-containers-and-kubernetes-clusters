#!/bin/bash

# Variables
export STUDENTCLUSTERNAME='k8s-training-cluster-1'
export STUDENTREGION='us-central1'
export STUDENTCLUSTER_MIN_NODES='2'
export STUDENTCLUSTER_MAX_NODES='3'
export STUDENTCLUSTER_VERSION='1.28.14-gke.1217000' # Updated Kubernetes version

if [ -z "$STUDENTPROJECTNAME" ]; then
  echo "Please set the STUDENTPROJECTNAME environment variable."
  exit 1
fi

# Set working directory
cd "$(dirname "$0")" || exit

# Cluster creation
echo "Creating Kubernetes cluster..."
gcloud container clusters create "$STUDENTCLUSTERNAME" \
  --project "$STUDENTPROJECTNAME" \
  --zone "$STUDENTREGION-a" \
  --no-enable-basic-auth \
  --cluster-version "$STUDENTCLUSTER_VERSION" \
  --machine-type "e2-medium" \
  --image-type "COS_CONTAINERD" \
  --disk-type "pd-standard" \
  --disk-size "50" \
  --metadata disable-legacy-endpoints=true \
  --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
  --preemptible \
  --num-nodes "2" \
  --logging=SYSTEM,WORKLOAD \
  --monitoring=SYSTEM \
  --no-enable-ip-alias \
  --network "projects/$STUDENTPROJECTNAME/global/networks/default" \
  --subnetwork "projects/$STUDENTPROJECTNAME/regions/$STUDENTREGION/subnetworks/default" \
  --enable-autoscaling \
  --min-nodes "$STUDENTCLUSTER_MIN_NODES" \
  --max-nodes "$STUDENTCLUSTER_MAX_NODES" \
  --addons HorizontalPodAutoscaling,HttpLoadBalancing \
  --no-enable-autoupgrade \
  --no-enable-autorepair \
  --maintenance-window "18:30"

if [ $? -ne 0 ]; then
  echo "Failed to create the Kubernetes cluster."
  exit 1
fi

# Create a static IP address if it doesn't exist
echo "Creating static IP address..."
if ! gcloud compute addresses describe "$STUDENTCLUSTERNAME-sip" --region "$STUDENTREGION" --project "$STUDENTPROJECTNAME" &>/dev/null; then
  gcloud compute addresses create "$STUDENTCLUSTERNAME-sip" \
    --region "$STUDENTREGION" \
    --project "$STUDENTPROJECTNAME"
  if [ $? -ne 0 ]; then
    echo "Failed to create the static IP address."
    exit 1
  fi
else
  echo "Static IP address already exists."
fi

export STUDENTCLUSTERSIP=$(gcloud compute addresses describe "$STUDENTCLUSTERNAME-sip" \
  --region "$STUDENTREGION" \
  --project "$STUDENTPROJECTNAME" \
  --format="value(address)")

echo "Static IP assigned: $STUDENTCLUSTERSIP"

# Get cluster credentials
echo "Fetching cluster credentials..."
gcloud container clusters get-credentials "$STUDENTCLUSTERNAME" \
  --zone "$STUDENTREGION-a" \
  --project "$STUDENTPROJECTNAME"

if [ $? -ne 0 ]; then
  echo "Failed to fetch cluster credentials. Please verify the cluster name and region."
  exit 1
fi

echo "Cluster setup completed successfully."

# Add NGINX Ingress repository if not already added
echo "Adding and updating Helm repositories..."
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# Install NGINX Ingress Controller
echo "Installing NGINX Ingress Controller..."
helm install nginx-ingress ingress-nginx/ingress-nginx \
  --namespace kube-system \
  --set controller.service.externalTrafficPolicy=Local \
  --set controller.service.loadBalancerIP="$STUDENTCLUSTERSIP"

# Wait for NGINX Ingress Controller to be ready
echo "Waiting for NGINX Ingress Controller to be ready..."
kubectl wait --namespace kube-system \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/name=ingress-nginx \
  --timeout=120s


# Install mailbox-service chart
cat << EOF > config.json
{
    "auths": {
        "https://gcr.io": {
            "auth": "dXNlcm5hbWU6cGFzc3dvcmQ="
        }
    }
}
EOF
kubectl create secret generic privateregistrycreds \
    --from-file=.dockerconfigjson=config.json \
    --type=kubernetes.io/dockerconfigjson

echo "Installing mailbox-service Helm chart..."
helm install mailbox-service Helm-Charts/mailbox-service/
rm config.json


# Install connectivity-check chart
echo "Installing connectivity-check Helm chart..."
helm install connectivity-check Helm-Charts/connectivity-check/

# Install server-health chart
echo "Installing server-health Helm chart..."
helm install server-health Helm-Charts/server-health/

kubectl apply -f code-base/code-base.yaml
kubectl apply -f net-tools/net-tools.yaml
kubectl apply -f secrets-db-service/secrets-db-service.yaml
kubectl apply -f apps-ingress/apps-ingress.yaml

## Generate kubeconfig
export STUDENTCONFIGSERVER=$(kubectl cluster-info | grep master | awk '{print $NF}' | sed 's/\x1B\[[0-9;]\+[A-Za-z]//g')
export STUDENTTOKENNAME=$(kubectl -n kube-system get secret | grep tiller-token | awk '{print $1}')
export STUDENTCONFIGTOKEN=$(kubectl -n kube-system get secret $STUDENTTOKENNAME -o "jsonpath={.data.token}" | base64 -d)
export STUDENTCONFIGCRT=$(kubectl -n kube-system get secret $STUDENTTOKENNAME -o "jsonpath={.data['ca\.crt']}")
cat <<EOF > k8s-training-kubeconfig
apiVersion: v1
kind: Config
users:
- name: default
  user:
    token: $STUDENTCONFIGTOKEN
clusters:
- cluster:
    certificate-authority-data: $STUDENTCONFIGCRT
    server: $STUDENTCONFIGSERVER
  name: $STUDENTCLUSTERNAME
contexts:
- context:
    cluster: $STUDENTCLUSTERNAME
    user: default
  name: training
current-context: training
EOF

## Generate destroy script
cat > destroy.sh<<_EOF
#!/bin/bash

gcloud beta container --project "$STUDENTPROJECTNAME" clusters delete "$STUDENTCLUSTERNAME" --zone "$STUDENTREGION-a"
gcloud compute addresses delete $STUDENTCLUSTERNAME-sip --region $STUDENTREGION --project $STUDENTPROJECTNAME
_EOF
