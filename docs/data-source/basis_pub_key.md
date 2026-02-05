# basis_pub_key (data source)

> [!NOTE]
> Retrieves information about a **public key** for use in other resources.

## Usage example

```hcl
data "basis_account" "me"{}

data "basis_pub_key" "key" {
	account_id = data.basis_account.me.id
    
	name = "Debian 10"
	# or
	id = "id"
}

```

**Schema. Required:**

*   `name` (String) — the public key name or `id` (String) — the key ID;
*   `account_id` (String) — the account ID.

**Schema. Read-only:**

*   `fingerprint` (Integer) — the public key fingerprint;
*   `public_key` (Integer) — the public key value.