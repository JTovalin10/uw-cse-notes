# Why the TLB Matters

| | without TLB | with TLB |
|--|-------------|----------|
| translation cost | 1+ extra memory accesses per instruction | nearly free on a hit (fast parallel lookup) |
| bottleneck | every memory access is slowed by page table walks | only misses pay the penalty |
| key metric | — | miss rate — even a small TLB covers most accesses due to locality |
