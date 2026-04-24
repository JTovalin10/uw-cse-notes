# CSE 451 - Operating Systems

Overview and index for all CSE451 notes. Design and implementation of operating systems — resource management, abstractions, security, reliability.

## Quick navigation

### Intro
- [[Operating System]] — OS definition and purpose
- [[Operating System Roles]] — what an OS does (Referee, Illusionist, Glue)
- [[Mechanism]] — mechanism vs policy in OS design
- [[Policy]] — policy in OS design
- [[Simple Memory Protection]] — basic memory protection mechanisms

### Kernel abstraction

**Exceptions**
- [[Dealing with Exceptions]] — handling CPU exceptions
- [[Exception]] — exception definition
- [[Exceptions]] — exceptions overview

**Interrupts**
- [[Interrupt Handler]] — code that responds to interrupts
- [[Interrupt Masking]] — disabling interrupts
- [[Interrupt Stack]] — stack used during interrupt handling
- [[Interrupt Vector]] — table of interrupt handlers
- [[Interrupts]] — interrupt overview
- [[How Device Interrupts Work]] — device interrupt mechanism
- [[Interrupt Timeout]] — timeout-based interrupts
- [[Interrupt Types Summary]] — summary of interrupt types
- [[Safe Interrupts]] — safely handling interrupts
- [[Source of Interrupts]] — where interrupts come from
- [[polling]] — polling vs interrupt-driven IO

**Memory**
- [[Base and Bounds]] — simple memory protection scheme
- [[External Fragmentation]] — wasted memory between allocations
- [[Internal Fragmentation]] — wasted memory within allocations
- [[Limited Growth]] — limitation of base and bounds
- [[No Sharing Problem]] — inability to share memory in base/bounds
- [[Relocation Nightmare]] — problem of relocating processes
- [[CSE451/Kernel Abstraction/Memory/Memory layout|Memory layout]] — process memory layout
- [[CSE451/Kernel Abstraction/Memory/Virtual Addresses|Virtual Addresses]] — virtual address overview (kernel section)
- [[Demand Paging]] — loading pages on demand
- [[Dynamic Growth]] — virtual memory dynamic growth
- [[Easy Sharing]] — sharing via virtual memory
- [[No More Fragmentation]] — paging solves fragmentation
- [[Page Protection]] — protecting pages with virtual memory
- [[Virtual Address Downsides]] — downsides of virtual addressing

**Modes**
- [[Hardware Modes]] — CPU hardware privilege modes
- [[Application Control]] — application-level control restrictions
- [[Kernel Mode]] — kernel privilege mode
- [[Mode Storage]] — how CPU stores current mode
- [[OS Control]] — OS-level control
- [[User Mode]] — user privilege mode
- [[Mode Switch]] — transitioning between modes
- [[Privilege Level]] — CPU privilege ring levels
- [[Dual-Mode Restrictions]] — restrictions in dual-mode operation
- [[Ring 0]] — kernel ring (highest privilege)
- [[Ring 3]] — user ring (lowest privilege)
- [[Privileged Instructions]] — instructions only runnable in kernel mode

**Registers and Flags**
- [[CLI]] — clear interrupt flag instruction
- [[EFLAGS]] — x86 flags register
- [[Control Flags]] — EFLAGS control flags
- [[Status Flags]] — EFLAGS status flags
- [[General Protection Fault (GPF)]] — protection fault on privilege violation
- [[IF]] — interrupt flag in EFLAGS
- [[STI]] — set interrupt flag instruction
- [[EAX]], [[EBX]], [[ECX]], [[EDX]], [[EDI]], [[ESI]] — general purpose registers (32-bit)
- [[EBP]], [[EIP]], [[ESP]] — 32-bit pointer registers
- [[RBP]], [[RIP]], [[RSP]] — 64-bit pointer registers
- [[Global Descriptor Table]] — x86 GDT for memory segmentation
- [[Code Segment]] — x86 code segment register

**Traps**
- [[Atomic Transfer of Control]] — atomic trap handling
- [[Handle]] — trap handler
- [[System Call]] — user-space to kernel-space request via trap
- [[Transparent Restartable Execution]] — resuming after a trap
- [[Trap Table]] — table of trap handlers
- [[Traps]] — trap overview
- [[How Traps Work]] — trap mechanism internals
- [[Trap vs Interrupt]] — comparing traps and interrupts
- [[Types of Traps]] — software exceptions, syscalls, interrupts

### Processes and threads

**CPUState**
- [[Context Switch]] — saving and restoring CPU state
- [[CPU Scheduling Information]] — data used for scheduling decisions
- [[How does the CPU interact with proc]] — CPU-process interaction
- [[CSE451/Processes/CPUState/Program Counter|Program Counter]] — instruction pointer in process context
- [[CSE451/Processes/CPUState/Registers|Registers]] — register state in a process
- [[CSE451/Processes/CPUState/Stack Pointer|Stack Pointer]] — stack pointer in process context

**Process**
- [[Process]] — process overview
- [[Process vs Thread]] — process vs thread comparison
- [[Process vs Program]] — difference between process and program
- [[Execution Context]] — CPU state captured in a process
- [[Machine State]] — full machine state of a process
- [[Process Control Block]] — PCB data structure
- [[Process ID]] — unique process identifier
- [[Process Identification]] — how processes are identified
- [[Process Management]] — OS process management
- [[Process Operations]] — fork, exec, wait, exit
- [[Process State]] — running, ready, blocked states
- [[Representation of processes by the OS]] — PCB and OS data structures
- [[State Queues]] — ready queue and blocked queue
- [[States of a user process]] — lifecycle states

**ProcessComponents**
- [[Process Address Space]] — virtual address space of a process
- [[Process Contents]] — what a process contains
- [[Process Creation]] — how processes are created
- [[Process Lifecycle Events]] — events in process lifetime
- [[Sequential Process And what is Proc]] — sequential process model

**Synchronization**
- [[Binary Semaphore]] — semaphore with binary value
- [[Bounded Buffer Problem]] — producer-consumer with bounded buffer
- [[Busy-Waiting]] — spin-waiting for a condition
- [[Condition Variables]] — signaling mechanism for synchronization
- [[Counting Semaphore]] — semaphore with integer value
- [[Critical Sections]] — mutual exclusion of critical code regions
- [[Critical Section Patterns]] — common critical section patterns
- [[Critical Section Requirements]] — atomicity, progress, bounded waiting
- [[Disabling Interrupts]] — interrupt disable for mutual exclusion
- [[Messages]] — message passing for synchronization
- [[Monitors]] — monitor synchronization construct
- [[Semaphores]] — semaphore synchronization primitive
- [[Spinlock]] — spin-based locking mechanism
- [[Locks]] — lock synchronization overview
- [[Atomic]] — atomic operations
- [[compare_and_swap]] — CAS atomic instruction
- [[test_and_set]] — TAS atomic instruction
- [[Mutual Exclusion]] — mutual exclusion concept
- [[Race Condition]] — concurrent access causing incorrect results
- [[Synchronization]] — synchronization overview

**Syscalls**
- [[Fork]] — fork() syscall to create child process
- [[Exec]] — exec() syscall to replace process image
- [[clone]] — Linux clone() syscall for threads
- [[copy-on-write]] — COW optimization for fork
- [[exec vs fork]] — exec vs fork comparison
- [[Optimizing Fork]] — fork optimizations (COW, vfork)
- [[vfork]] — vfork() syscall

**Threads**
- [[Threads Overview]] — overview of threading
- [[Achieving Multithreading]] — how multithreading is implemented
- [[Address Space with Threads]] — shared address space in threads
- [[Blocking IO Problem]] — threads solving blocking IO
- [[concurrency]] — concurrency definition and implications
- [[Deadlocks]] — circular wait causing system halt
- [[Key Idea]] — core thread concept
- [[parallelism]] — true parallel execution
- [[Starvation]] — indefinite postponement of a thread
- [[Thread Levels]] — user vs kernel thread levels
- [[Thread]] — thread definition
- [[Threads and Processes]] — relationship between threads and processes

**Scheduling**
- [[Scheduling]] — CPU scheduling overview

### Memory

**Address Translation**
- [[Address Translation]] — virtual to physical address translation
- [[Memory Management Unit]] — hardware that performs address translation
- [[MMU Address Translation]] — MMU translation details
- [[MMU Cache Control]] — MMU role in cache management
- [[MMU Memory Protection]] — MMU protection enforcement
- [[MMU TLB and Page Tables]] — MMU TLB and page table interaction
- [[Why MMU is Important]] — rationale for MMU
- [[CSE451/Memory Management/Address Translation/Page Table|Page Table]] — page table overview (OS section)
- [[Page Table Entry Anatomy]] — fields inside a page table entry
- [[Page Table Purpose]] — why page tables exist
- [[Page Table Storage]] — where page tables are stored
- [[Page Table Structure Diagram]] — visual of page table structure
- [[Page Table Translation Steps]] — step-by-step translation walkthrough
- [[Per-Process Page Tables]] — each process has its own page table
- [[CSE451/Memory Management/Address Translation/Page Table/Virtual Address Parts|Virtual Address Parts]] — parts of a virtual address
- [[Translation Lookaside Buffer (TLB)]] — translation lookaside buffer overview

**Concepts**
- [[Memory management]] — OS memory management overview
- [[Accounting Information]] — OS memory accounting
- [[Address Space Contents]] — what lives in an address space
- [[Embedded Systems]] — memory management in embedded systems
- [[Memory Management Information]] — OS memory management metadata
- [[Multiprogramming]] — running multiple programs concurrently
- [[OS Memory Responsibilities]] — what the OS manages in memory
- [[Page Coloring]] — cache-aware page allocation
- [[Primary Memory]] — RAM and primary storage
- [[Swapping]] — swapping processes to disk
- [[CSE451/Memory Management/Concepts/Virtual Addresses|Virtual Addresses]] — virtual address space concept
- [[Virtual and Physical Caches]] — caching with virtual vs physical addresses

**Memory Models**
- [[Fixed Partitions]] — dividing memory into fixed regions
- [[Page Table Entries]] — PTE structure and flags
- [[Paging]] — paging memory model
- [[Segment and Paging]] — combining segmentation and paging
- [[Segmentation]] — segment-based memory model
- [[Variable Partitions]] — variable-size memory partitions

**Virtual Memory**
- [[Paged Virtual Memory]] — virtual memory via paging
- [[Page Fault]] — page fault event
- [[Page replacement]] — page replacement overview
- [[Demanding Page]] — demand paging mechanism
- [[How do we load a program]] — program loading into virtual memory
- [[How does the OS handle page faults]] — OS page fault handler
- [[Belady's Algorithm]] — optimal page replacement algorithm
- [[Belady's Anomaly]] — more frames → more faults with FIFO
- [[Evicting the best page]] — choosing which page to evict
- [[LRU Clock]] — clock algorithm approximating LRU
- [[LRU]] — least recently used page replacement
- [[Page FIFO]] — FIFO page replacement algorithm
- [[Thrashing]] — excessive paging degrading performance
- [[Virtual Memory]] — virtual memory overview (CSE451)
- [[Working set of program behavior]] — working set model

### Storage
- [[Persistent Storage]] — persistent storage overview
- [[Secondary Storage]] — secondary storage overview
- [[HDD]] — hard disk drive specifics
- [[SSD]] — solid-state drive specifics
- [[Organization of the IO Function]] — how IO is organized in OS
- [[IO System Hardware Environment]] — hardware environment for IO
- [[File Systems]] — file system overview
- [[File]] — file abstraction in OS
- [[Directory]] — directory structure in file systems
- [[Defragmentation and TRIM operations]] — disk defrag and SSD TRIM
- [[File System Operations]] — common file system operations
- [[Flash Storage]] — flash/SSD storage
- [[Magnetic Disks]] — HDD mechanics and organization
- [[Disk Drives]] — disk drive internals

### OS architecture
- [[Major OS Components]] — kernel, shell, services overview
- [[OS Structure]] — OS architectural structure
- [[Microkernels]] — microkernel vs monolithic design
- [[Hardware Abstraction Layer]] — HAL abstracting hardware details
- [[IO]] — OS IO management
- [[Protection]] — OS protection mechanisms
- [[Command Interpreter (shell)]] — shell as command interpreter

### Virtualization
- [[Virtual Machine]] — virtual machine abstraction

### Security
- [[Meltdown]] — Meltdown speculative execution vulnerability
