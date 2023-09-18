# Deploying a Nomad Cluster on Linode with Terraform

This tutorial will guide you through the process of deploying a Nomad cluster on Linode using Terraform. 
Nomad is a cluster and job scheduler that can be used to orchestrate containerized and non-containerized applications. 

## Prerequisites
Before you begin, make sure you have the following prerequisites:

- Terraform installed on your local machine.
- A Linode account and an API token.
- Basic knowledge of Terraform and Linode.

## File Structure
```
/
    /linode
      main.tf
      outputs.tf
      terraform.tfvars
    /shared
      /config
        nomad.hcl
        nomad_client.hcl
        nomad.service
      /data-scripts
        user-data-server.sh
        user-data-client.sh
```

## Steps

### 1. Clone the Repo
Clone the repository containing the Terraform configuration and scripts:
```
git clone <repository-url>
cd <repository-directory>
```

