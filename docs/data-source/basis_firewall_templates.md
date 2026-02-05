# basis_firewall_templates (data source)

> [!NOTE]
> Retrieves a list of **firewall profile templates** for use in other resources.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_firewall_templates" "all_templates" {
	vdc_id = data.basis_vdc.single_vdc.id
}

```

**Schema. Required:**

*   `vdc_id` (String) — the VDC ID.

**Schema. Read-only:**

*   `firewall_templates` (List of Object) (see nested schema below).

**Nested schema for** `firewall_templates`**. Read-only:**

*   `id` (String) — the firewall profile template ID;
*   `name` (String) — the firewall profile template name.