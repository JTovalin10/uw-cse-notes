# CSE451: Memory Management Unit (MMU)

## What It Is
The **Memory Management Unit (MMU)** is a specialized hardware component usually integrated directly into the CPU (Central Processing Unit). Its primary job is to handle all memory and caching operations associated with the processor. It acts as the "bridge," or translator, between the software (which uses virtual addresses) and the actual hardware RAM (which uses physical addresses).

## Why It Matters
Without an MMU, modern operating systems like Windows, Linux, and macOS could not function as they do. The MMU enables **Virtual Memory**, which allows:
- The system to use more memory than is physically available, by swapping data out to the hard drive.
- Multiple programs to run simultaneously without crashing each other.

These two guarantees rest on the three core functions described below: translation (making the illusion of private, contiguous memory possible), protection (keeping processes from touching each other's memory), and cache control (keeping that translation fast).

## Core Function: Virtual to Physical Address Translation
This is the most critical function of the MMU.

**Virtual addresses**: Programs running on a computer do not know where their data is physically stored in RAM. Instead, they operate exclusively on "virtual addresses" that are provided and managed by the operating system.

**Physical addresses**: The actual location of data on the memory chips themselves.

**The translation**: When a program tries to access data, the MMU intercepts the virtual address and translates it into the correct physical address so the CPU can retrieve the data. To go from virtual to physical, the MMU adds a level of indirection through the **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table|Page Table]]**, which translates a virtual page to a physical frame:
- A virtual address has two parts: the virtual page number and the offset.
- The virtual page number (VPN) is an index into a page table.
- The page table entry contains the page frame number (PFN).
- The physical address is `PFN::offset` (the PFN concatenated with the offset).

See **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Translation Steps|Page Table Translation Steps]]** for the detailed multi-level lookup algorithm the MMU performs to carry out this translation.

## Core Function: Memory Protection
The MMU ensures that distinct processes (programs) run in isolation. It prevents a malicious or buggy program from writing data into the memory space of another program or of the operating system itself.

If a program tries to access memory it doesn't have permission for, the MMU raises a hardware exception, often called a **"segmentation fault."** This protection is enforced at the granularity of individual page table entries — see **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Entry Anatomy|Page Table Entry Anatomy]]** for the valid and protection bits that trigger this exception, and **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Per-Process Page Tables|Per-Process Page Tables]]** for why one process can never even reference another process's frames.

## Core Function: Cache Control
The MMU helps manage the CPU caches (L1, L2, etc.), determining which parts of memory are cacheable and maintaining cache coherency.

## How Translation Stays Fast: TLB and Page Tables
To perform translations quickly, the MMU relies on two main structures working together:

**Page Tables**: Data structures stored in RAM that map virtual pages to physical frames. However, looking up addresses in RAM is slow, since it means an extra memory access just to find where the real data lives.

**[[Operating Systems/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]]**: A small, ultra-fast hardware cache located inside the MMU. It stores the most recent address translations so the MMU does not have to repeat a full page table walk for every memory access.
- **TLB hit**: The MMU finds the translation already cached in the TLB (very fast).
- **TLB miss**: The MMU has to look up the translation in the slower page tables in RAM.

This relationship is the reason the MMU, the page table, and the TLB are documented as three separate but tightly coupled mechanisms: the MMU is the hardware unit that performs the work, the page table is the on-disk/in-RAM data structure it consults, and the TLB is the cache that lets it skip that consultation most of the time.

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| Memory Management Unit (MMU) | MMU (standard term; also called the "paging unit" in some x86 documentation) |
| Segmentation fault | SIGSEGV / access violation |
| Page Table | Page table (standard term) |

## Related
- [[Operating Systems/Virtualization/Memory/Address Translation/Address Translation|Address Translation]] — the overview/hub page linking translation, MMU, page tables, and the TLB together.
- [[Operating Systems/Virtualization/Memory/Address Translation/Page Table|Page Table]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]]
- [[Operating Systems/Virtualization/Memory/Page Fault|Page Fault]]
