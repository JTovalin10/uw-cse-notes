A 32-bit value used to extract the **subnet number** from an [[IP Address]] by performing a bitwise AND.

All hosts on the same physical network share the same subnet number — i.e., they all have the same result when their IP address is ANDed with the subnet mask.

## How It Works

```
subnet_number = ip_address AND subnet_mask
```

A host determines whether a destination is on the same subnet by comparing the result with its own subnet number:
- **Match** → destination is local, deliver directly
- **No match** → destination is remote, forward to a [[Router]]

## In the Forwarding Table

The [[Forwarding Table]] stores a **SubnetMask** field alongside each entry so that the router can correctly identify which subnet an address belongs to when making a forwarding decision.

See also: [[Subnetting]], [[IP Address]], [[IP Datagram Forwarding]]
