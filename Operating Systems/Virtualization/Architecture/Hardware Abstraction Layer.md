# CSE451: Hardware Abstraction Layer

The **Hardware Abstraction Layer (HAL)** separates hardware-specific routines from the "core" OS, providing a consistent interface that the rest of the kernel can call regardless of which specific hardware is actually present underneath.

- Provides portability — because hardware-specific code (e.g., how to talk to a particular disk controller or network card) is isolated into the HAL, the "core" OS logic above it does not need to be rewritten when the OS is ported to new or different hardware; only the HAL implementation needs to change.
- Improves readability — separating hardware-specific detail out of the core OS keeps the bulk of the kernel's logic free of low-level, device-specific minutiae, making it easier for developers to reason about the system's high-level behavior.

![[Pasted image 20260114214043.png]]

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| Hardware Abstraction Layer (HAL) | HAL / Board Support Package (BSP) / device driver abstraction |

## Related
- [[Operating Systems/Virtualization/Architecture/Operating System|Operating System]] — portability challenge the HAL addresses
- [[Operating Systems/Virtualization/Architecture/Operating System Roles|Operating System Roles]] — the HAL as part of the Glue role
- [[Operating Systems/Virtualization/Architecture/IO|IO]] — device drivers that the HAL sits above
