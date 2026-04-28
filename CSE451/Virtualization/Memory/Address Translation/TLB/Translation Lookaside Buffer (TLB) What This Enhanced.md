# What Virtual Memory + TLB Enables

| feature | what it provides |
|---------|-----------------|
| read-only instructions | code pages marked read-only — bad pointers can't corrupt program code |
| null pointer protection | address 0 left unmapped — hardware catches null dereferences as interrupts |
| inter-process protection | each process has its own address space — same virtual address maps to different physical frames per process |
| shared libraries | one physical copy of libc shared across all processes via page table entries |
| shared memory | two processes can map the same physical frames — fast IPC without syscalls |
| Copy-on-Write | parent and child share pages read-only after fork — OS copies only on a write fault |
| memory-mapped files | files mapped into virtual address space — OS pages them in/out on demand |

## shared memory
- regions of two separate processes' address spaces map to the same physical frames
- each process has its own PTE for the region, so different access rights can be granted (e.g. one reader, one writer)
- no syscall needed to communicate — just read/write the shared region

## Copy-on-Write (CoW)
- on `fork`, instead of copying all pages, parent and child share a read-only mapping of the parent's pages
- when either process writes, a page fault occurs and the OS copies just that page
- avoids expensive full copies when the child immediately calls `exec`

## memory-mapped files
- instead of `open` / `read` / `write` / `close`, map a file into a region of virtual address space at address `X`
- accessing `X+N` refers to byte offset N in the file
- all pages in the mapped region start as invalid — the OS reads them in on demand
- dirty pages are written back to the file on eviction
- if the mapping window is smaller than the file, it can be slid forward

![[Screenshot 2026-02-20 at 12.20.19 PM.png]]

## loading shared libraries
- libc appears in multiple virtual address spaces but maps to the same physical frames
- each library has a preferred virtual load address — the OS tries to honour this across processes to simplify linking
- **problem**: over time, library preferred addresses conflict, requiring dynamic relocation
