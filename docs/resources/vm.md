---
page_title: "basis_vm Resource - terraform-provider-bcc"
---
# basis_vm (Resource)

This data source provides creating and deleting vms. You should have a vdc to create a vm.

## Example Usage

```hcl 
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
```

## Schema

### Required

- **template_id** (String) id of the Template
- **vdc_id** (String) id of the VDC
- **name** (String) name of the Vm
- **cpu** (Integer) the number of virtual cpus
- **ram** (Float) memory of the Vm in gigabytes
- **user_data** (String) script for cloud-init
- **system_disk** System disk (Min: 1, Max: 1). (see [below for nested schema](#nestedblock--system_disk))

### Optional

- **floating** (Boolean) enable floating ip for the Vm
- **disks** (Toset, String) list of Disks id attached to the Vm.
- **power** (Boolean) the vm state
- **tags** (Toset, String) list of Tags added to the Vm
- **networks** (Block List) a block with the ID of the port connected to the server. A separate `networks` block is set for each port (see [below for nested schema](#nestedblock--network)). If necessary, you can create a server without a network connection.
  
```hcl
networks {
    id = resource.basis_port.vm_port1.id
}

networks {
    id = resource.basis_port.vm_port2.id
}
```
  
- (Deprecated) **ports** (List of String) list of Ports id attached to the Vm.

### Read-Only

- **floating_ip** (String) floating ip for the Vm. May be omitted
- **id** (String) The ID of this resource.



<a id="nestedblock--system_disk"></a>
### Nested Schema for `system_disk`

Required:

- **size** (Integer) the size of the Disk in gigabytes
- **storage_profile_id** (String) Id of the storage profile

Read-Only:

- **id** (String) id of the Disk
- **name** (String) name of the Disk
- **external_id** (String) the external id of the Disk used at hypervisor

<a id="nestedblock--network"></a>
### Nested Schema for `network`

Required:

- **id** (String) id of the Port

Read-Only:

- **ip_address** (String) IP of the Port
