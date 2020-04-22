# Summary

* [Welcome](README.md)

* [Introduction](intro/README.md)
    * [Disclaimer](intro/disclaimer.md)
    * [Agenda](intro/agenda.md)

* [Environment Setup](environment-setup/README.md)
    * [Importing Virtual Machines](environment-setup/importing-virtualmachines.md)
    * [SSH into machines from your host](environment-setup/ssh-into-machine.md)
    * [Common troubleshooting steps](environment-setup/common-troublehshooting-steps.md)
    * [Internet Check](getting-started/internet-check.md)

* [Getting started with docker](getting-started-with-docker/README.md)
    * [docker run](getting-started-with-docker/docker-run.md)
    * [Dockerfile](getting-started-with-docker/dockerfile.md)
    * [docker management](getting-started-with-docker/docker-management.md)

* [Docker Advanced Concepts](advanced-concepts/README.md)
    * [docker-compose wordpress](advanced-concepts/docker-compoe-wordpress.md)
    * [docker volumes and networks](advanced-concepts/docker-volumes-and-networks.md)
    * [docker swarm](advanced-concepts/docker-swarm.md)
    * [Portainer](advanced-concepts/portainer.md)

* [Attacking Insecure Volume Mounts](attacking-insecure-volume-mounts/README.md)
    * [Scenario](attacking-insecure-volume-mounts/scenario.md)
    * [Solution](attacking-insecure-volume-mounts/solution.md)

* [Learning More](attacking-docker-containers/README.md)
    * [Namespaces](attacking-docker-containers/namespaces.md)
    * [Capabilities](attacking-docker-containers/capabilities.md)
    * [Control Groups](extra/control-groups.md)

* [Attacking docker misconfiguration](attacking-docker-misconfiguration/README.md)
    * [Scenario](attacking-docker-misconfiguration/scenario.md)
    * [Solution](attacking-docker-misconfiguration/solution.md)

* [Auditing Docker containers and images](docker-image-audit/README.md)
    * [Docker images and containers](auditing-docker-containers/docker-images-containers.md)
    * [Scenario](docker-image-audit/scenario.md)
    * [Solution](docker-image-audit/solution.md)

* [Auditing Docker networks and volumes](docker-volumes-and-networks/README.md)
    * [Docker volumes and networks](auditing-docker-containers/docker-volumes-networks.md)
    * [Scenario](docker-volumes-and-networks/scenario.md)
    * [Solution](docker-volumes-and-networks/solution.md)

* [Docker integrity checks](auditing-docker-containers/docker-integrity-check.md)

* [amicontained](auditing-docker-containers/amicontained.md)

* [Attacking & Auditing Docker Runtime & Registries](attacking-auditing-docker-registry/README.md)
    * [Docker runtime endpoints](auditing-docker-containers/docker-runtime-endpoints.md)
    * [Docker registries](attacking-auditing-docker-registry/docker-registries.md)

* [Attacking container capabilities](attacking-containers-capabilities/README.md)
    * [Scenario](attacking-containers-capabilities/scenario.md)
    * [Solution](attacking-containers-capabilities/solution.md)

* [Linux Security Module: Apparmor](apparmor-nginx-profile/README.md)

* [Attacking swarm cluster secrets](exploiting-cluster-secrets/README.md)
    * [Scenario](exploiting-cluster-secrets/scenario.md)
    * [Solution](exploiting-cluster-secrets/solution.md)

* [Attacking private registry images](attacking-private-registry/README.md)
    * [Scenario](attacking-private-registry/scenario.md)
    * [Solution](attacking-private-registry/solution.md)

* [Docker Bench security audit](auditing-docker-containers/docker-bench-security-audit.md)

* [Container Security Monitoring](csm/README.md)
    * [Docker logging](docker-logging/README.md)
    * [Docker Events](docker-events/README.md)
    * [Sysdig Faclo](sysdig-faclo/README.md)

* [Kubernetes Environment Setup](getting-started/README.md)
    * [Cluster Setup](getting-started/kubernetes-cluster-setup.md)
    * [Import VM](getting-started/import-vm.md)
    * [Configure kubectl](getting-started/configure-kubectl.md)
    * [Vulnerable Apps](getting-started/vuln-apps.md)
  
* [Getting Started with Kubernetes](kubernetes-101/readme.md)
    * [The Illustrated Children's Guide to Kubernetes](kubernetes-101/children-guide.md)
    * [Introduction to Kubernetes](kubernetes-101/introduction.md)
    * [Kubernetes Overview](kubernetes-101/overview.md)
    * [Understanding Kubernetes specific technical terms](kubernetes-101/technical-terms.md)
    * [kubectl usage for pentesters](kubernetes-101/kubectl.md)

* [Deploying simple application in Kubernetes Cluster](deploy-app/README.md)
    * [Using yaml manifest](deploy-app/using-yaml.md)
    * [Using helm chart](deploy-app/using-helm.md)

* [Scenario-1 - Exploiting Private Registry via Misconfiguration](scenario-1/README.md)
    * [Scenario](scenario-1/scenario.md)
    * [Solution](scenario-1/solution.md)
    * [Discussion](scenario-1/discussion.md)

* [Scenario-2 - Attacking Kubernetes Cluster Metadata using SSRF vulnerability](scenario-2/README.md)
    * [Scenario](scenario-2/scenario.md)
    * [Solution](scenario-2/solution.md)
    * [Discussion](scenario-2/discussion.md)

* [Scenario-3 - Testing for the sensitive configurations and secrets in Kubernetes cluster](scenario-3/README.md)
    * [Scenario](scenario-3/scenario.md)
    * [Solution](scenario-3/solution.md)
    * [Discussion](scenario-3/discussion.md)

* [Scenario-4 - Docker escape using Pod Volume Mounts to access the nodes and host systems](scenario-4/README.md)
    * [Scenario](scenario-4/scenario.md)
    * [Solution](scenario-4/solution.md)
    * [Discussion](scenario-4/discussion.md)

* [Scenario-5 - Attacking applications in different namespaces in Kubernetes cluster](scenario-5/README.md)
    * [Scenario](scenario-5/scenario.md)
    * [Solution](scenario-5/solution.md)
    * [Discussion](scenario-5/discussion.md)

* [Scenario-6 - Attacking Helm tiller without RBAC setup](scenario-6/README.md)
    * [Scenario](scenario-6/scenario.md)
    * [Solution](scenario-6/solution.md)
    * [Discussion](scenario-6/discussion.md)

* [Running kube-bench](kube-bench/readme.md)

* [Running kubesec](kubesec/readme.md)

* [Running kube-hunter](kube-hunter/readme.md)

* [Running kubeaudit](kubeaudit/readme.md)

* [Logging and Monitoring](logging-and-monitoring/readme.md)

* [Automated Security Defense using Sysdig Falco](automated-defense/readme.md)

* [DEMO's](demos/README.md)
    * [CVE-2018-1002105](demos/cve-2018-1002105.md)
    * [CVE-2019-5736](demos/cve-2019-5736.md)
    * [CVE-2019-9901](demos/cve-2019-9901.md)

* [Fun Learning About Kubernetes](extra/README.md)
    * [Contained.af](extra/contianed-af.md)
    * [Play with Docker](extra/play-with-docker.md)
    * [Katacoda Docker Security](extra/katacoda.md)
    * [Play with Kubernetes](extra/play-with-kubernetes.md)

* [Popular Attacks](popular-attacks/README.md)
    * [Dockerhub 190k accounts](popular-attacks/dockerhub-190k.md)
    * [Cryptojacking using public docker containers](popular-attacks/cryptojacking.md)
    * [Dockerhub known vulnerable images](popular-attacks/dockerhub.md)
    * [BSidesSF CTF cluster pwn](popular-attacks/service-token.md)
    * [Shopify metadata to cluster pwn](popular-attacks/metadata.md)

* [References & Resources](references-and-resources.md)

* [Terminology Glossary](terminology-glossary.md)

-----------
[License](about-us/license.md)
