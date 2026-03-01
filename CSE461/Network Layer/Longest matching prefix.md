# Longest Matching Prefix

Provides default behavior with less specificity:
- Send traffic going outside an organization to a border router (gateway)
- Can special-case behavior with more specificity
	- For performance, economics, security

## Performance

Uses hierarchy for a compact table; relies on use of large prefixes.

Lookup is more complex than a simple table lookup — must compare destination IP against all prefixes and pick the **longest** match when prefixes overlap (e.g., /24 and /16 both match; /24 wins). Uses data structures like the Patricia tree (see [[Classless Interdomain Routing (CIDR)]]) for efficient prefix search.
