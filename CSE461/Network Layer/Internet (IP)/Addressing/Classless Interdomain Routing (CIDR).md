An alternative to classful addressing that removes fixed address classes entirely, replacing them with variable-length prefixes. Also called **supernetting**.

CIDR is useful when you need more hosts than one class supports but not so many that the next class up would be wasteful — instead of assigning a whole class, you assign exactly the prefix length you need.

## Aggregate Routes

CIDR lets a single [[Forwarding Table]] entry cover many networks using an **aggregate route**. Prefixes are written as `address/length` (e.g., `192.168.0.0/16`), where the length is the number of network bits.

![[Pasted image 20260215023753.png]]

## Overlapping Prefixes

Because prefix lengths are flexible, a destination [[IP Address]] may match multiple entries in the forwarding table. This is resolved by [[Longest Prefix Match]] — the most specific (longest) matching prefix wins.

See also: [[IP Address]], [[Longest Prefix Match]], [[Subnetting]], [[IP Global Addresses]], [[IP Datagram Forwarding]]
