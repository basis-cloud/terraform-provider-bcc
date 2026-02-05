# basis_firewall_template (resource)

> [!NOTE]
> A **firewall profile template** creation and managing.

## Usage example

```hcl
data "basis_project" "single_project" {
    name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
    project_id = data.basis_project.single_project.id
    name = "Terraform VDC"
}

resource "basis_firewall_template" "single_template" {
	vdc_id = data.basis_vdc.single_vdc.id
	name = "New custom template"
	tags = ["test"]
}

```

**Schema. Required:**

*   `name` (String) — the firewall profile template name;
*   `vdc_id` (String) — the VDC ID.

**Schema. Optional:**

*   `tags` (Toset, String) — the list of firewall profile template tags.