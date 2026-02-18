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