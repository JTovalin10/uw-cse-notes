# Threads and Cores: Non-Deterministic Interleaving Invariant

## Formal Analysis / Protocol Specification

### Formal Definition: Non-Deterministic Interleaving Invariant

Let $T = \{t_1, t_2, \dots, t_n\}$ be a set of concurrent threads executing on a set of physical cores $C = \{c_1, c_2, \dots, c_m\}$.

Each thread $t_i$ consists of a sequence of atomic assembly operations $O_i = \langle o_{i,1}, o_{i,2}, \dots, o_{i,k} \rangle$.

A global execution schedule $S$ is a total ordering of all operations across all threads:
$$S = \text{Interleave}(O_1, O_2, \dots, O_n)$$

Subject to the intra-thread program order invariant:
$$\forall i, \quad a < b \implies \text{Index}_S(o_{i,a}) < \text{Index}_S(o_{i,b})$$

A program state transition function $\delta(State, o) \to State'$ is defined as **correct** if and only if for every valid schedule $S$:
$$State_{\text{final}} = \delta(\dots \delta(\delta(State_0, S[1]), S[2]) \dots, S[|S|]) \in State_{\text{valid}}$$

### Simplified Explanation
A program is only correct if it yields valid results regardless of the order in which the operating system interleaves its assembly instructions across available CPU cores.

## Related

- [[Concurrency, Parallelism, and Rust/Threads and Cores|Threads and Cores]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Threads and Cores/SMT and Out-of-Order Execution|SMT and Out-of-Order Execution]] — Hyperthreading and memory barriers
- [[Concurrency, Parallelism, and Rust/Threads and Cores/Edge Cases and Failure Modes|Edge Cases and Failure Modes]] — Data races, line bouncing, SMT contention, reordering (beyond lecture)
