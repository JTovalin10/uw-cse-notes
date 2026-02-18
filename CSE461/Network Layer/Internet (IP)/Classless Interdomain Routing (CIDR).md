## Classless Interdomain Routing (CIDR)
An alternative to [[Subnetting]] called **supernetting** or **Classless Interdomain Routing (CIDR)**.

CIDR removes address classes and creates one single supernet to address space efficiently.

This is more relevant when we need more hosts than one class can support but not enough to utilize another class (which would be wasteful).

### Solution
CIDR creates **aggregate routes**, which let us use a single entry in a [[Forwarding Table]] to tell us how to reach a lot of different networks.

This then requires a new type of notation to represent network numbers (prefixes), where we place a `/X` after the prefix where X is the prefix length in bits.

![[Pasted image 20260215023753.png]]

### Issue: Overlapping Prefixes
We could have overlap in the table where one packet matches two different prefixes. We resolve this using the **longest prefix match** rule, where the packet matches the longest (most specific) prefix. We can use an approach called a **Patricia tree** to implement this efficiently.

See also: [[Subnetting]], [[IP Global Addresses]], [[IP Datagram Forwarding]]
