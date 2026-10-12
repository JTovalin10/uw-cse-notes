# Warehouse-Scale Computer Architecture: Power, PUE, and AFR Formulas

## Formal Analysis / Protocol Specification

### Power Usage & Energy Dynamics

CPUs consume the largest share of system power in a server node due to high dynamic energy consumption under load and high idle power draw.

![[Screenshots/Energy Consumption Percentages.png]]

Historically, memory subsystems (e.g., Fully Buffered DIMMs / FBDIMMs) consumed power comparable to the CPU. The transition to DDR3/DDR4/DDR5 architectures significantly improved DRAM power efficiency, restoring CPUs as the dominant energy consumer.

### Power Usage Effectiveness (PUE)

Facilities efficiency is evaluated using **Power Usage Effectiveness (PUE)**:

$$\text{PUE} = \frac{P_{\text{Total Facility}}}{P_{\text{IT Equipment}}} = \frac{P_{\text{IT}} + P_{\text{Cooling}} + P_{\text{Power Losses}} + P_{\text{Lighting}}}{P_{\text{IT}}}$$

Where:
- $P_{\text{IT}}$ = Power consumed by compute servers, storage drives, and network switches.
- $P_{\text{Total Facility}}$ = Total power drawn from the utility grid.

$$\text{Efficiency Invariant}: \quad \text{PUE} \ge 1.0, \quad \lim_{P_{\text{overhead}} \to 0} \text{PUE} = 1.0$$

#### Simplified Explanation
PUE measures how much extra energy the facility spends on cooling and electrical infrastructure for every watt delivered to computing hardware. A PUE of $2.0$ indicates that half of the building's electricity is wasted on overhead. Hyperscale WSCs achieve PUEs near $1.1$ through optimized airflow, chilled water loops, and warm-water cooling.

### Annualized Failure Rate (AFR) Calculation

Expected server failure rate within a WSC cluster of $N$ nodes over operational duration $T$ (years):

$$\mathbb{E}[\text{Failures}] = N \times \text{AFR} \times T$$

For a WSC with $N = 100,000$ servers and an $\text{AFR} = 0.05$ ($5\%$ annual failure rate):

$$\mathbb{E}[\text{Failures per day}] = \frac{100,000 \times 0.05}{365} \approx 13.7 \text{ server failures/day}$$

## Industry Standard Terms

| Course Term | Industry / Standard Term |
| :--- | :--- |
| **Power Usage Effectiveness (PUE)** | Datacenter Infrastructure Efficiency Metric |

## Related

- [[Datacenter Systems/Warehouse-Scale Computer Architecture|Warehouse-Scale Computer Architecture]] — Hub for this topic
- [[Datacenter Systems/Warehouse-Scale Computer Architecture/Failure Modes|Failure Modes]] — Faults, bisection bandwidth, and thermal limits
