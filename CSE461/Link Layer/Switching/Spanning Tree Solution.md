[[Switching]] collectively find a spanning tree for the topology
- subset of links that is a tree (no loops) and reaches all switches
- They switches forward as normal on the spanning tree 
-  Broadcasts will go up to the root of the tree and down all the branches
![[Screenshot 2026-02-06 at 12.53.53 PM.png]]

# Algorithm
rules:
1. all switches run the same algo
2. they start with no information
3. operate in parallel and send messages
4. always find the best solution
because of these rules
5. creates a robust solution
	1. adapts to failure
	2. any topology, no configuration

Outline:
1. elect a root node of the tree (switch with the lowest address)
2. grow tree as shortest distance from the root (using the lowest address to break distance ties)
3. turn off ports for forwarding as they arent on the spanning tree

Details:
- each switch initially believes it is the root of the tree
- each switch sends periodic updates to neighbors with
	- its address, address of the root, and distance (in hops) to the root
	- short-circuit when topology changes
- switches favor ports with shortest distance to the root
	- use lowest address for ties for distance

Problems:
due to overhead (not the most optimal paths) and bottle necks (root), this doesnt scale and is only good for small scale links
[[Spanning Tree Example]]