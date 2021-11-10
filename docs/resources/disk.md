---
page_title: "rustack_disk Resource - terraform-provider-rustack"
---
# rustack_disk (Resource)

Provides a Rustack disk volume which can be attached to a VM in order to provide expanded storage.

## Example Usage

```hcl

data "rustack_project" "single_project" {
    name = "Terraform Project"
}

data "rustack_vdc" "single_vdc" {
    project_id = "${data.rustack_project.single_project.id}"
    name = "Terraform VDC"
}

data "rustack_storage_profile" "single_storage_profile" {
    vdc_id = data.rustack_vdc.single_vdc.id
    name = "sas"
}

resource "rustack_disk" "disk2" {
    count = 3

    vdc_id = data.rustack_vdc.single_vdc.id

    name = format("Диск %s", count.index + 1)
    storage_profile_id = data.rustack_storage_profile.single_storage_profile.id
    size = 1
}
```

## Schema

### Required

- **name** (String) name of the Disk
- **size** (Number) the size of the Disk in gigabytes
- **storage_profile_id** (String) Id of the storage profile
- **vdc_id** (String) id of the VDC

### Optional

- **timeouts** (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))

### Read-Only

- **id** (String) id of the Disk

<a id="nestedblock--timeouts"></a>
### Nested Schema for `timeouts`

Optional:

- **create** (String)
- **delete** (String)
