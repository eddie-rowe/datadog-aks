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

## Deploy AKS infrastructure

1. Issue the ```az login``` command to authenticate your Azure account and select your desired subscription.
2. Verify your Azure account is authenticated with the ```az account list``` command. 
3. Issue the ```terraform init``` command from your working directory to download the necessary providers and initialize the backend.
4. Then, deploy the resources with ```terraform apply```. Confirm the run by entering `yes`.
- `Note: The Terraform deployment could take up to 15 minutes to complete.`
5. Kubernetes stores cluster connection information in a file called `kubeconfig`. 
You can retrieve the Kubernetes configuration settings for your AKS cluster and merge them into 
your local `kubeconfig` file by issuing the following command:
```az aks get-credentials --resource-group $(terraform output -raw azure_rg_name) --name $(terraform output -raw aks_cluster_name)```
`Merged "9ffe71e726e0621d-aks" as current context in C:\Users\eddie\.kube\config`
6. Verify your Kubernetes cluster is active by issuing the following command:
```kubectl cluster-info```
`expected output`
 

## Enable native Azure datadog integration

1. Retrieve your Datadog API and APP keys, then enter their respective values in the `datadog-creds.tfvars` file.
2. 




## Clean up demo environment

1. Run the ```terraform destroy --auto-approve``` command to clean up all deployed resources.

## References

- [https://docs.datadoghq.com/getting_started/integrations/terraform/](https://docs.datadoghq.com/getting_started/integrations/terraform/)
- [https://registry.terraform.io/modules/Azure/aks/azurerm/latest](https://registry.terraform.io/modules/Azure/aks/azurerm/latest)
- [https://developer.hashicorp.com/terraform/tutorials/use-case/datadog-provider](https://developer.hashicorp.com/terraform/tutorials/use-case/datadog-provider)
- [https://docs.datadoghq.com/integrations/guide/azure-native-programmatic-management/](https://docs.datadoghq.com/integrations/guide/azure-native-programmatic-management/)
- [https://www.datadoghq.com/blog/azure-datadog-partnership/#get-started-today](https://www.datadoghq.com/blog/azure-datadog-partnership/#get-started-today)