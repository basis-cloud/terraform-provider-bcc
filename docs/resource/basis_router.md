# basis_router (resource)

> [!NOTE]
> Creating and managing a **router** for connecting two or more servers and for connecting to networks.

## Usage example

```hcl
data "basis_project" "single_project" {
    name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
    project_id = data.basis_project.single_project.id
    name = "Terraform VDC"
}

data "basis_network" "default_network" {
     vdc_id = data.basis_vdc.single_vdc.id
     name = "Network"
}

resource "basis_port" "router_port" {
    vdc_id = data.basis_vdc.single_vdc.id
    network_id = data.basis_network.default_network.id
}

resource "basis_router" "new_router" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "New router"   
    ports = [resource.basis_port.router_port.id]
    routes {
		destination = "10.0.2.0/24"
		next_hop = "10.0.1.2"
	}
    
    floating = false
    tags = ["test"]
}

```

**Schema. Required:**

*   `name` (String) — the router name;
*   `ports` (Toset, String) — the list of ID of network ports to which the router will be connected;  
    
    ```hcl
    ports = [
    	resource.basis_port.router_port1.id,
    	resource.basis_port.router_port2.id
    ]   
    
    ```
    
*   `vdc_id` (String) — the VDC ID.

**Schema. Optional:**

*   `is_default` (Bool) — set to `true` to make the router a service router.  
> [!NOTE]
> Only one router in a VDC can be a service router.
    
*   `routes` (Block List) — a block containing a router route. A separate `routes` block is defined for each route (see nested schema below).
*   `floating` (Bool) — attaches a public IP address to the router. Default is `floating = false`.
*   `tags` (Toset, String) — the list of router tags.

**Schema. Read-only:**

*   `id` (String) — the router ID;
*   `floating_id` (String) — the public IP address ID.

**Nested schema for** `routes`**. Required:**

*   `destination` (String) — the destination CIDR;
*   `next_hop` (String) — the gateway IP address for the next hop.