---
page_title: "basis_kubernetes Data Source - terraform-provider-bcc"
---
# basis_kubernetes (Data Source)

Get information about a Kubernetes for use in other resources. 
This is useful if you need to utilize any of the Kubernetes's data and Kubernetes not managed by Terraform.

**Note:** This data source returns a single Kubernetes. When specifying a `name`, an
error is triggered if more than one Kubernetes is found.

## Example Usage

```hcl

data "basis_project" "single_project" {
    name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
    project_id = data.basis_project.single_project.id
    name = "Terraform VDC"
}

data "basis_kubernetes" "single_k8s" {
    vdc_id = data.basis_vdc.single_vdc.id
    
    name = "Server 1"
    # or
    id = "id"
}

```

## Schema

### Required

- **name** (String) name of the Kubernetes `or` **id** (String) id of the Kubernetes
- **vdc_id** (String) id of the VDC

### Read-Only



## Getting information about kubernetes

### Get dashboard url
- **This block will print dashboard_url in console**
```
    output "dashboard_url" {
        value = data.basis_kubernetes.single_k8s.dashboard_url
    }
```
### Get kubectl config
- **When kubernetes is received, the kubectl configuration will appear in the workdir folder.**
