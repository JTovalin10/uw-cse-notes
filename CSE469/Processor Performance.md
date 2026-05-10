# Course: Processor Performance

Performance is defined by the time it takes to execute a program. In computer architecture, we focus on minimizing **Latency** (response time) and maximizing **Throughput** (bandwidth).

## The CPU Performance Equation
The fundamental formula for calculating the execution time of a program:
$$\text{CPU Time} = \frac{\text{Instructions}}{\text{Program}} \times \frac{\text{Clock Cycles}}{\text{Instruction}} \times \frac{\text{Seconds}}{\text{Clock Cycle}}$$

### Breakdown of Factors
1.  **Instruction Count (IC)**: The number of instructions executed.
    - Determined by: **ISA** and **Compiler**.
2.  **Cycles Per Instruction (CPI)**: The average number of clock cycles required to execute an instruction.
    - Determined by: **CPU Microarchitecture** (e.g., pipelining, superscalar).
    - **CPI** is the reciprocal of IPC (Instructions Per Cycle).
3.  **Clock Cycle Time (T)**: The duration of one clock pulse (1 / Frequency).
    - Determined by: **Hardware Technology** and **Transistor Speed**.

## Performance Improvement Laws

### Amdahl's Law
**Amdahl's Law** quantifies the law of diminishing returns when optimizing a specific part of a system. It states that the performance improvement from using some faster mode of execution is limited by the fraction of the time the faster mode can be used.

**Formula**:
$$\text{Speedup}_{overall} = \frac{1}{(1 - f) + \frac{f}{s}}$$
- $f$: Fraction of the original execution time that can be improved.
- $s$: Speedup of that improved fraction.

**Example**: If a program takes 100s, and 80s of that is spent on floating-point math, if we speed up floating-point math by 2x:
$$\text{Speedup} = \frac{1}{(1 - 0.8) + \frac{0.8}{2}} = \frac{1}{0.2 + 0.4} = 1.67\times$$

### Formal Definition
The overall speedup of a system is limited by the sequential (non-parallelizable) portion of the task.

### Simplified Explanation
If you spend 90% of your time sleeping and 10% studying, doubling your studying speed only makes your whole day about 5% shorter.

## Memory Performance: AMAT
Since processors are often "memory-bound," we use **Average Memory Access Time (AMAT)** to measure the efficiency of the memory hierarchy.

$$\text{AMAT} = \text{Hit Time} + (\text{Miss Rate} \times \text{Miss Penalty})$$

- **Hit Time**: Time to access the current level (e.g., L1 cache).
- **Miss Rate**: Fraction of accesses not found in this level.
- **Miss Penalty**: Additional time required to fetch the data from the next lower level.

## Related
- [[CSE469/Memory Hierarchy and Caches|Memory Hierarchy and Caches]]
- [[CSE469/Pipelining and Hazards|Pipelining and Hazards]]
