---
page_title: "basis_vdc Resource - terraform-provider-bcc"
---
# basis_vdc (Resource)

Provides a Basis VDC resource to determinate hipervisor to use.

## Example Usage

```hcl
data "basis_project" "single_project" {
    name = "Terraform Project"
}

data "basis_hypervisor" "single_hypervisor" {
    project_id = data.basis_project.single_project.id
    name = "VMWARE"
}

resource "basis_vdc" "vdc1" {
    name = "Terraform VDC"
    project_id = data.basis_project.single_project.id
    hypervisor_id = data.basis_hypervisor.single_hypervisor.id
}
```

## Schema

### Required

- **hypervisor_id** (String) id of the Hypervisor
- **name** (String) name of the VDC
- **project_id** (String) id of the Project

### Optional

- **id** (String) The ID of this resource.
- **tags** (Toset, String) list of Tags added to the VDC.
- **default_network_mtu** (Integer) maximum transmission unit for the default network of the vdc

### Read-only

- **default_network_id** (String) id of the default network of the vdc
- **default_network_name** (String) name of the default network of the vdc
- **default_network_subnets** (Block List) (see [below for nested schema](#nestedblock--subnets))

<a id="nestedblock--subnets"></a>
### Nested Schema for `subnets`

Read-Only:
- **id** (String)
- **cidr** (String)
- **gateway** (String)
- **start_ip** (String)
- **end_ip** (String)
- **dhcp** (Boolean)
- **dns** (List of String)
