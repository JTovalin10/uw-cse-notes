improve [[ALOHA Protocol]] by listening for activity before we send
- can do easily with wires, not wireless
# Issues
its still possible to listen and hear nothing when another node is sending because of delay

it is a good defense against collision only when BD is small
![[Screenshot 2026-01-22 at 3.43.00 PM.png]]
- everyone who collids needs to know it happened
	- how long do we need to wait to know there wasnt a JAM
	- time window in which a node may hear of a collision (transmission + jam) in 2D seconds
		- Ompose a minimum frame length of 2D frames
			- nodes cant finish before collision
			- ethernet minimum frame is 64 bytes
# Persistence
when a node is sending, the other node should wait until it is done, and send

however, the problem is that multiple nodes will be in a queue up then collide if multiple nodes send