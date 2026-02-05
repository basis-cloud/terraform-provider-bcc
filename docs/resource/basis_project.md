# basis_project (resource)

> [!NOTE]
> A **project** creation and managing. A **project** allows to organize resources into groups as desired. A VDC is associated with projects.

## Usage example

```hcl
resource "basis_project" "tf_project" {
	name = "Terraform Project"
	tags = ["demo"]
}

```

**Schema. Required:**

*   `name` (String) — the project name.

**Schema. Optional:**

*   `tags` (Toset, String) — the list of project tags.

**Schema. Read-only:**

*   `id` (String) — the project ID.