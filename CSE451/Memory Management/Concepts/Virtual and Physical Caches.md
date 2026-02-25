Caches can be indexed and tagged using either virtual addresses or physical addresses, leading to different design tradeoffs.

## The Two Dimensions

Each cache has two operations that use an address:
- **Index**: Which cache set to look in
- **Tag**: What to compare against to confirm a hit

This gives three practical combinations:

---

## VIVT — Virtually Indexed, Virtually Tagged

The cache uses the virtual address for both indexing and tag comparison. The TLB is not consulted until after a cache miss.

**Advantage**: Fast — no address translation needed on a hit.

**Problems**:
- **Homonym problem**: Two different processes can have the same virtual address mapping to different physical addresses. The cache can't distinguish them — it would return stale data from another process. Requires a flush on every context switch, destroying performance.
- **Synonym problem**: Two virtual addresses in the same process can map to the same physical frame (shared memory). The cache might hold two copies that get out of sync.

Largely abandoned in modern systems.

---

## PIPT — Physically Indexed, Physically Tagged

The cache uses the physical address for both indexing and tag. Requires address translation (via TLB) before the cache can even be accessed.

**Advantage**: No homonym or synonym problems — physical addresses are unique across processes. No flush needed on context switch.

**Problem**: The TLB lookup sits on the critical path. A TLB miss means a page table walk before the cache can even be checked.

Used for L2/L3 caches where the extra latency is acceptable.

---

## VIPT — Virtually Indexed, Physically Tagged

The cache uses the virtual address for indexing (fast, parallel with TLB lookup) but uses the physical address for the tag comparison (correct, no homonyms).

**Key insight**: If the index bits fall entirely within the page offset (the bits that are the same in both virtual and physical addresses), then the index is identical whether computed from the virtual or physical address. This eliminates the synonym problem as well.

- Page offset bits are the low-order bits (e.g., bits [11:0] for 4 KB pages).
- If `index bits ⊆ page offset bits`, the cache behaves like PIPT with VIVT speed.

**Constraint**: `cache_size / associativity ≤ page_size`

This is why L1 caches are kept small and highly associative — it lets them use VIPT safely.

Used by virtually all modern L1 data and instruction caches (ARM, x86).

---

## Summary

| Design | Index  | Tag      | Speed | Correctness |
|--------|--------|----------|-------|-------------|
| VIVT   | Virtual | Virtual | Fast  | Requires flush on context switch |
| PIPT   | Physical | Physical | Slower | Always correct |
| VIPT   | Virtual | Physical | Fast  | Correct if index ⊆ page offset |
