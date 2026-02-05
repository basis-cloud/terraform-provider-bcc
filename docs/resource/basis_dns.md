# basis_dns (resource)

> [!NOTE]
> **DNS zone** creation, modification and deletion.

## Usage example

```hcl
data "basis_project" "single_project" {
    name = "Terraform Project"
}

resource "basis_dns" "dns" {
    name = "dns.terraform."
    project_id = data.basis_project.single_project.id
    tags = ["test_zone"]
}

```

**Schema. Required:**

*   `name` (String) — the DNS zone name;
*   `project_id` (String) — the project ID.

**Schema. Optional:**

*   `tags` (Toset, String) — the list of DNS zone tags.

**Schema. Read-only:**

*   `id` (String) — the DNS zone ID.