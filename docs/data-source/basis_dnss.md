# basis_dnss (data source)

> [!NOTE]
> Retrieves a list of `DNS zones` contained within a project for use in other resources.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_dnss" "all_dns" {
	project_id = data.basis_project.single_project.id
}

```

**Schema. Required:**

*   `project_id` (String) — the project ID.

**Schema. Read-only:**

*   `dnss` (List of Object) — list of DNS zones (see nested schema below).

**Nested schema for** `dnss`**. Read-only:**

*   `name` (String) — the DNS zone name;
*   `id` (String) — the DNS zone ID.