# Course: Basic Principles and Performance

Computer architecture is currently at a crossroads. Traditional scaling (Moore's Law and Dennard Scaling) is slowing down, forcing architects to find new ways to improve performance through organization and specialization.

## Technology Trends

### Moore's Law
- **Observation**: The number of transistors on a chip doubles approximately every 18-24 months.
- **Current Status**: Still continuing in terms of density, but hitting physical limits (quantum tunneling, leakage).

### Dennard Scaling
- **Observation**: As transistors get smaller, their power density stays constant because voltage scales down with size.
- **Current Status**: **Dead**. Voltage cannot be scaled down further without becoming unstable (Vth limits). This led to the **Power Wall**.

### The Power Wall
We can no longer increase clock frequency because we cannot dissipate the heat. This shifted the industry from single-core performance to multi-core and specialized accelerators.

## Quantitative Metrics

### The Iron Law of Performance
$$\text{Time} = \frac{\text{Instructions}}{\text{Program}} \times \frac{\text{Cycles}}{\text{Instruction}} \times \frac{\text{Seconds}}{\text{Cycle}}$$
- **Optimization Goal**: Minimize all three, but they are often coupled (e.g., deeper pipelines increase frequency but also increase CPI due to hazard penalties).

### Amdahl's Law
The overall speedup of a system is limited by the portion of the task that *cannot* be improved.
$$\text{Speedup}_{overall} = \frac{1}{(1-f) + \frac{f}{s}}$$
- **Key Takeaway**: Make the common case fast.

## Power vs. Energy
- **Power (Watts)**: Instantaneous rate of energy consumption. Determines cooling requirements and peak current.
    - $P_{dynamic} \propto C \cdot V^2 \cdot f$
    - $P_{static} = I_{leak} \cdot V$ (Now 25-50% of total power).
- **Energy (Joules)**: Total work done. Determines battery life.
    - $E = \text{Power} \times \text{Time}$.

### Formal Definition
Performance is the reciprocal of execution time. Speedup is the ratio of execution times. Power is the derivative of energy with respect to time.

### Simplified Explanation
If you make the engine twice as powerful, you might get there faster (better performance), but you might use more fuel (lower energy efficiency). If most of your trip is stuck in traffic, the faster engine doesn't help much (Amdahl's Law).

## Related
- [[CSE469/Processor Performance|CSE469: Processor Performance]]
- [[CSE470/Advanced Topics|Advanced Topics]]
