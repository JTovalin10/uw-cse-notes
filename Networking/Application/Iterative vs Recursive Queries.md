# CSE461: Iterative vs. Recursive DNS Queries

DNS resolution can follow one of two query strategies depending on where the resolution work is performed.

## Recursive Query

- The nameserver that receives the query performs the complete resolution and returns the **final answer**
- Example: a client's stub resolver sends a recursive query to its **local nameserver**, which does all the work
- Benefits:
	- Offloads the resolution burden from simple clients (stub resolvers)
	- The local nameserver can cache results over a pool of clients, improving performance for the whole organization

## Iterative Query

- The nameserver returns either the **answer** or a **referral** — the address of the next nameserver to contact
- Example: the local nameserver queries the Root, which returns a referral to the TLD; the local nameserver then queries the TLD, and so on
- Benefits:
	- Each nameserver can "fire and forget" — no need to hold state while waiting for a recursive sub-query
	- Easier to build high-load servers

## Typical Pattern

1. Client → Local Nameserver: **Recursive** (client wants a final answer)
2. Local Nameserver → Root/TLD/Authoritative: **Iterative** (local server does the walking)

## Related
- [[Domain Name System (DNS)]] — full DNS overview
- [[Local Nameservers]] — the resolver that receives the client's recursive query
- [[Root Nameservers]] — the first stop in iterative resolution
- [[Caching]] — resolved answers are cached at each step for the TTL duration
