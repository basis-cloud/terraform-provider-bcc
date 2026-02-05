# basis_project (data source)

> [!NOTE]
> Retrieves information about a **project** for use in other resources.

> [!CAUTION]
> If a query of data source is performed by the project `name` and the project name is not unique, this method will return an error.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
	# or
	id = "id"
}

```

**Schema. Required:**

*   `name` (String) — the project name or `id` (String) — the project ID.