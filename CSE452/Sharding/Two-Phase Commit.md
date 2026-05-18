![[ShardStore and PaxosServer.png]]
No shardstore server should take it upon itself to talk to other shardstores without getign conssus from PaxosServer
- do any operation in trwo steps whenebver a shardstoreserver ants to do something
	- get consusus via paxos layer
	- when executed, does the thing
Shardstore server lives ontop if paxos layer and and not an AMOAPplication, the styate of the shartd store server is stored in the fiel dof the shard store server class
- inside out paxos application
	- uses paxos to decide what operations to do
	- we execute them on the shard store server (in the class)
	- call method with name of oepations
		- check if its in PAXOS log
			- if CHOSEN do oepration
			- put in paxos log and try to get CHOSEN
		- if alreayd execute, call method again and say its CHOSEN
## Transactions
![[Shard Paxos Cluster.png]]
swap(k1, k2): its hard to swap if keys are across groups as we want to provide linearlizablitiy
- swap the values tored at k1 and k2