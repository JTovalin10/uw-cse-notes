# How the TLB Works

| step | action |
|------|--------|
| 1 | extract the VPN from the virtual address |
| 2 | check if the VPN is in the TLB |
| 3 — **TLB hit** | get the PFN, form the physical address, access memory |
| 4 — **TLB miss** | walk the page table, find the translation, install it in the TLB, retry |
