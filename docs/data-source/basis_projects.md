# basis_projects (data source)

> [!NOTE]
> Retrieves a list of user's **projects** for use in other resources.

## Usage example

```hcl
data "basis_projects" "all_projects" { }

```

**Schema. Read-only:**

*   `projects` (List of Object) (see nested schema below).

**Nested schema for** `projects`**. Read-only:**

*   `id` (String) — the project ID;
*   `name` (String) — the project name.