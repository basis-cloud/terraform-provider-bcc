# basis_vdcs (data source)

> [!NOTE]
> Retrieves a list of **VDC** available in a project for use in other resources.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdcs" "all_vdcs" {
	project_id = data.basis_project.single_project.id
}

```

**Schema. Required:**

*   `project_id` (String) — the project ID.

**Schema. Read-only:**

*   `vdcs` (List of Object) (see nested schema below).

**Nested schema for** `vdcs`**. Read-only:**

*   `hypervisor` (String) — the resource pool name;
*   `hypervisor_type` (String) — the resource pool type;
*   `id` (String) — the VDC ID;
*   `name` (String) — the VDC name.