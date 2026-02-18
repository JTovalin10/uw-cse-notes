# Main Question
how do we connect nodes with a **switch** instead of multiple access
- uses multiple links/wires
- basis of modern (switched Ethernet)

## Topics
- [[Switch Ethernet]]
- [[Switch Forwarding]]
- [[Backwards Learning]]
- [[Spanning Tree Solution]]
- [[Scaling the Link layer]]
- [[Software Defined Networking]]

## Textbook Notes
The issue is that if we have a pair of Ethernets that we want to interconnect, there are physical constraints to consider. Recall that no more than four repeaters can exist between any pair of hosts, and no more than a total of 2500 m in length is allowed.

The simplest way to interconnect them is to have bridges simply accept LAN frames on their inputs and forward them out on all other outputs.

### How to Achieve This
- [[Learning Bridges]] — forward only when necessary by learning which hosts are on which ports
- [[Spanning Tree Algorithm]] — eliminate loops that arise when bridges are connected in a cycle

### Limitations and Solutions
Switches do not scale well beyond tens of networks, which is why the [[Spanning Tree Algorithm]] only scales linearly. Furthermore, switches forward all broadcast frames since there is no way to impose hierarchy on a set of switches. This is addressed by [[Virtual LANs (VLANs)]].

### Additional Context
- [[L2 Switches]] — the devices used to build extended LANs
- [[Broadcast and Multicast]] — how broadcast and multicast traffic is handled across switched networks
