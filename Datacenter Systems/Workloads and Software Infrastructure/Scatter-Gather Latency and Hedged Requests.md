# Workloads and Software Infrastructure: Scatter-Gather Latency and Hedged Requests

## Formal Analysis / Protocol Specification

### Scatter-Gather Fan-Out Latency Formulation

#### Formal Definition
Let a parent request issue $N$ parallel sub-requests to independent leaf nodes. Let $X_i$ represent the response time of leaf node $i$, governed by cumulative distribution function $F(t) = P(X_i \le t)$.

Assuming independent and identically distributed (i.i.d.) node response times, the aggregate query completion latency $L = \max(X_1, X_2, \dots, X_N)$ has distribution:

$$P(L \le t) = [F(t)]^N$$

The probability that the overall query latency exceeds duration $t$ is:

$$P(L > t) = 1 - [P(X_i \le t)]^N = 1 - [1 - P(X_i > t)]^N$$

For a fan-out of $N = 500$ leaf nodes, if each leaf has a $0.5\%$ probability ($p = 0.005$) of a straggler delay exceeding $50\text{ms}$:

$$P(L > 50\text{ms}) = 1 - (1 - 0.005)^{500} = 1 - (0.995)^{500} \approx 1 - 0.0815 = 0.9185 \quad (91.85\%)$$

#### Simplified Explanation
Individual server performance cannot guarantee fast service at scale. Even if $99.5\%$ of individual servers respond within target limits, a query fanning out to 500 servers has a $91.85\%$ chance of being delayed by a straggler. Software must actively manage tail latency rather than relying on component consistency.

### Hedged Requests Protocol Invariant

Let $t_{95}$ be the $95\text{th}$ percentile latency of a sub-task.

```
Hedged Request Protocol Execution:
  t = 0: Issue Primary RPC to Replica A.
  t = t_95: If Replica A has not responded:
              Issue Secondary Hedged RPC to Replica B.
  t = t_response: Whichever replica (A or B) completes first returns result to client.
                  Cancel outstanding RPC on peer replica.
```

$$\text{Overhead Invariant}: \quad \text{Additional Load} \le 5\%, \quad \text{Tail Latency Reduction} \approx 10\times$$

## Related

- [[Datacenter Systems/Workloads and Software Infrastructure|Workloads and Software Infrastructure]] — Hub for this topic
- [[Datacenter Systems/Workloads and Software Infrastructure/Failure Modes|Failure Modes]] — Tail latency, noisy neighbors, and alert fatigue
