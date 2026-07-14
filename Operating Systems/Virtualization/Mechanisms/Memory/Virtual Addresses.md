# CSE451: Virtual Addresses

A **virtual address** is the address a process's code and data appear to live at, as opposed to the actual physical location in RAM. Virtual addresses are the modern replacement for the direct physical addressing used by [[Base and Bounds]].

## Core Mechanism
- Translation from a virtual address to a physical address is done in hardware, using a page table
- The page table is set up and maintained by the OS kernel — the kernel decides which virtual pages map to which physical frames
- Memory is broken into fixed-size **pages** (typically 4KB chunks); each page can be mapped independently to any physical frame

![[Screenshot 2026-01-07 at 12.41.04 PM.png]]

## Coding Example
```c
int main() {
int x = 1;
int* y = &x // this returns the virtual address
}
```
Here, `y` holds the **virtual address** of `x` — the hardware transparently translates this into the correct physical address whenever the process dereferences `y`.

## How This Fixes [[Base and Bounds]]
Because pages can be mapped individually and non-contiguously, virtual addressing solves every major problem that base and bounds suffered from:
1. [[No More Fragmentation]] — physical frames can be scattered anywhere, since each page is mapped independently
2. [[Easy Sharing]] — multiple processes' virtual pages can point to the same physical frame
3. [[Dynamic Growth]] — new pages can be added to a process's page table without moving existing memory
4. [[Demand Paging]] — physical frames only need to be allocated when a page is actually accessed
5. [[Page Protection]] — per-page permission bits provide fine-grained access control

## Downsides
See [[Virtual Address Downsides]] for the costs virtual addressing introduces (page table memory overhead, the need for a TLB, and increased hardware complexity).

## Related
- [[Base and Bounds]] — the earlier mechanism virtual addressing replaces
- [[Memory Layout]] — hub file linking memory protection mechanisms
- [[Simple Memory Protection]] — the broader category of memory isolation mechanisms
- [[Operating Systems/Virtualization/Memory/Concepts/Virtual Addresses]] — the deeper treatment of virtual addressing in the Memory directory

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| Virtual Address | Virtual address / logical address |
| Page | Page (standard paging terminology) |
| Physical Frame | Page frame / physical frame |
