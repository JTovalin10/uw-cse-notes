# TLB In Hardware
The TLB is implemented as a [[fully associative cache]] inside the [[Memory Management Unit]] — all entries are searched in parallel.

| component | value |
|-----------|-------|
| cache tags | virtual page numbers (VPN) |
| cache values | page table entries (PTEs) — including protection and valid bits |
| lookup result | PFN + page offset → physical address |
