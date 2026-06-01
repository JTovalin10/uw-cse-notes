# CSE 451 - Operating Systems

Overview and index for all CSE451 notes. Design and implementation of operating systems — resource management, abstractions, security, reliability.

## Quick navigation

### Intro
- [[Operating Systems/Virtualization/Architecture/Operating System|Operating System]] — OS definition and purpose
- [[Operating System Roles|Operating System Roles]] — what an OS does (Referee, Illusionist, Glue)
- [[Mechanism|Mechanism]] — mechanism vs policy in OS design
- [[Policy|Policy]] — policy in OS design
- [[Simple Memory Protection|Simple Memory Protection]] — basic memory protection mechanisms

### Kernel abstraction

**Exceptions**
- [[Dealing with Exceptions|Dealing with Exceptions]] — handling CPU exceptions
- [[Operating Systems/Virtualization/Mechanisms/Exceptions/Exception|Exception]] — exception definition
- [[Operating Systems/Virtualization/Mechanisms/Exceptions/Exception|Exceptions]] — exceptions overview

**Interrupts**
- [[Interrupt Handler|Interrupt Handler]] — code that responds to interrupts
- [[Interrupt Masking|Interrupt Masking]] — disabling interrupts
- [[Interrupt Stack|Interrupt Stack]] — stack used during interrupt handling
- [[Interrupt Vector|Interrupt Vector]] — table of interrupt handlers
- [[Interrupts|Interrupts]] — interrupt overview
- [[How Device Interrupts Work|How Device Interrupts Work]] — device interrupt mechanism
- [[Interrupts#Interrupt Timeout|Interrupt Timeout]] — timeout-based interrupts
- [[Interrupt Types Summary|Interrupt Types Summary]] — summary of interrupt types
- [[Interrupts#Safe Interrupts|Safe Interrupts]] — safely handling interrupts
- [[Source of Interrupts|Source of Interrupts]] — where interrupts come from
- [[polling|polling]] — polling vs interrupt-driven IO

**Memory**
- [[Base and Bounds|Base and Bounds]] — simple memory protection scheme
- [[External Fragmentation|External Fragmentation]] — wasted memory between allocations
- [[Internal Fragmentation|Internal Fragmentation]] — wasted memory within allocations
- [[Limited Growth|Limited Growth]] — limitation of base and bounds
- [[No Sharing Problem|No Sharing Problem]] — inability to share memory in base/bounds
- [[Relocation Nightmare|Relocation Nightmare]] — problem of relocating processes
- [[Operating Systems/Virtualization/Mechanisms/Memory/Memory layout|Memory layout]] — process memory layout
- [[Operating Systems/Virtualization/Memory/Concepts/Virtual Addresses|Virtual Addresses]] — virtual address overview (kernel section)
- [[Demand Paging|Demand Paging]] — loading pages on demand
- [[Dynamic Growth|Dynamic Growth]] — virtual memory dynamic growth
- [[Easy Sharing|Easy Sharing]] — sharing via virtual memory
- [[No More Fragmentation|No More Fragmentation]] — paging solves fragmentation
- [[Page Protection|Page Protection]] — protecting pages with virtual memory
- [[Virtual Address Downsides|Virtual Address Downsides]] — downsides of virtual addressing

**Modes**
- [[Hardware Modes|Hardware Modes]] — CPU hardware privilege modes
- [[Application Control|Application Control]] — application-level control restrictions
- [[Kernel Mode|Kernel Mode]] — kernel privilege mode
- [[Mode Storage|Mode Storage]] — how CPU stores current mode
- [[OS Control|OS Control]] — OS-level control
- [[User Mode|User Mode]] — user privilege mode
- [[Mode Switch|Mode Switch]] — transitioning between modes
- [[Privilege Level|Privilege Level]] — CPU privilege ring levels
- [[Dual-Mode Restrictions|Dual-Mode Restrictions]] — restrictions in dual-mode operation
- [[Ring 0|Ring 0]] — kernel ring (highest privilege)
- [[Ring 3|Ring 3]] — user ring (lowest privilege)
- [[Privileged Instructions|Privileged Instructions]] — instructions only runnable in kernel mode

**Registers and Flags**
- [[CLI|CLI]] — clear interrupt flag instruction
- [[EFLAGS|EFLAGS]] — x86 flags register
- [[Control Flags|Control Flags]] — EFLAGS control flags
- [[Status Flags|Status Flags]] — EFLAGS status flags
- [[General Protection Fault (GPF)|General Protection Fault (GPF)]] — protection fault on privilege violation
- [[IF|IF]] — interrupt flag in EFLAGS
- [[STI|STI]] — set interrupt flag instruction
- [[EAX|EAX]], [[EBX|EBX]], [[ECX|ECX]], [[EDX|EDX]], [[EDI|EDI]], [[ESI|ESI]] — general purpose registers (32-bit)
- [[EBP|EBP]], [[EIP|EIP]], [[ESP|ESP]] — 32-bit pointer registers
- [[RBP|RBP]], [[RIP|RIP]], [[RSP|RSP]] — 64-bit pointer registers
- [[Global Descriptor Table|Global Descriptor Table]] — x86 GDT for memory segmentation
- [[Code Segment|Code Segment]] — x86 code segment register

**Traps**
- [[Atomic Transfer of Control|Atomic Transfer of Control]] — atomic trap handling
- [[Handle|Handle]] — trap handler
- [[System Call|System Call]] — user-space to kernel-space request via trap
- [[Transparent Restartable Execution|Transparent Restartable Execution]] — resuming after a trap
- [[Trap Table|Trap Table]] — table of trap handlers
- [[Traps|Traps]] — trap overview
- [[How Traps Work|How Traps Work]] — trap mechanism internals
- [[Trap vs Interrupt|Trap vs Interrupt]] — comparing traps and interrupts
- [[Types of Traps|Types of Traps]] — software exceptions, syscalls, interrupts

### Processes and threads

**CPUState**
- [[CPU State#Context Switch|Context Switch]] — saving and restoring CPU state
- [[CPU State#CPU Scheduling Information|CPU Scheduling Information]] — data used for scheduling decisions
- [[How does the CPU interact with proc|How does the CPU interact with proc]] — CPU-process interaction
- [[CPU State#Program Counter (PC)|Program Counter]] — instruction pointer in process context
- [[CPU State#Registers|Registers]] — register state in a process
- [[CPU State#Stack Pointer (SP)|Stack Pointer]] — stack pointer in process context

**Process**
- [[Process|Process]] — process overview
- [[Process vs Thread|Process vs Thread]] — process vs thread comparison
- [[Process#Process vs Program|Process vs Program]] — difference between process and program
- [[Process#Execution Context|Execution Context]] — CPU state captured in a process
- [[Process#Machine State|Machine State]] — full machine state of a process
- [[Process Control Block|Process Control Block]] — PCB data structure
- [[Process#Process Identification (PID)|Process ID]] — unique process identifier
- [[Process#Process Identification (PID)|Process Identification]] — how processes are identified
- [[Operating Systems/Virtualization/Processes/Process/Process Management|Process Management]] — OS process management
- [[Process Operations|Process Operations]] — fork, exec, wait, exit
- [[Process State|Process State]] — running, ready, blocked states
- [[Representation of processes by the OS|Representation of processes by the OS]] — PCB and OS data structures
- [[State Queues|State Queues]] — ready queue and blocked queue
- [[Process State#User Process States (Diagram)|States of a user process]] — lifecycle states

**ProcessComponents**
- [[Process#Process's Address Space (idealized)|Process Address Space]] — virtual address space of a process
- [[Process#Process Contents|Process Contents]] — what a process contains
- [[Process Creation|Process Creation]] — how processes are created
- [[Process Lifecycle Events|Process Lifecycle Events]] — events in process lifetime
- [[Sequential Process And what is Proc|Sequential Process And what is Proc]] — sequential process model

**Synchronization**
- [[Binary Semaphore|Binary Semaphore]] — semaphore with binary value
- [[Bounded Buffer Problem|Bounded Buffer Problem]] — producer-consumer with bounded buffer
- [[Busy-Waiting|Busy-Waiting]] — spin-waiting for a condition
- [[Condition Variables|Condition Variables]] — signaling mechanism for synchronization
- [[Counting Semaphore|Counting Semaphore]] — semaphore with integer value
- [[Critical Sections|Critical Sections]] — mutual exclusion of critical code regions
- [[Critical Section Patterns|Critical Section Patterns]] — common critical section patterns
- [[Critical Section Requirements|Critical Section Requirements]] — atomicity, progress, bounded waiting
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Disabling Interrupts|Disabling Interrupts]] — interrupt disable for mutual exclusion
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Messages|Messages]] — message passing for synchronization
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Monitors|Monitors]] — monitor synchronization construct
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Semaphores|Semaphores]] — semaphore synchronization primitive
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Spinlock|Spinlock]] — spin-based locking mechanism
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Locks/Locks|Locks]] — lock synchronization overview
- [[Atomic|Atomic]] — atomic operations
- [[compare_and_swap|compare_and_swap]] — CAS atomic instruction
- [[test_and_set|test_and_set]] — TAS atomic instruction
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Mutual Exclusion|Mutual Exclusion]] — mutual exclusion concept
- [[Race Condition|Race Condition]] — concurrent access causing incorrect results
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Synchronization|Synchronization]] — synchronization overview
- [[Operating Systems/Concurrency/Synchronization|Synchronization Primitives]] — Mutex/Spinlock, CAS, RCU, and Deadlock

**Syscalls**
- [[Fork|Fork]] — fork() syscall to create child process
- [[Exec|Exec]] — exec() syscall to replace process image
- [[Signals and Syscalls|Signals and Syscalls]] — Trap mechanism, vDSO, FDs, and Signal safety
- [[clone|clone]] — Linux clone() syscall for threads
- [[Copy-on-Write|copy-on-write]] — COW optimization for fork
- [[exec vs fork|exec vs fork]] — exec vs fork comparison
- [[Optimizing Fork|Optimizing Fork]] — fork optimizations (COW, vfork)
- [[vfork|vfork]] — vfork() syscall

**Threads**
- [[Threads Overview|Threads Overview]] — overview of threading
- [[Achieving Multithreading|Achieving Multithreading]] — how multithreading is implemented
- [[Address Space with Threads|Address Space with Threads]] — shared address space in threads
- [[Blocking IO Problem|Blocking IO Problem]] — threads solving blocking IO
- [[Threads Overview#Concurrency vs. Parallelism|concurrency]] — concurrency definition and implications
- [[Operating Systems/Concurrency/Problems/Deadlocks|Deadlocks]] — circular wait causing system halt
- [[Key Idea|Key Idea]] — core thread concept
- [[Threads Overview#Concurrency vs. Parallelism|parallelism]] — true parallel execution
- [[Starvation|Starvation]] — indefinite postponement of a thread
- [[Thread Levels|Thread Levels]] — user vs kernel thread levels
- [[Thread|Thread]] — thread definition
- [[Threads and Processes|Threads and Processes]] — relationship between threads and processes

**Scheduling**
- [[Scheduling|Scheduling]] — CPU scheduling overview

### Memory

**Address Translation**
- [[Address Translation|Address Translation]] — virtual to physical address translation
- [[Memory Management Unit|Memory Management Unit]] — hardware that performs address translation
- [[MMU Address Translation|MMU Address Translation]] — MMU translation details
- [[MMU Cache Control|MMU Cache Control]] — MMU role in cache management
- [[MMU Memory Protection|MMU Memory Protection]] — MMU protection enforcement
- [[MMU TLB and Page Tables|MMU TLB and Page Tables]] — MMU TLB and page table interaction
- [[Why MMU is Important|Why MMU is Important]] — rationale for MMU
- [[Page Table|Page Table]] — page table overview (OS section)
- [[Page Table Entry Anatomy|Page Table Entry Anatomy]] — fields inside a page table entry
- [[Page Table Purpose|Page Table Purpose]] — why page tables exist
- [[Page Table Storage|Page Table Storage]] — where page tables are stored
- [[Page Table Structure Diagram|Page Table Structure Diagram]] — visual of page table structure
- [[Page Table Translation Steps|Page Table Translation Steps]] — step-by-step translation walkthrough
- [[Per-Process Page Tables|Per-Process Page Tables]] — each process has its own page table
- [[Virtual Address Parts|Virtual Address Parts]] — parts of a virtual address
- [[Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]] — translation lookaside buffer overview

**Concepts**
- [[Memory management|Memory management]] — OS memory management overview
- [[Accounting Information|Accounting Information]] — OS memory accounting
- [[Address Space Contents|Address Space Contents]] — what lives in an address space
- [[Embedded Systems|Embedded Systems]] — memory management in embedded systems
- [[Memory Management Information|Memory Management Information]] — OS memory management metadata
- [[Multiprogramming|Multiprogramming]] — running multiple programs concurrently
- [[OS Memory Responsibilities|OS Memory Responsibilities]] — what the OS manages in memory
- [[Page Coloring|Page Coloring]] — cache-aware page allocation
- [[Primary Memory|Primary Memory]] — RAM and primary storage
- [[Buddy Allocator|Buddy Allocator]] — binary tree-based page allocator
- [[Slab Allocation|Slab Allocation]] — kernel object caching allocator
- [[TLABs|TLABs]] — thread-local allocation buffers
- [[Swapping|Swapping]] — swapping processes to disk
- [[Operating Systems/Virtualization/Memory/Concepts/Virtual Addresses|Virtual Addresses]] — virtual address space concept
- [[Virtual and Physical Caches|Virtual and Physical Caches]] — caching with virtual vs physical addresses

**Memory Models**
- [[Fixed Partitions|Fixed Partitions]] — dividing memory into fixed regions
- [[Page Table Entries|Page Table Entries]] — PTE structure and flags
- [[Operating Systems/Virtualization/Memory/Memory Models/Paging|Paging]] — paging memory model
- [[Segment and Paging|Segment and Paging]] — combining segmentation and paging
- [[Segmentation|Segmentation]] — segment-based memory model
- [[Variable Partitions|Variable Partitions]] — variable-size memory partitions

**Virtual Memory**
- [[Paged Virtual Memory|Paged Virtual Memory]] — virtual memory via paging
- [[Page Fault|Page Fault]] — page fault event
- [[Page replacement|Page replacement]] — page replacement overview
- [[Demanding Page|Demanding Page]] — demand paging mechanism
- [[How do we load a program|How do we load a program]] — program loading into virtual memory
- [[How does the OS handle page faults|How does the OS handle page faults]] — OS page fault handler
- [[Belady's Algorithm|Belady's Algorithm]] — optimal page replacement algorithm
- [[Belady's Anomaly|Belady's Anomaly]] — more frames → more faults with FIFO
- [[Evicting the best page|Evicting the best page]] — choosing which page to evict
- [[LRU Clock|LRU Clock]] — clock algorithm approximating LRU
- [[LRU|LRU]] — least recently used page replacement
- [[Page FIFO|Page FIFO]] — FIFO page replacement algorithm
- [[Thrashing|Thrashing]] — excessive paging degrading performance
- [[Operating Systems/Virtualization/Memory/Virtual Memory|Virtual Memory]] — virtual memory overview (CSE451)
- [[Operating Systems/Memory/Virtual Memory|Virtual Memory Deep Dive]] — Multi-level page tables, TLB shootdown, ASID, and Page Faults
- [[Allocation|Memory Allocation]] — Slab allocator, sbrk/mmap, and Linux memory metrics
- [[Working set of program behavior|Working set of program behavior]] — working set model

### Storage
- [[Persistent Storage|Persistent Storage]] — persistent storage overview
- [[Storage and FS|Storage and File Systems]] — SSD/HDD mechanics, Inodes, VFS, and Journaling
- [[Secondary Storage|Secondary Storage]] — secondary storage overview
- [[HDD|HDD]] — hard disk drive specifics
- [[SSD|SSD]] — solid-state drive specifics
- [[Organization of the IO Function|Organization of the IO Function]] — how IO is organized in OS
- [[IO System Hardware Environment|IO System Hardware Environment]] — hardware environment for IO
- [[File Systems|File Systems]] — file system overview
- [[File|File]] — file abstraction in OS
- [[Directory|Directory]] — directory structure in file systems
- [[Defragmentation and TRIM operations|Defragmentation and TRIM operations]] — disk defrag and SSD TRIM
- [[File System Operations|File System Operations]] — common file system operations
- [[Flash Storage|Flash Storage]] — flash/SSD storage
- [[Magnetic Disks|Magnetic Disks]] — HDD mechanics and organization
- [[Disk Drives|Disk Drives]] — disk drive internals

### OS architecture
- [[Major OS Components|Major OS Components]] — kernel, shell, services overview
- [[OS Structure|OS Structure]] — OS architectural structure
- [[Kernel Internals|Kernel Internals and Performance]] — Interrupts, perf, eBPF, and architectures
- [[Microkernels|Microkernels]] — microkernel vs monolithic design
- [[Hardware Abstraction Layer|Hardware Abstraction Layer]] — HAL abstracting hardware details
- [[IO|IO]] — OS IO management
- [[Protection|Protection]] — OS protection mechanisms
- [[Command Interpreter (shell)|Command Interpreter (shell)]] — shell as command interpreter

### Virtualization
- [[Virtual Machine|Virtual Machine]] — virtual machine abstraction
- [[Containers and Virt|Containers and Virtualization]] — VT-x, KVM, Namespaces, and cgroups

### Security
- [[Meltdown|Meltdown]] — Meltdown speculative execution vulnerability
