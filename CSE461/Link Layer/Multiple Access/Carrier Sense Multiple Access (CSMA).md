Improve [[ALOHA Protocol]] by listening for activity before we send ([[Carrier Sense]])
- can do easily with wires, not wireless

# Issues
its still possible to listen and hear nothing when another node is sending because of delay

it is a good defense against collision only when BD is small
![[Screenshot 2026-01-22 at 3.43.00 PM.png]]

# CSMA/CD (with collision detection)
if a collision is detected then abort the frame. This reduces the cost of collisions

everyone who collides needs to know it happened. How long do we need to wait to know there wasn't a JAM?
- Time window in which a node may hear of a collision (transmission + jam) = $2D$ seconds
	- this means that it imposes a minimum frame length of 2D seconds
	- Ethernet min frame is 64 bytes - also sets max network length (500m w/ coax, 100m w/ Twisted pair)

# Persistence
when a node is sending, the other node should wait until it is done, and send

however, the problem is that multiple nodes will be in a queue up then collide if multiple nodes send
