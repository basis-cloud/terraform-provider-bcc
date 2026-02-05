# basis_firewall_template_rule (resource)

> [!NOTE]
> A **firewall profile template rule** creation and managing.

> [!CAUTION]
> When importing the entity, specific considerations must be taken into account.

## Usage example

```hcl
data "basis_project" "single_project" {
    name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
    project_id = data.basis_project.single_project.id
    name = "Terraform VDC"
}

data "basis_firewall_template" "single_template" {
	vdc_id = data.basis_vdc.single_vdc.id
	name   = "New custom template"
}

resource "basis_firewall_template_rule" "rule_1" {
    firewall_id = data.basis_firewall_template.single_template.id
    name = "test1"
    direction = "ingress"
    protocol = "tcp"
    port_range = "80"
    destination_ip = "0.0.0.0"
}

```

**Schema. Required (for all rules):**

*   `firewall_id` (String) — the firewall profile template ID;
*   `name` (String) — the rule name;
*   `direction` (String) — the rule direction, it can be: `ingress` (incoming), `egress` (outgoing);
*   `protocol` (String) — the protocol, it can be: `udp`, `tcp`, `icmp`, `any` (any);
*   `destination_ip` (String) — the source or destination IP address.

**Schema. Optional:**

*   `port_range` (String) — can be a single port, a port range, e.g., `80:90`, or left empty.