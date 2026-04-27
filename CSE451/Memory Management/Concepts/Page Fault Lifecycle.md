# Page Fault Lifecycle (Hardware + Software)

The **Page Fault** is a critical mechanism in virtual memory systems that allows the OS to handle memory accesses for pages not currently resident in physical RAM. On x86 architectures, this is handled via **Interrupt 14**.

## 1. Hardware Detection (The MMU)
1. **Instruction Execution**: The CPU attempts to access a virtual address.
2. **TLB Miss**: The address is not in the TLB; the MMU performs a **Page Table Walk**.
3. **PTE Check**: The MMU finds the Page Table Entry (PTE). It checks the **Present Bit** and **Protection Bits**.
4. **Fault Trigger**: If the Present Bit is 0, or if the operation (Read/Write/Execute) violates the Protection Bits, the MMU stops and triggers a **Hardware Exception** (Interrupt 14).

## 2. Transition to Kernel Mode
1. **Context Save**: The CPU saves the current Program Counter (PC) and flags. On x86, it pushes an **Error Code** onto the kernel stack (indicating if the fault was due to a non-present page or a protection violation).
2. **Register Update**: The faulting virtual address is stored in the **CR2 register**.
3. **Trap Handler**: The CPU jumps to the address specified in the **Interrupt Descriptor Table (IDT)** for entry 14.

## 3. OS Exception Handler
1. **Identify the Address**: The OS reads the CR2 register to determine which address caused the fault.
2. **VMA Lookup**: The OS looks up the process's **Virtual Memory Areas (VMA)** or "Segments" to see if the address is part of a valid mapping.
    - **Invalid**: If the address is not in any VMA, the OS sends a `SIGSEGV` (Segmentation Fault).
3. **Select Victim Frame**: If RAM is full, the OS runs a **Page Replacement Algorithm** (e.g., LRU, Clock) to pick a physical frame to evict.
4. **I/O Operation**:
    - If the page is on disk (Swap or File-backed), the OS issues a disk read.
    - The faulting process is moved to the **Blocked** state.
    - The CPU is yielded to another process.

## 4. Completion and Resumption
1. **I/O Interrupt**: When the disk controller finishes, it triggers an interrupt.
2. **Update PTE**: The OS updates the PTE with the new Physical Frame Number (PFN), sets the **Present Bit to 1**, and resets the **Dirty Bit**.
3. **TLB Invalidation**: The OS flushes the TLB entry for this virtual address (to ensure the MMU sees the update).
4. **Ready State**: The faulting process is moved to the **Ready** queue.
5. **Re-execution**: When scheduled, the OS restores the context. The CPU re-executes the **exact same instruction** that caused the fault. This time, the MMU walk succeeds.

---
**See Also**: [[CSE451/Memory Management/Concepts/Copy-on-Write|Copy-on-Write]], [[TLB Miss]]
