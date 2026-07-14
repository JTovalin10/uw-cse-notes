# CSE451: Optimizing Fork

## Problem

1. The semantics of **[[Fork|Fork]]** say the child's address space is a copy of the parent's.
2. Implementing `fork()` literally that way — performing a full, eager copy — is too slow, because it requires:
	1. Allocating physical memory for the new address space and reserving **[[swap space|Swap Space]]** for it, in case that memory later needs to be paged out.
	2. Setting up the child's page tables to map the new address space.
	3. Copying the parent's entire address space contents into the child's address space — work which is frequently wasted, since the child will often immediately throw that copied memory away with an **[[Exec|Exec]]** call (see [[exec vs fork|exec vs fork]] for why fork and exec are typically paired).

Since the fork-then-exec pattern is so common, most of the work of a naive `fork()` implementation is pure waste: the OS spends time copying an entire address space's worth of memory, only for that memory to be discarded moments later when `exec()` overwrites it with a new program image.

## Solutions

1. **[[vfork|vfork]]**: instead of giving the child a full copy, share the parent's address space directly (with the child promising not to modify it before calling `execve()`).
2. **[[clone|clone]]**: give the caller fine-grained control over exactly which resources are shared vs. copied.

Both solutions — and the [[Fork#Calling fork (Copy-on-Write Implementation)|Copy-on-Write]] approach used by modern `fork()` implementations — share the same underlying goal: avoid doing real work (copying memory, allocating swap space) until it's actually necessary, deferring or eliminating that work whenever possible.

## Related
- [[Fork|Fork]]
- [[vfork|vfork]]
- [[clone|clone]]
- [[exec vs fork|exec vs fork]]
- [[Exec|Exec]]
- [[swap space|Swap Space]]
- [[Operating Systems/Virtualization/Memory/Concepts/Copy-on-Write|Copy-on-Write]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
|---|---|
| Optimizing Fork | Lazy/deferred copy optimization |

