BIG is the interdomain routing protocol used in the Internet
- different parties like [[Internet Service Provider (ISP)]]s are called Autonomous Systems (AS)
- Border routers of ASes announce BGP routes to each other
- route announcements contain an Ip prefix, path vector, next hop
	- path vector is list of Ases on the way to the prefix; list is to find loops
- route announcements move in the opposite direction to traffic

## Sending
the goal of [[Internet Service Provider (ISP)]] is to make money so they will not want to pay money to send a packet for someone else
1. sending sideways is free (peer to peer), however it would prefer not to as it doesnt make money
	1. we can set this to a priority of 0
	2. we can only do this once A->B never A->B->C
2. sending up costs money (provider path)
	1. priority of -1
3. they get paid to send down (customer path)
	1. priority of 1
The choice is Customer > peer > provider. However if a peer loses money by sending it then it wont lose it for you. As long as a node has gotten it form a customer they will send it to a customer, provider, peer (they made money so they are fine paying basically)
- customer path
	- advertise to everyone
- peer path
	- advertise to customer
- provider path
	- advertise to customer
## Policy
1. border routers of ISP annouce paths only to other parties who may use those paths
2. border routers of ISP select the best path of the ones they hear in any, non-shortest way