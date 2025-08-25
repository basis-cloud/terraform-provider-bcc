---
page_title: "basis_paas_template Data Source - terraform-provider-bcc"
---
# basis_paas_template (Data Source)

Get information about a PaaS Service Template for use in other resources. 

## Example Usage

```hcl
resource "basis_project" "project" {
  name = "terraform paas"
}

data "basis_hypervisor" "hypervisor" {
  project_id = resource.basis_project.project.id
  name = "Рустэк"
}

resource "basis_vdc" "vdc_rustack" {
  name = "terraform Рустэк"
  project_id = resource.basis_project.project.id
  hypervisor_id = data.basis_hypervisor.hypervisor.id
}

data "basis_paas_template" "nginx_template" {
  id = 5
  vdc_id = resource.basis_vdc.vdc_rustack.id
}
```
## Schema

### Required

- **name** (String) name of the disk `or` **id** (String) id of the disk
- **vdc_id** (String) id of the VDC
