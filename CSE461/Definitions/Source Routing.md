The **sender** specifies the full path (list of ports/switch IDs) in the packet header. Each switch reads the next hop and forwards accordingly.

- No [[Forwarding Table]] needed — all routing decisions made by the source
- Sender must have knowledge of the network topology
- Less common than [[Connectionless]] or [[Virtual Circuit]] switching
