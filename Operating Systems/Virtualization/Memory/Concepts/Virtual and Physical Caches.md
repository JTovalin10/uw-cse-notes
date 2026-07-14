# CSE451: Virtual and Physical Caches

Caches can be indexed and tagged using either **[[Operating Systems/Virtualization/Memory/Concepts/Virtual Addresses|virtual addresses]]** or physical addresses, leading to different design tradeoffs between speed and correctness.

## The Two Dimensions

A cache lookup involves two separate uses of an address: the **index** (which selects a cache set) and the **tag** (which is compared against the stored entry to confirm a hit). Each of these can independently be virtual or physical, giving three practical designs:

| Design | Index  | Tag      | Speed | Correctness |
|--------|--------|----------|-------|-------------|
| VIVT   | Virtual | Virtual | Fast  | Requires flush on context switch |
| PIPT   | Physical | Physical | Slower | Always correct |
| VIPT   | Virtual | Physical | Fast  | Correct if index ⊆ page offset |

## Trade-offs

- **VIVT (Virtually Indexed, Virtually Tagged)**: The fastest option, since the cache can be checked before any address translation happens at all — no **[[Operating Systems/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|TLB]]** lookup or **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table|Page Table]]** walk is needed on the critical path. However, because different processes can use the same virtual address for different physical data, the cache must be flushed (or tagged with a process/address-space identifier) on every context switch to avoid one process reading another's stale cached data.
- **PIPT (Physically Indexed, Physically Tagged)**: Always correct, since both the index and tag are derived from the physical address, which uniquely identifies memory regardless of which process is running. The cost is speed — the address must be fully translated (a TLB lookup, and on a miss, a full page table walk) before the cache can even be indexed.
- **VIPT (Virtually Indexed, Physically Tagged)**: A compromise that indexes with the virtual address (fast, since no translation is needed to pick a set) but tags with the physical address (correct, since the tag comparison happens after translation completes in parallel with the cache lookup). This design is only correct without extra precautions if the index bits fall entirely within the page offset — i.e., the bits used for indexing are the same regardless of translation, since the page offset portion of an address never changes during virtual-to-physical translation. If the index extends beyond the page offset, the OS may need to become color-aware; see **[[Operating Systems/Virtualization/Memory/Concepts/Page Coloring|Page Coloring]]** for how this is handled.

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| VIVT | Virtually-indexed virtually-tagged cache |
| PIPT | Physically-indexed physically-tagged cache |
| VIPT | Virtually-indexed physically-tagged cache |

## Related
- [[Operating Systems/Virtualization/Memory/Concepts/Page Coloring|Page Coloring]]
- [[Operating Systems/Virtualization/Memory/Concepts/Virtual Addresses|Virtual Addresses]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]]
- [[Hardware & Software Interface/Cache/Cache Organization|Cache Organization (CSE351)]]
- [[Hardware & Software Interface/Memory Management/Virtual Memory|Virtual Memory (CSE351)]]
- [[Operating Systems/Virtualization/Memory/Memory management|OS Memory Management (CSE451)]]
