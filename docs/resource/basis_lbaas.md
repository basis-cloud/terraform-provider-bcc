# basis_lbaas (resource)

> [!NOTE]
> A **load balancer** creation, modification and deletion.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

resource "basis_network" "network2" {
	vdc_id = data.basis_vdc.single_vdc.id
	name = "Network 2"
	subnets {
		cidr = "10.20.1.0/24"
		dhcp = true
		gateway = "10.20.1.1"
		start_ip = "10.20.1.2"
		end_ip = "10.20.1.254"
		dns = ["77.88.8.8", "77.88.8.1"]
	}
}

resource "basis_port" "router_port" {
	vdc_id = data.basis_vdc.single_vdc.id
	network_id = resource.basis_network.network2.id
}

resource "basis_router" "router2" {
	vdc_id = data.basis_vdc.single_vdc.id
	name = "Router 2"   
	ports = [
		resource.basis_port.router_port.id
	]   
	floating = true
}

resource "basis_lbaas" "lbaas" {
	vdc_id = data.basis_vdc.single_vdc.id
	name = "lbaas"
	port {
		network_id = resource.basis_network.network2.id
		ip_address = "10.20.1.10"
	}
	floating = true
	tags = ["test"]
	depends_on = [basis_router.router2]
}

```

**Schema. Required:**

*   `vdc_id` (String) — the VDC ID;
*   `name` (String) — the load balancer name;
*   `port` (Schema) — specifies the network to which the load balancer is connected (see nested schema below).

**Schema. Optional:**

*   `floating` (Boolean) — attaching a public IP address to the load balancer. Default is `floating = false`.
> [!CAUTION]
> If a load balancer with a public IP address is planned to create, the parameter `depends_on = [basis_router.name]` must be set, where `name` is the router name in the network to which the load balancer will be connected.
> If the load balancer is created in the VDC service network, this parameter is optional.
    
*   `tags` (Toset, String) — the list of load balancer tags.

**Nested schema for** `port`**. Required:**

*   `network_id` (String) — the network ID.

**Nested schema for** `port`**. Optional:**

*   `ip_adress` (String) — the load balancer port IP address.