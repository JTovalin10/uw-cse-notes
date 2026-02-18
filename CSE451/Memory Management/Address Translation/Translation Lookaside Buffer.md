## what is it
- a hardware cache of recent virtual-to-physical address translations
- part of the chip's memory management unit (MMU)
- solves the performance problem of [[CSE451/Kernel Abstraction/Memory/Virtual Addresses]]: without a TLB, every memory access requires walking the page table (extra memory accesses per instruction)
- typically holds 32-256 entries

## how it works
1. extract the virtual page number (VPN) from the virtual address
2. check if VPN is in the TLB
3. **TLB hit**: get the physical frame number (PFN), form the physical address, access memory
4. **TLB miss**: walk the page table, find the translation, install it in the TLB, retry

works because of **locality**:
- temporal locality — recently accessed pages will likely be accessed again
- spatial locality — nearby addresses are on the same page, so one TLB entry covers many accesses

## TLB entry contents
| field | purpose |
|-------|---------|
| VPN | virtual page number being translated |
| PFN | physical frame number (actual location) |
| valid bit | whether this entry has a valid translation |
| protection bits | read/write/execute permissions |
| dirty bit | whether the page has been written to |
| ASID | address space identifier (which process owns this entry) |

## TLB miss handling
two approaches:

**hardware-managed (x86)**
- CPU automatically walks the page table on a miss
- hardware knows the page table format

**software-managed (MIPS, SPARC)**
- TLB miss raises an [[Exception]]
- OS trap handler walks the page table and installs the entry
- more flexible — OS can use any page table format

## context switches and the TLB
problem: after a [[Context Switch]], TLB entries belong to the old process

**flush the TLB**
- clear all entries on every context switch
- simple but expensive — next process starts with all misses

**use ASIDs (address space identifiers)**
- tag each TLB entry with a process identifier
- entries from multiple processes can coexist
- no flush needed, better performance

## replacement policies
when the TLB is full and a new entry must be added:
- **LRU** — evict the least recently used entry
- **random** — evict a random entry; simpler hardware, surprisingly effective

## why it matters
- without TLB: every instruction that touches memory needs 1+ extra memory accesses for translation
- with TLB: translation is nearly free on a hit (just a fast cache lookup)
- TLB miss rate is the key metric — even a small TLB covers most accesses due to locality
