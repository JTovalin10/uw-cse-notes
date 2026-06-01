# Address Resolution Protocol (ARP)

Maps network-layer address (L3 [[Internet Protocol (IP)|IP]]) to link-layer address (L2 [[Media Access Control (MAC)|MAC]]).

## How it works

- Host needs to send → broadcasts ARP request: "who has this IP?"
- Host with that IP replies with its MAC address
- Results cached in ARP table to avoid repeated broadcasts

See also: [[Neighbor Discovery Protocol (NDP)]], [[Dynamic Host Configuration Protocol (DHCP)]]
