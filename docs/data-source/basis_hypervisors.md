# basis_hypervisors (data source)

> [!NOTE]
> Retrieves a list of **resource pools** available in a project for use in other resources.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_hypervisors" "all_hypervisors" {
	project_id = data.basis_project.single_project.id
}

```

**Schema. Required:**

*   `project_id` (String) — the project ID.

**Schema. Read-only:**

*   `hypervisors` (List of Object) (see nested schema below).

**Nested schema for** `hypervisors`**. Read-only:**

*   `id` (String) — the resource pool ID;
*   `name` (String) — the resource pool name;
*   `type` (String) — the resource pool type.