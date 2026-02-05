# basis_kubernetes_templates (data source)

> [!NOTE]
> Retrieves a list of **Kubernetes templates** for use in other resources.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_kubernetes_templates" "k8s_templates" {
	vdc_id = data.basis_vdc.single_vdc.id
}

```

**Schema. Required:**

*   `vdc_id` (String) — the VDC ID.

**Schema. Read-only:**

*   `kubernetes_templates` (List of Object) — the list of Kubernetes templates (see nested schema below).

**Nested schema for** `kubernetes_templates`**. Read-only:**

*   `id` (String) — the template ID;
*   `name` (String) — the template name;
*   `min_node_cpu` (Integer) — the required minimum number of virtual CPU for the template;
*   `min_node_hdd` (Integer) — the required minimum disk size for the template in GB;
*   `min_node_ram` (Integer) — the required minimum amount of RAM for the template in GB.