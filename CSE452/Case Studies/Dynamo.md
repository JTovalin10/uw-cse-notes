## Goals
- Availability > Consistency
	- high latency -> lower revenue

## Amazon Culture in 2007
- 12 leadership principles
	- customer obsession
- service oriented architecture
	- way to build a large company and structure the different distributed systems
	- Every team has their own Git Repo, make an HTTP request to the other service
	- allowed them to easily make them for external use
	- every team is essentially operating their own distributed system
- service level agreement (SLA)
	- For Dynamo we guarantee the 99.9th percentile latency to other team
## Latency
- 99.9th percentile latency
	- tail latency
## Strong Consistency vs Availability
- chose consistency at the price of availability
	- what paxos does
	- writes cannot occur when network is (partially) down
- choose availability over consistency (Dynamo)
	- writes work but maybe inconsistent
- Academics: believes consistency > Avaliability
	- this is why Amazon shows that latency destroys revenue hence avaliability > consistency
## CAP Theorm
- Consistency
	- writes are in a strong consistency order
- avalaibility
	- writes happen
- defining it like this makes it a "Theorom" but its better put as a CAP Tension as Consistency and Avaliability are at tension with each other
## API
```python
# application has to figure out how to merge set of values
# if more than 1 value merge them and write into context (used for put)
def get(key) -> [set(values), content]:
	...

def put(key, context, newVal) -> None
	...

def union()
	...
```
Shopping cart:
returns a set of shopping carts (versions), we need to merge them together
- however if there is a inconsistency we assume its valid
	- removing something from the shopping cart does nothing
	- worst case we send them worse stuff then they bought (give them refund and tell them to keep it, everyones happy)
	- this is why each team runs their own Dynamo instance so they can tune union to how they require it (also adjust parameters to their needs)
## Vector Clocking
- [[Timestamps]]
- when writing, it creates a branch, we return the set of the leaves of this split so the client can resolve teh conflict.
	- even if we do not plan on writing, we must resolve this before doing anything
	- usually union them to create one leaf, hence reads are valid again
- amazon uses sparse vector clocks so Map<Id, vectorNum>
## Parameters
- R
	- number of replicas required to read
- W
	- number of replicas required to write
- N
	- number of replicas
- almost paxos
- if we set R or W to 1, then it is more failure prone
- N can be set high
- R + W > N is ideal
## Consistent Hashing
- we want a way to map keys to nodes
	- everyone agrees on this
	- flexible so if we add or remove nodes we do not disturb key space
- think of nodes of living on a circle
	- closest nodes are the nodes for that server
	- if we have W or R > 1 then we keep walking until we reach our number