# basis_paas_template (data source)

> [!NOTE]
> Retrieves information about a **platform service template** for use in other resources.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "PaaS Project"
}

data "basis_paas_template" "db_template" {
	id = 1
	vdc_id = data.basis_vdc.single_vdc.id
}

```

**Schema. Required:**

*   `name` (String) — the template name or `id` (Integer) — the template ID;
*   `vdc_id` (String) — the VDC ID.