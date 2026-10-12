# Course Introduction and Overview: Availability, Tail Latency, and PUE Formulas

## Formal Analysis / Protocol Specification

### 1. Availability and Down Time Formulation

#### Formal Definition
Availability $A$ is defined as the ratio of uptime to total operational time:

$$A = \frac{\text{MTBF}}{\text{MTBF} + \text{MTTR}} = \frac{T_{\text{uptime}}}{T_{\text{total}}}$$

Where:
- $\text{MTBF}$ = Mean Time Between Failures.
- $\text{MTTR}$ = Mean Time To Repair.

Allowable downtime $\Delta t_{\text{down}}$ over period $T$ for a given target SLA availability fraction $A$:

$$\Delta t_{\text{down}} = T \times (1 - A)$$

For a weekly period ($T = 7 \text{ days} = 10,080 \text{ minutes}$):
- $A = 0.9999$ (Four Nines):
  $$\Delta t_{\text{down}} = 10,080 \times 10^{-4} \approx 1.008 \text{ minutes/week}$$
- $A = 0.99999$ (Five Nines):
  $$\Delta t_{\text{down}} = 10,080 \times 10^{-5} \approx 6.048 \text{ seconds/week}$$

#### Simplified Explanation
Every added "nine" of availability divides permissible failure time by a factor of 10. At four nines, your service can only be down for about one minute in an entire week. At five nines, you only get six seconds of downtime per week before breaching your contract.

---

### 2. Fan-Out Tail Latency Probability

#### Formal Definition
Let a root query fan out to $N$ independent parallel leaf nodes. Let $X_i$ be the latency of leaf node $i$, with cumulative distribution function $F(t) = P(X_i \le t)$.

Assuming identical and independent distributions (i.i.d.), the overall query latency $L = \max(X_1, X_2, \dots, X_N)$ has distribution:

$$P(L \le t) = [F(t)]^N$$

The probability that the overall query exceeds latency threshold $t$ is:

$$P(L > t) = 1 - [P(X_i \le t)]^N = 1 - [1 - P(X_i > t)]^N$$

If a single sub-task has a 1% chance ($p = 0.01$) of exceeding 100ms ($P(X_i > 100\text{ms}) = 0.01$), then for a fan-out of $N = 100$ leaf nodes:

$$P(L > 100\text{ms}) = 1 - (1 - 0.01)^{100} = 1 - (0.99)^{100} \approx 1 - 0.366 = 0.634 \quad (63.4\%)$$

#### Simplified Explanation
Even if 99% of your servers respond quickly on their own, when a single request must wait for 100 servers to finish, nearly two-thirds of all user requests will suffer the slow 99th-percentile delay.

---

### 3. Power Usage Effectiveness (PUE)

#### Formal Definition
$$\text{PUE} = \frac{\text{Total Facility Energy Consumption}}{\text{IT Equipment Energy Consumption}} = 1 + \frac{\text{Cooling} + \text{Power Losses} + \text{Lighting}}{\text{IT Power}}$$

$$\text{Efficiency Invariant}: \quad \text{PUE} \ge 1.0, \quad \lim_{\text{losses} \to 0} \text{PUE} = 1.0$$

#### Simplified Explanation
PUE measures how much extra power the datacenter burns on non-computing overhead (chiefly air conditioning, chillers, and electrical transformers) for every watt used to run actual servers. A PUE of 2.0 means you spend as much power cooling the building as you do computing; world-class modern hyperscale facilities achieve PUEs around 1.1.

## Related

- [[Datacenter Systems/Course Introduction and Overview|Course Introduction and Overview]] — Hub for this topic
- [[Datacenter Systems/Course Introduction and Overview/Failure Modes|Failure Modes]] — Stragglers, resource stranding, and incast
