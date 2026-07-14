# CSE451: vfork

**`vfork()`** is one of the solutions to the [[Optimizing Fork|Optimizing Fork]] problem. Instead of the usual [[Fork|fork()]] semantics of "the child's address space is a copy of the parent's," `vfork()`'s semantics are "the child's address space **is** the parent's" — the child does not get its own copy at all.

## Core Semantics

- The child shares the parent's address space directly, with a promise that the child won't modify the address space before doing an `execve()` — however, this promise is unenforced by the hardware or OS, so a buggy child that writes to memory before calling `execve()` can corrupt the parent's state.
- When `execve()` is called, a new address space is created and loaded with the new executable, replacing the shared one.
- The parent is blocked until `execve()` is executed by the child (or the child exits), since until then the parent's own address space is not safely usable — the parent must wait for the child to either give up the shared address space (via exec) or terminate.
- This design saves the wasted effort of duplicating the parent's address space, just to throw it away moments later with an exec — the same wasted-work problem identified in [[Optimizing Fork|Optimizing Fork]].

## Issues

If multithreading is the goal, `vfork()`-style sharing has to deal with:
- Two instruction and stack pointers (parent and child each have their own [[CPU State#Program Counter (PC)|PC]] and [[CPU State#Stack Pointer (SP)|SP]], even though they nominally share the same address space).
- Two handle tables.
- Two page tables.

## Copy-on-Write (COW)

A more general technique — used both to implement `fork()` efficiently and conceptually similar to what `vfork()` is trying to approximate — is **[[Operating Systems/Virtualization/Memory/Concepts/Copy-on-Write|Copy-on-Write]] (COW)**. Instead of copying memory upfront, the OS shares it but sets a trap:

- **Shared mapping**: the OS gives the child a new page table, but it points at the exact same physical memory as the parent.
- **Read-only protection**: the OS marks those pages as read-only in both the parent's and child's page table — even if that part is usually writable (stack or heap).
- **Trigger**: as long as both processes only read the data, nothing happens; they continue to share the same physical RAM with zero copying overhead.
- **The write exception**: the moment either process tries to write to a page, the hardware triggers a **[[Operating Systems/Virtualization/Memory/Page Fault|Page Fault]]**, since the page is marked read-only.
- **The copy**: the kernel's fault handler sees the fault, realizes it's a COW page (rather than a genuine protection violation), and only then makes a private copy of that specific page (typically 4KB) for the process that tried to write.

### Gotchas

1. **Isolation vs. shared**:
	1. COW provides the *illusion* of isolation.
	2. To the programmer, it feels like the child has its own memory, but under the hood the OS keeps it shared as long as possible to save resources.
	3. With COW, the OS must still create a second set of page tables — while the RAM itself isn't copied, the page table metadata is. If a process has a massive address space, copying just the page tables (without copying any actual data) can still be slow.

![[Pasted image 20260116012004.png]]

## Related
- [[Fork|Fork]]
- [[Optimizing Fork|Optimizing Fork]]
- [[clone|clone]]
- [[Exec|Exec]]
- [[Operating Systems/Virtualization/Memory/Concepts/Copy-on-Write|Copy-on-Write]]
- [[Operating Systems/Virtualization/Memory/Page Fault|Page Fault]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
|---|---|
| vfork() | POSIX `vfork()` (largely superseded by `posix_spawn`/COW `fork`) |
| COW | Copy-on-Write |

