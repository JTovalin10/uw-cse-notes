# Execution Environments and Virtualization: Diurnal Workload Co-Location

## 2. Diurnal Workload Co-Location & Utilization Formulation

### Formal Definition
Let server capacity be $C_{\text{server}}$ normalized to $1.0$. Let daytime peak traffic follow a diurnal cycle modeled as a periodic sinusoidal function:

$$I(t) = I_{\text{mean}} + I_{\text{amp}} \sin\left(\frac{2\pi t}{24}\right), \quad 0 \le I(t) \le C_{\text{server}}$$

Where $I(t)$ represents the interactive foreground workload demand at hour $t$. 

If a dedicated server hosts only $I(t)$, the single-tenant utilization over period $T = 24 \text{ hours}$ is:

$$U_{\text{dedicated}} = \frac{1}{T \cdot C_{\text{server}}} \int_0^T I(t) \, dt \approx 0.15 \text{ to } 0.30 \quad (15\text{--}30\%)$$

By virtualizing and multiplexing a deferrable batch workload $B(t)$ with maximum processing capacity $B_{\text{max}}$, the hypervisor dynamically allocates remaining headroom:

$$B(t) = \max\left(0, \; C_{\text{target}} - I(t)\right)$$

Where $C_{\text{target}} \le C_{\text{server}}$ (typically set to $0.80$ to preserve a $20\%$ burst safety margin).

The consolidated multi-tenant server utilization becomes:

$$U_{\text{consolidated}} = \frac{1}{T \cdot C_{\text{server}}} \int_0^T \left[ I(t) + B(t) \right] \, dt = \frac{C_{\text{target}}}{C_{\text{server}}} \approx 0.80 \quad (80\%)$$

### Simplified Explanation
Interactive web apps only use a lot of compute during daytime hours, leaving physical servers mostly idle at night. By putting batch jobs (like video processing or AI training) on the same virtualized server and programming the hypervisor to fill whatever compute headroom the web app isn't using, average server utilization jumps from 20% to 80%, cutting total server hardware costs by up to a factor of 4.

## Related

- [[Datacenter Systems/Execution Environments and Virtualization|Execution Environments and Virtualization]] — Hub for this topic
- [[Datacenter Systems/Execution Environments and Virtualization/Popek-Goldberg Criteria|Popek-Goldberg Criteria]] — Formal virtualization criteria
- [[Datacenter Systems/Execution Environments and Virtualization/Hypervisor Types and VT-x|Hypervisor Types and VT-x]] — Type 1 vs Type 2 hypervisors and hardware assistance
