# Program Loading and Execution: The OS Loader

## Low-Level Primer: The Loader's Role
In an Operating System, the **Loader** is the critical kernel component responsible for transitioning a static binary on disk into a dynamic, executing process in memory. It bridges the gap between the **[[File System]]** and **[[Memory Management]]** subsystems. The loading process is not a simple "copy-paste" from disk to RAM; it is a sophisticated orchestration of metadata allocation, address space mapping, and lazy-loading mechanisms.

---

## Technical Lifecycle of Program Loading

### 1. Process Descriptor Allocation
The kernel first allocates a **[[Process Control Block (PCB)]]** to track the state of the new entity.
*   **Actions**: Assigns a unique **[[Process ID (PID)]]**, initializes CPU registers (cleared to zero), and sets the process state to `NEW`.

### 2. Address Space Initialization
The OS creates the **[[Virtual Address Space]]** for the process.
*   **Page Table Creation**: The kernel allocates frames for the top-level **[[Page Table]]**.
*   **Virtual Mapping**: The loader parses the binary's header (e.g., **ELF header** on Linux) and maps segments (CODE, DATA, BSS) to specific virtual address ranges.
*   **Note**: No physical memory is allocated for the program code yet; only the virtual mappings are established.

### 3. Demand Paging Setup
The loader sets up the **[[Demand Paging]]** mechanism.
*   **PTE Configuration**: All **[[Page Table Entries (PTEs)]]** are initially marked as `INVALID`.
*   **Backing Store Mapping**: An internal kernel data structure (the **VNODE** or **swap mapping**) tracks the exact byte offset on disk where each virtual page resides.

### 4. Cold Start and Execution
When the CPU is jumped to the entry point (e.g., `_start`):
1.  **Instruction Fetch**: The CPU attempts to fetch the first instruction.
2.  **[[Page Fault]]**: The hardware triggers a fault because the PTE is invalid.
3.  **Kernel Intervention**: The OS catches the fault, identifies the disk location from the backing store, allocates a physical **[[Page Frame]]**, and copies 4KB of data from disk to RAM.
4.  **Resumption**: The PTE is updated with the frame number, marked `VALID`, and the instruction is re-executed.

---

## Expert Augmentation: Dynamic Linking (PLT and GOT)

In modern systems, programs do not include the code for every library they use (e.g., `printf` from `libc`). Instead, they use **Dynamic Linking** via the **[[Procedure Linkage Table (PLT)]]** and the **[[Global Offset Table (GOT)]]**.

### The Mechanism of Lazy Binding
Dynamic linking utilizes a "Lazy Binding" strategy to avoid the overhead of resolving every library symbol at load time.

1.  **Initial Call**: When the program calls a library function (e.g., `malloc@plt`):
    *   It jumps to a specific entry in the **PLT**.
    *   The PLT entry jumps to an address stored in the **GOT**.
    *   On the *first call*, the GOT entry actually points back to a "resolver" routine in the PLT.
2.  **Dynamic Resolution**:
    *   The PLT resolver invokes the **Dynamic Linker** (`ld.so`).
    *   The linker searches for the symbol in the loaded libraries, finds its physical memory address, and **updates the GOT entry**.
3.  **Subsequent Calls**:
    *   The program jumps to the PLT entry again.
    *   The PLT entry jumps to the address in the GOT.
    *   Because the GOT has been updated, the jump goes **directly to the library function**, bypassing the resolver.

### Security Impact: ASLR and PIC
*   **[[Address Space Layout Randomization (ASLR)]]**: The OS randomizes the base addresses of libraries. This makes the GOT/PLT mechanism essential, as the program cannot hardcode addresses.
*   **[[Position Independent Code (PIC)]]**: Shared libraries are compiled to use relative addressing, allowing them to be loaded at any address without modification.

---

## Loading Summary Table

| Step | System Component | Primary Goal |
| :--- | :--- | :--- |
| **PCB Allocation** | Kernel Process Mgr | Create the identity and state tracker. |
| **Header Parsing** | Loader | Identify segment sizes and entry points. |
| **Page Table Setup**| MMU / Kernel | Define the virtual memory layout. |
| **Mapping** | Virtual Memory Subsystem | Link virtual pages to file offsets on disk. |
| **Execution** | CPU / Hardware | Trigger demand paging via Page Faults. |
| **Dynamic Linking** | PLT / GOT / ld.so | Resolve external library dependencies at runtime. |

[Image: Memory layout diagram showing Code, Data, Heap, and Stack segments with PLT/GOT sections.]
[Image: Sequence diagram of a lazy binding call involving the PLT, GOT, and Dynamic Linker.]
