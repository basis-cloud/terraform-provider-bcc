terraform {
  required_version = ">= 1.0.0"

  required_providers {
    rustack = {
      source  = "pilat/rustack"
    }
  }
}

provider "rustack" {
  token = "[PLACE_YOUR_TOKEN_HERE]"
}

data "rustack_project" "single_project" {
  name = "Terraform Project"
}

data "rustack_hypervisor" "vmware" {
    project_id = resource.rustack_project.project1.id
    name = "VMware"
}

resource "rustack_vdc" "vdc" {
    name = "Vmware Terraform"
    project_id = resource.rustack_project.project1.id
    hypervisor_id = data.rustack_hypervisor.vmware.id
}

data "rustack_kubernetes_template" "kuber"{
    name = "Kubernetes 1.22.1"
    # or
    or = "id"
    vdc_id = resource.rustack_vdc.vdc1.id
    
}