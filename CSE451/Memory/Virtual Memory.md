# CSE451: Virtual Memory

Virtual Memory is a memory management technique that creates an abstraction of a large, contiguous address space for each process, decoupling the **[[CSE451/Memory/Definitions/Virtual Address|Virtual Address]]** from the **[[Physical Address]]**. This is managed by the hardware **[[Memory Management Unit (MMU)]]** in coordination with the Operating System kernel.

### Multi-level Page Tables
As address spaces grew (e.g., 64-bit), a single-level page table became impractical due to the massive contiguous memory required to store it. **[[Multi-level Page Tables]]** solve this by using a tree-like structure.

#### Formal Definition
For a 32-bit address with 4KB pages:
- **Level 1 (Page Directory)**: 10 bits
- **Level 2 (Page Table)**: 10 bits
- **Offset**: 12 bits
Total entries = $2^{10} \times 2^{10} = 2^{20}$ pages.

#### Simplified Explanation
Instead of a giant book with a page for every house in the city, you have an index of neighborhoods. If a neighborhood is empty, you don't need the sub-index for those houses.

### Page Table Walk
A **[[Page Table Walk]]** is the process the hardware MMU performs to translate a virtual address to a physical one.
1. The CPU looks at the **[[Control Register 3 (CR3)]]** (on x86) to find the root of the page table.
2. It uses the top bits of the virtual address as an index into the Page Directory.
3. If the **[[Valid Bit]]** is set, it follows the pointer to the next level.
4. It repeats until it reaches the leaf node, which contains the **[[Physical Page Frame Number (PFN)]]**.
5. It combines the PFN with the original offset to access physical RAM.

### Translation Lookaside Buffer (TLB)
The **[[Translation Lookaside Buffer (TLB)]]** is a high-speed hardware cache that stores recent virtual-to-physical mappings to bypass the expensive Page Table Walk.

- **[[TLB Hit]]**: The mapping is found in the cache; translation is near-instant.
- **[[TLB Miss]]**: The mapping is absent; a Page Table Walk must occur, and the result is cached.
- **[[TLB Shootdown]]**: When a mapping is changed on one core, it must notify other cores via an Inter-Processor Interrupt (IPI) to invalidate their local TLBs. This is a major performance bottleneck in multi-core systems.
- **[[Address Space Identifier (ASID)]]**: A tag in the TLB that identifies which process a mapping belongs to, allowing the TLB to persist across context switches.

### Page Faults
A **[[Page Fault]]** is an exception raised by the MMU when a translation fails.
- **[[Minor Page Fault]]**: The page is in RAM but not mapped in the process's page table (e.g., shared library).
- **[[Major Page Fault]]**: The page is not in RAM and must be loaded from disk (Swap or File).
- **[[Protection Fault]]**: The page is present, but the process lacks permissions (e.g., writing to a read-only code segment). This often results in a **[[Segmentation Fault (SIGSEGV)]]**.

### Page Replacement Algorithms
When physical memory is full, the OS must choose a victim page to evict.
- **[[Optimal Algorithm]]**: Replace the page that will not be used for the longest time in the future. (Impossible to implement, used as a benchmark).
- **[[Least Recently Used (LRU)]]**: Replace the page that hasn't been used for the longest time.
- **[[Clock Algorithm]]**: A circular buffer approximation of LRU using a "use bit".
- **[[Working Set]]**: The collection of pages a process is actively using. If the total working sets of all processes exceed RAM, the system enters **[[Thrashing]]**, where it spends all its time swapping.

### Linux Specifics
- **[[Highmem]]**: Memory that is not permanently mapped into the kernel's 1GB address space (on 32-bit systems).
- **[[Swappiness]]**: A kernel parameter (`/proc/sys/vm/swappiness`) that controls how aggressively the kernel swaps anonymous memory vs. dropping filesystem caches.
- **[[Dirty Ratio]]**: The percentage of system memory that can be filled with "dirty" (modified but not written to disk) pages before the kernel forces background writes.

### Related
- [[CSE351/Memory Management/Virtual Memory]]
- [[CSE451/Processes/Context Switching]]
- [[CSE451/Persistence/File Systems]]
