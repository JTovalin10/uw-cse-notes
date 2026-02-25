routing allocates network bandwidth adapting to failures; other mechanisms used at other timescales.

it is on the minute scale with equipment failures
## Goals of algorithm
1. correctness
	1. finds paths that work
2. efficient paths
	1. use network bandwidth well
3. fair paths
	1. no starvation
4. fast convergence
	1. recovers fast after changes
5. scalability
	1. works well as network grows large

## Rules of algorithms
decentralized and distributes setting
- all nodes are alike
- nodes only know what they learn by exchanging messages with messages
- nodes operate concurrently
- may be node/link/message failures

## Best path
we can define best as:
1. latency, avoid circuitous paths
2. bandwidth, avoid slow links
3. money, most expensive links
4. hops, to reduce switching

## Shortest Paths
1. assign each link a cost (distance)
2. define best path between each pair of nodes as the path that has the lowest total cost (or is shortest)
3. pick randomly to break any ties
### Optionality property:
- subpaths of shortest paths are also shortest path

### Sink Tree
sink tree for a destination is the union of all shortest paths towards the destination
#### Implications
- only need to use destination to follow shortest paths
- each node only needs to send to the next hop
#### Forwarding table at a node
- list next hop for each destination
- routing table may know more