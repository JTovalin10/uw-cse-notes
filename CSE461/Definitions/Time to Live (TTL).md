## Time to Live (TTL)
A counter in a packet header that limits how long the packet can remain in the network. Each router that handles the packet decrements the TTL by 1. When it reaches 0, the packet is discarded. This prevents packets caught in routing loops from circulating indefinitely and consuming resources.

In IP, the default TTL is typically 64. In bridge/switch forwarding tables, TTL is used as a timeout (e.g., 120 seconds) after which an entry is removed if not refreshed.

See also: [[IP Packet Format]], [[Learning Bridges Implementation]]
