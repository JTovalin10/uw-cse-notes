if a collision is detected then abort the frame. This reduces the cost of collisions

everyone who collides needs to know it happened. How long do we need to wait to know there wasn't a JAM?
- Time window in which a node may hear of a collision (transmission + jam) = $2D$ seconds
	- this means that it imposes a minimum frame length of 2D seconds
	- Ethernet min frame is 64 bytes - also sets max network length (500m w/ coax, 100m w/ Twisted pair)

Used by [[Classic Ethernet]] and [[Carrier Sense Multiple Access (CSMA)]]
