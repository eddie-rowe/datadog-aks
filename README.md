# Getting Started with Datadog on AKS

Datadog is a cloud monitoring platform that integrates with your infrastructure and gives you 
real-time visibility into your operations. With the Datadog Terraform provider, you can create 
custom monitors and dashboards for the resources you already manage, with or without Terraform, 
as well as new infrastructure automatically.

This repository allows you to explore Datadog observability features in Azure.

You will deploy an AKS cluster with Terraform, a demo application to the Kubernetes cluster 
with Helm, and install the Datadog agent across the cluster. 

The Datadog agent reports the cluster health back to your Datadog dashboard. 
You will then create a monitor for this cluster in Terraform.

## Requirements

- Active Azure account
- Active Datadog account
- Terraform v1.10+
- Azure CLI 2.69.0+
- kubectl
- kubelogin
- helm

## Deploy and Configure AKS infrastructure

1. Issue the ```az login``` command to authenticate your Azure account and select your desired subscription.
2. Verify your Azure account is authenticated with the ```az account list``` command. 
3. Issue the ```terraform init``` command from your working directory to download the necessary providers and initialize the backend.
4. Then, deploy the resources with ```terraform apply```. Confirm the run by entering `yes`.
- `Note: The Terraform deployment could take up to 15 minutes to complete.`
5. While your environment is being deployed, create an Entra group in Azure that contains members for your AKS cluster's `Cluster admin ClusterRoleBinding` role.
6. When the deployment has finished, go to your AKS cluster in the UI, click `Settings > Security configuration`, and scroll down to the `Authentication and Authorization` section.
7. Select your respective cluster admins group, then click `Apply`.
- `Note: The settings change will take a few minutes to complete.`

## Connect to your AKS cluster

5. Kubernetes stores cluster connection information in a file called `kubeconfig`. 
You can retrieve the Kubernetes configuration settings for your AKS cluster and merge them into 
your local `kubeconfig` file by issuing the following command:
```az aks get-credentials --resource-group $(terraform output -raw azure_rg_name) --name $(terraform output -raw aks_cluster_name) --admin```
6. Verify your Kubernetes cluster is active by issuing the following command:
```kubectl cluster-info```
 

## (Optional) Install Kubernetes plugin

1. helm repo add datadog https://helm.datadoghq.com
2. helm install datadog-operator datadog/datadog-operator
3. kubectl create secret generic datadog-secret --from-literal api-key=YOUR_API_KEY
4. Edit respective fields in `datadog-agent.yaml` file
5. kubectl apply -f datadog-agent.yaml


## Enable native Azure datadog integration

1. Retrieve your Datadog API and Application keys, then enter their respective values in the `variables.tf` file.
- `Note: Setting the Datadog permission scopes may be required for the application keys.`
2. Move the `datadog-monitor.tf` file from the `datadog` folder to the root directory (alongside the other .tf files)
3. 




## Clean up demo environment

1. Run the ```terraform destroy --auto-approve``` command to clean up all deployed resources.

## References

- [https://docs.datadoghq.com/getting_started/integrations/terraform/](https://docs.datadoghq.com/getting_started/integrations/terraform/)
- [https://registry.terraform.io/modules/Azure/aks/azurerm/latest](https://registry.terraform.io/modules/Azure/aks/azurerm/latest)
- [https://developer.hashicorp.com/terraform/tutorials/use-case/datadog-provider](https://developer.hashicorp.com/terraform/tutorials/use-case/datadog-provider)
- [https://docs.datadoghq.com/integrations/guide/azure-native-programmatic-management/](https://docs.datadoghq.com/integrations/guide/azure-native-programmatic-management/)
- [https://www.datadoghq.com/blog/azure-datadog-partnership/#get-started-today](https://www.datadoghq.com/blog/azure-datadog-partnership/#get-started-today)