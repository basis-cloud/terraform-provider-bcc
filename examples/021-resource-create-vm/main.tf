terraform {
  required_version = ">= 1.0.0"

  required_providers {
    basis = {
      source  = "basis-cloud/bcc"
    }
  }
}

provider "basis" {
    token = "[PLACE_YOUR_TOKEN_HERE]"
}

data "basis_project" "single_project" {
    name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
    project_id = data.basis_project.single_project.id
    name = "Terraform VDC"
}

data "basis_network" "service_network" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "Сеть"
}

data "basis_storage_profile" "ssd" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "SSD"
}

data "basis_template" "debian10" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "Ubuntu 22.04"
}

data "basis_firewall_template" "allow_default" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "Разрешить исходящие"
}

data "basis_firewall_template" "allow_web" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "Разрешить WEB"
}

data "basis_firewall_template" "allow_ssh" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "Разрешить SSH"
}

data "basis_disk" "disk1" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "Диск 1"
}

data "basis_disk" "disk2" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "Диск 2"
}

resource "basis_port" "vm_port" {
    vdc_id = data.basis_vdc.single_vdc.id

    network_id = data.basis_network.service_network.id
    firewall_templates = [data.basis_firewall_template.allow_default.id,
                          data.basis_firewall_template.allow_web.id,
                          data.basis_firewall_template.allow_ssh.id]
}

resource "basis_vm" "vm1" {
    vdc_id = data.basis_vdc.single_vdc.id

    name = "Server 1"
    cpu = 2
    ram = 4

    template_id = data.basis_template.debian10.id

    user_data = file("user_data.yaml")

    system_disk {
        size = 10
        storage_profile_id = data.basis_storage_profile.ssd.id
    }

    disks = [
        data.basis_disk.disk1.id,
        data.basis_disk.disk2.id,
    ]      
    
    networks {
        id = resource.basis_port.vm_port.id
    } 

    power = true
    floating = false
    tags = ["test"]
}
