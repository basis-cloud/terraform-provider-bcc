# basis_hypervisor (data source)

> [!NOTE]
> Retrieves information about a **resource pool** for use in other resources.

> [!CAUTION]
> If a query of data source is performed by the resource pool `name` and the resource pool name is not unique, this method will return an error.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_hypervisor" "single_hypervisor" {
	project_id = data.basis_project.single_project.id
	name = "VMWARE"
	# or
	id = "id"
}

```

**Schema. Required:**

*   `name` (String) — the resource pool name or `id` (String) — the resource pool ID;
*   `project_id` (String) — the project ID.

**Schema. Read-only:**

*   `type` (String) — the resource pool type.