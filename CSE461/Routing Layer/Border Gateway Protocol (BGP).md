BGP is the interdomain routing protocol used in the Internet
- different parties like [[Internet Service Provider (ISP)]]s are called [[Autonomous System (AS)|Autonomous Systems (AS)]]
- Border routers of ASes announce BGP routes to each other
- route announcements contain an IP prefix, [[Path Vector|path vector]], [[Next Hop Router|next hop]]
	- [[Path Vector|path vector]] is list of ASes on the way to the prefix; used to detect loops
- route announcements move in the opposite direction to traffic — BGP advertises "I can reach prefix X" toward the source of the route; data packets then flow in the advertised direction

## Sending (path preference when forwarding)

The goal of an [[Internet Service Provider (ISP)]] is to make money. When choosing which path to use for forwarding, prefer paths that make money over paths that cost money.

| Path type | Economics | Preference |
|-----------|-----------|------------|
| **[[AS Relationships and Policies#Provider–Customer\|Customer]]** (send down) | Get paid to deliver | Most preferred |
| **[[AS Relationships and Policies#Peer\|Peer]]** (send sideways) | Free, but no revenue | Neutral |
| **[[AS Relationships and Policies#Customer–Provider\|Provider]]** (send up) | Costs money to send | Last resort |

**Order: Customer > Peer > Provider** — implemented via **LOCAL_PREF** (BGP local preference attribute; higher value = more preferred) or **route maps** (configuration that sets attributes based on policy).

- Peer constraint: Can send directly to a peer (A→B), but won't transit traffic through a peer to reach another peer (A→B→C). Peers don't transit for free.
- If traffic arrived from a customer (ISP already got paid), they're more willing to pay the provider path to complete delivery.

## Export policy (who do we advertise routes to?)

| Learned from | Advertise to |
|--------------|--------------|
| **[[AS Relationships and Policies#Provider–Customer\|Customer]]** | Everyone (customers, peers, providers) |
| **[[AS Relationships and Policies#Peer\|Peer]]** | Customers only (not to other peers or providers — avoid free transit) |
| **[[AS Relationships and Policies#Customer–Provider\|Provider]]** | Customers only (not to other providers or peers — avoid carrying transit for free) |

## Policy
1. Border routers of ISP announce paths only to other parties who may use those paths
2. Border routers of ISP select the best path of the ones they hear in any (non-shortest) way — policy overrides shortest path

## See also
- [[BGP Mechanics]] — [[BGP Mechanics#Path Vector|path vector]], [[BGP Mechanics#AS types|AS types]], packet format, BGP over TCP
- [[AS Relationships and Policies]] — [[AS Relationships and Policies#Provider–Customer|provider policy]], [[AS Relationships and Policies#Customer–Provider|customer policy]], [[AS Relationships and Policies#Peer|peer policy]]