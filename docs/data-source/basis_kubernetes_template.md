# basis_kubernetes_template (data source)

> [!NOTE]
> Retrieves information about a **Kubernetes template** for use in other resources.

> [!CAUTION]
> If a query of data source is performed by the template `name` and the template name is not unique, this method will return an error.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_kubernetes_template" "k8s_template" {
	vdc_id = data.basis_vdc.single_vdc.id
    
	name = "Kubernetes 1.22.1"
	# or
	id = "id"
}

```

**Schema. Required:**

*   `name` (String) — the Kubernetes template name or `id` (String) — the template ID;
*   `vdc_id` (String) — the VDC ID.

**Schema. Read-only:**

*   `min_node_cpu` (Integer) — the required minimum number of virtual CPU for the template;
*   `min_node_hdd` (Integer) — the required minimum disk size for the template in GB;
*   `min_node_ram` (Integer) — the required minimum amount of RAM for the template in GB.