# basis_account (data source)

> [!NOTE]
> Retrieves information about the **account** for use in other resources. The account is identified by the user's token.

## Usage example

```hcl
data "basis_account" "account" { }

```

**Schema. Read-only:**

*   `email` (String) — the user's email address;
*   `id` (String) — the user's unique ID;
*   `username` (String) — the username.