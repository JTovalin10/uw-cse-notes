# CSE451: Virtual Addresses

Processes use **virtual addresses** that are independent of their location in physical memory — the OS determines where a process's data actually lives in physical memory, and the process itself never needs to know or care about that physical location.

Instructions issued by the CPU reference virtual addresses. These virtual addresses are translated by hardware into physical addresses, with the translation structures set up by the OS — see **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table|Page Table]]** for the data structure that stores this mapping, and **[[Operating Systems/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]]** for the hardware cache that speeds up repeated translations.

The set of virtual addresses a process can reference is called its **address space**. See **[[Operating Systems/Virtualization/Memory/Concepts/Address Space Contents|Address Space Contents]]** for what regions make up that address space (stack, heap, static data, code).

## Related
- [[Operating Systems/Virtualization/Memory/Address Translation/Page Table|Page Table]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]]
- [[Operating Systems/Virtualization/Memory/Concepts/Address Space Contents|Address Space Contents]]
- [[Operating Systems/Virtualization/Memory/Concepts/Virtual and Physical Caches|Virtual and Physical Caches]]
- [[Hardware & Software Interface/Memory Management/Virtual Memory|CSE351: Virtual Memory]]
