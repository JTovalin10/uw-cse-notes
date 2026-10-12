# Stack Management and Channels: Channel Formal Specification

## Formal Analysis / Protocol Specification

### Formal Definition

Let $q$ be the channel queue buffer, $k$ be maximum capacity, $W_s$ be the set of blocked senders, and $W_r$ be the set of blocked receivers.

$$\forall t, \quad |q(t)| \le k$$

$$\text{If } |q(t)| = k \implies \text{send}(v) \implies \text{Block}(W_s)$$

$$\text{If } |q(t)| = 0 \implies \text{recv}() \implies \text{Block}(W_r)$$

$$\text{Unbuffered Rendezvous } (k = 0): \quad W_s \cap W_r = \emptyset, \quad \text{Transfer occurs when } |W_s| > 0 \land |W_r| > 0$$

### Simplified Explanation

A buffered channel acts as a safe pipe with $k$ storage slots. If full, senders wait outside; if empty, receivers wait outside. An unbuffered channel has zero slots, forcing the sender and receiver to shake hands in real time to transfer data.

## Related

- [[Concurrency, Parallelism, and Rust/Stack Management and Channels|Stack Management and Channels]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Stack Management and Channels/Unbuffered Channel Rendezvous Trace|Unbuffered Channel Rendezvous Trace]] — Trace of a rendezvous
- [[Concurrency, Parallelism, and Rust/Stack Management and Channels/Edge Cases and Failure Modes|Edge Cases and Failure Modes]] — Stack overflow and deadlock detection (beyond lecture)
