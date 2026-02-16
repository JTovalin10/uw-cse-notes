## Switch Implementation
How switches and routers are built in practice. Three main approaches:

1. **[[Software Switch]]** — general-purpose CPU forwards packets through main memory via [[Direct Memory Access (DMA)|DMA]]
2. **[[Hardware Switch]]** — bare-metal switch with a dedicated [[Network Processor Unit (NPU)|NPU]] and [[Static Random-Access Memory (SRAM)|SRAM]]/[[Ternary Content-Addressable Memory (TCAM)|TCAM]] for fast packet processing
3. **[[Software Defined Networks]]** — decouples the control plane (software on commodity servers) from the data plane (bare-metal switches)
