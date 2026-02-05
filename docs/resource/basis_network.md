# basis_network (resource)

> [!NOTE]
> Creating and managing a **network** for connection two or more servers.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

resource "basis_network" "network1" {
	vdc_id = data.basis_vdc.single_vdc.id

	name = "Network 1"

	subnets {
        cidr = "10.20.1.0/24"
        dhcp = true
        gateway = "10.20.1.1"
        start_ip = "10.20.1.2"
        end_ip = "10.20.1.254"
        dns = ["77.88.8.8", "77.88.8.1"]
    }
	tags = ["test"]
}

```

**Schema. Required:**

*   `name` (String) — the network name;
*   `subnets` (Block List, Min: 1, Max: 1) — the subnet (see nested schema below);
*   `vdc_id` (String) — the VDC ID.

**Schema. Optional:**

*   `mtu` (Integer) — the maximum size of a data packet transmitted over the network;
*   `tags` (Toset, String) — the list of network tags.

**Schema. Read-only:**

*   `id` (String) — the network ID.

**Nested schema for** `subnets`**. **Required:**

*   `cidr` (String) — the subnet CIDR in the format X.X.X.X/X (in **Dynamix VDC** and **RUSTACK VDC** the maximum subnet prefix is /29, in **VMware VDC** it's /30); after network creation, the CIDR cannot be changed, but the range of allocated IP addresses can be modified. To set a different CIDR, the network must be recreated.  
> [!CAUTION]
> Creating networks with the address 0.0.0.0 is prohibited!
    
> [!CAUTION]
> In the **DXE virtualization platform (Dynamix VDC)**, networks can be created **only** from the ranges 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 (based on [RFC 1918](https://datatracker.ietf.org/doc/html/rfc1918#section-3)).
    
*   `dhcp` (Boolean) — indicates whether DHCP is enabled for the subnet, values `true` or `false`;  
> [!NOTE]
> When this flag is set, virtual servers will automatically receive network configuration from the DHCP server: IP address, subnet mask, default gateway, and DNS configuration.
    
*   `gateway` (String) — the gateway IP address for the subnet; after network creation, the gateway IP address cannot be changed. To set a different gateway IP address, the network must be recreated.  
> [!NOTE]
> In the **DXE virtualization platform (Dynamix VDC)**, the default gateway IP is not the first available address in the subnet, but the second, because the first is occupied by the system router in the DXE.
> In the **DXE virtualization platform (Dynamix VDC)** and **VMware vSphere virtualization platform (VMware VDC)**, when a network is connected to a router, the subnet gateway will take the value of the router's address in that network.
    
*   `start_ip` (String) — the start IP address of the subnet allocation pool;
*   `end_ip` (String) — the end IP address of the subnet allocation pool;

**Nested schema for** `subnets`**. Optional:**

*   `dns` (List of String) — the list of DNS servers for the subnet.

**Nested schema for** `subnets`**. **Read-only:**

*   `id` (String) — the subnet ID.