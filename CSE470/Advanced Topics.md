# Course: Advanced Topics

Modern architecture is shifting toward specialization and system-level integration to overcome the Power Wall.

## Specialized Computing
General-purpose CPUs are flexible but inefficient. Specialization improves performance per watt.

### SIMD and Vector Processors
- **DLP (Data-Level Parallelism)**: One instruction, multiple data elements.
- **NEON (ARM)**, **AVX (Intel)**: Short vector extensions.
- **GPUs**: Massive SIMD-like arrays optimized for throughput.

### Accelerators and FPGAs
- **ASICs**: Custom chips for one task (e.g., Google's TPU for machine learning, Tesla's FSD chip).
- **FPGAs**: Programmable hardware that can be reconfigured for specific algorithms.

## Case Studies: Real Systems

### Intel Ice Lake (Sunny Cove)
- **Front-end**: 5-wide decode.
- **OoO Window**: 352-entry ROB.
- **Execution**: 10 execution ports.
- **AVX-512**: Support for 512-bit vector operations.

### Warehouse-Scale Computing
Designing the entire data center as a single computer.
- Focus on **TCO (Total Cost of Ownership)**.
- Power, cooling, and networking are the primary constraints.
- Software must handle frequent hardware failures at scale.

## The Future of Architecture
- **3D Integration**: Stacking chips (e.g., SRAM on top of Logic).
- **Domain-Specific Languages (DSLs)**: Compilers that target specialized hardware.
- **Bio-integrated Computing**: DNA storage, protein-based logic.

## Related
- [[CSE470/Basic Principles and Performance|Basic Principles and Performance]]
- [[CSE469/Advanced Architecture|CSE469: Advanced Architecture]]
