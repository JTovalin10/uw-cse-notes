# Hardware Switch

A **Hardware Switch** is a networking device that performs packet forwarding using specialized hardware components rather than a general-purpose CPU. Unlike a [[CSE461/Definitions/Software Switch|Software Switch]], which relies on software running on a traditional operating system, hardware switches use **ASICs** (Application-Specific Integrated Circuits) and **NPUs** (Network Processing Units) to achieve high throughput and low latency.

### Key Characteristics
- **Line Rate Forwarding**: Capable of processing packets at the full speed of the physical links without dropping data.
- **TCAM (Ternary Content-Addressable Memory)**: High-speed memory used for near-instantaneous lookups in forwarding tables.
- **Specialized Hardware**: Offloads the data plane from the CPU, which is typically reserved for the control plane (routing protocols).
