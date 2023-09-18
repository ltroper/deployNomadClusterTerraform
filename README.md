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
git clone https://github.com/ltroper/deployNomadClusterTerraform.git
cd /linode
```

### 2. Configure TF Variables
Create a terraform.tfvars file to set your desired configuration variables such as region, token, instance types, and counts:
```
region = "us-east"  # Replace with your desired Linode region code (e.g., "us-east").
token  = "YOUR_LINODE_API_TOKEN"
name                 = "nomad"
server_instance_type = "g6-standard-2"
server_count         = 3
client_instance_type = "g6-standard-2"
client_count         = 2
```
### 3. Deploy Nomad Cluster
Run the following commands to initialize Terraform and deploy the Nomad cluster:
```
terraform init
terraform apply
```
Terraform will provision Linode instances and configure them as Nomad servers and clients based on your configuration.

### 4. Access the Nomad UI
Once the deployment is complete, you can access the Nomad UI by navigating to:
```
http://<server-ip>:4646/ui
```
Replace <server-ip> with the IP address of one of your Nomad servers.

### 5. Configure Nomad
Follow the steps lined out in the TF output to configure Nomad, export the management token, and test connectivity.

## Additional Configuration
You can customize the Nomad and system configurations by modifying the config and data-scripts directories. Make sure to update the nomad.hcl, nomad_client.hcl, and nomad.service files to suit your specific requirements.

## Conclusion
You have successfully deployed a Nomad cluster on Linode using Terraform. You can now use this cluster to schedule and manage your applications and jobs. For more information on configuring and using Nomad, refer to the [Nomad documentation]([url](https://developer.hashicorp.com/nomad)https://developer.hashicorp.com/nomad).
