Improve [[ALOHA Protocol]] by listening for activity before we send ([[Carrier Sense]])
- can do easily with wires, not wireless

# Issues
It's still possible to listen and hear nothing when another node is sending because of delay.

it is a good defense against collision only when [[Bandwidth-Delay (BD) Product]] (bandwidth-delay product) is small — otherwise propagation delay lets a distant sender start without hearing an ongoing transmission
![[Screenshot 2026-01-22 at 3.43.00 PM.png]]

# CSMA/CD (with collision detection)
if a collision is detected then abort the frame. This reduces the cost of collisions

everyone who collides needs to know it happened. How long do we need to wait to know there wasn't a **JAM** (collision signal all colliding senders transmit)?
- Time window in which a node may hear of a collision (transmission + jam) = $2D$ seconds, where $D$ = propagation delay (one-way)
	- this imposes a **minimum frame length** of 2D seconds — sender must still be transmitting when collision signal arrives, so it can detect and abort
	- Ethernet min frame is 64 bytes → max network length ~500m (coax) or 100m (twisted pair), since 2D must fit within 64-byte transmission time

# Persistence
when a node is sending, the other node should wait until it is done, and send

however, the problem is that multiple nodes will be in a queue up then collide if multiple nodes send
