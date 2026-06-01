# TLB Miss Handling
Who handles the slow path when a translation isn't cached?

| | hardware-managed (e.g. x86) | software-managed (e.g. MIPS, SPARC) |
|--|-----------------------------|------------------------------------|
| who handles the miss | CPU automatically | OS trap handler |
| page table format | must match hardware spec | OS can use any format |
| OS involvement | none — transparent to OS | OS runs on every miss |
| flexibility | low | high |
