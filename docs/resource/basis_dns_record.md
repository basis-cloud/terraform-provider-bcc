# basis_dns_record (resource)

> [!NOTE]
> A **DNS zone record** creation, modification and deletion.

> [!CAUTION]
> When importing the entity, specific considerations must be taken into account.

## Usage example

```hcl
data "basis_project" "single_project" {
    name = "Terraform Project"
}

data "basis_dns" "dns" {
    name="dns.terraform."
    project_id = data.basis_project.single_project.id
}

# A record for the DNS zone (AAAA, CNAME, NS, TXT records are created similarly)
resource "basis_dns_record" "dns_record1" {
    dns_id = data.basis_dns.dns.id
    type = "A"
    host = "test.testme.com."
    data = "10.0.1.1"
    ttl = "86400"
}
 
# CAA record for the DNS zone
resource "basis_dns_record" "dns_record2" {
    dns_id = data.basis_dns.dns.id
    type = "CAA"
    host = "test2.testme.com."
    data = "10.0.1.2"
    ttl = "86400"
    tag = "issue"
    flag = "128"
}
 
# MX record for the DNS zone
resource "basis_dns_record" "dns_record3" {
    dns_id = data.basis_dns.dns.id
    type = "MX"
    host = "test3.testme.com."
    data = "10.0.1.2"
    ttl = "86400"
    priority = "1"
}

```

**Schema. Required (for all record types):**

*   `dns_id` (String) — the DNS zone ID;
*   `type` (String) — the DNS record type;
*   `host` (String) — the DNS record host;
*   `data` (String) — the DNS record data.

**Schema. Also required for CAA records:**

*   `tag` (String) — the DNS record tag;
*   `flag` (String) — the DNS record flag. Can be 0 (not critical) or 128 (critical).

**Schema. Also required for MX records:**

*   `priority` (String) — the DNS record priority.

**Schema. Also required for SRV records**

*   `priority` (String) — the DNS record priority;
*   `weight` (String) — the DNS record weight;
*   `port` (String) — the DNS record port.

**Schema. Read-only:**

*   `id` (String) — the DNS record ID.