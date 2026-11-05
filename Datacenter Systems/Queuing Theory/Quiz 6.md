# Datacenter Systems: Quiz 6

Notes on reading latency distributions with a CDF and on cache eviction policies. These build on [[Datacenter Systems/Queuing Theory/Queuing Theory|Queuing Theory]] and [[Datacenter Systems/Server Memory Systems/Server Memory Systems|Server Memory Systems]].

---

## Cumulative Distribution Function (CDF)

- Average and tail metrics alone don't provide a complete picture of performance: two systems can share the same average and the same tail yet behave very differently in between.
- A **Cumulative Distribution Function (CDF)** shows the probability that a measured variable will take a value less than or equal to a threshold, so the whole distribution is visible in one curve.
- We can use a **Zipfian distribution** for object popularity: a few objects receive most of the requests, and the rest form a long tail.

## Cache Policies

| Policy | Evicts |
|---|---|
| **Least Recently Used (LRU)** | the least recently used items first |
| **Least Frequently Used (LFU)** | the item with the fewest accesses |
| **Most Recently Used (MRU)** | the most recently accessed item |
| **Hyperbolic caching** | based on a hyperbolic function that prioritizes evictions using a custom-defined parameter |
| **First In, First Out (FIFO)** | items in the order they were cached |
| **Random** | a randomly selected item |

---

## CDF Specification

### Formal Definition

$F(x) = P(X \le x)$

### Simplified Explanation

Pick a threshold; the CDF tells you what fraction of requests finished at or below it.

---

## Related

- [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure/Quiz 4|Quiz 4]]: load generation and finding the overload point
- [[Datacenter Systems/Queuing Theory/Queueing and CPU Scheduling|Queueing and CPU Scheduling]]
- [[Datacenter Systems/Server Memory Systems/Server Memory Systems|Server Memory Systems]]

## Industry Standard Terms

- **CDF of latency** → latency distribution / percentile curve (p50, p99, ...)
- **Zipfian distribution** → power-law popularity skew
- **LRU / LFU / MRU / FIFO** → standard cache eviction policies
