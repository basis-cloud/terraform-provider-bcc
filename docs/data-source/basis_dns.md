# basis_dns (data source)

> [!NOTE]
> Retrieves information about a **DNS zone** for use in other resources.

> [!CAUTION]
> If a query of data source is performed by the domain zone `name` and the domain zone name is not unique, this method returns an error.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_dns" "dns" {
	name = "dns.terraform."
	# or
	id = "id"
    
	project_id = data.basis_project.single_project.id
}

```

**Schema. Required:**

*   `project_id` (String) — the project ID;
*   `name` (String) — the DNS zone name or `id` (String) — the DNS zone ID.