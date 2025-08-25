---
page_title: "basis_dns Resource - terraform-provider-bcc"
---
# basis_dns (Resource)

Provides a Basis DNS resource.

## Example Usage

```hcl
data "basis_project" "single_project" {
    name = "Terraform Project"
}

resource "basis_dns" "dns" {
    name="dns.teraform."
    project_id = data.basis_project.single_project.id
    tags = ["created_by:terraform"]
}
```

## Schema

### Required

- **name** (String) name of the Dns
- **project_id** (String) id of the Project

### Optional

- **tags** (Toset, String) list of Tags added to the Dns

### Read-Only

- **id** (String) id of the Disk