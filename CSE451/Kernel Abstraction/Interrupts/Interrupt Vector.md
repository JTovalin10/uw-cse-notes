An array of function pointers that tells the CPU where to jump when an interrupt happens

This creates safety, as we have controlled entry points so the user cannot jump wherever they want.
![[Screenshot 2026-01-07 at 12.00.18 PM.png]]

# Security
Contains a checksum, as otherwise someone could make it point to their code.