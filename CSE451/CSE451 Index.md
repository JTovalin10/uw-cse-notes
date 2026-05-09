# CSE 451 - Operating Systems

Overview and index for all CSE451 notes. Design and implementation of operating systems — resource management, abstractions, security, reliability.

## Quick navigation

### Intro
- [[CSE451/Virtualization/Architecture/Operating System|Operating System]] — OS definition and purpose
- [[CSE451/Virtualization/Architecture/Operating System Roles|Operating System Roles]] — what an OS does (Referee, Illusionist, Glue)
- [[CSE451/Virtualization/Architecture/Mechanism|Mechanism]] — mechanism vs policy in OS design
- [[CSE451/Virtualization/Architecture/Policy|Policy]] — policy in OS design
- [[CSE451/Virtualization/Mechanisms/Memory/Simple Memory Protection|Simple Memory Protection]] — basic memory protection mechanisms

### Kernel abstraction

**Exceptions**
- [[CSE451/Virtualization/Mechanisms/Exceptions/Dealing with Exceptions|Dealing with Exceptions]] — handling CPU exceptions
- [[CSE451/Virtualization/Mechanisms/Exceptions/Exception|Exception]] — exception definition
- [[CSE451/Virtualization/Mechanisms/Exceptions/Exception|Exceptions]] — exceptions overview

**Interrupts**
- [[CSE451/Virtualization/Mechanisms/Interrupts/Interrupt Handler|Interrupt Handler]] — code that responds to interrupts
- [[CSE451/Virtualization/Mechanisms/Interrupts/Interrupt Masking|Interrupt Masking]] — disabling interrupts
- [[CSE451/Virtualization/Mechanisms/Interrupts/Interrupt Stack|Interrupt Stack]] — stack used during interrupt handling
- [[CSE451/Virtualization/Mechanisms/Interrupts/Interrupt Vector|Interrupt Vector]] — table of interrupt handlers
- [[CSE451/Virtualization/Mechanisms/Interrupts/Interrupts|Interrupts]] — interrupt overview
- [[CSE451/Virtualization/Mechanisms/Interrupts/InterruptsComponents/How Device Interrupts Work|How Device Interrupts Work]] — device interrupt mechanism
- [[CSE451/Virtualization/Mechanisms/Interrupts/Interrupts#Interrupt Timeout|Interrupt Timeout]] — timeout-based interrupts
- [[CSE451/Virtualization/Mechanisms/Interrupts/InterruptsComponents/Interrupt Types Summary|Interrupt Types Summary]] — summary of interrupt types
- [[CSE451/Virtualization/Mechanisms/Interrupts/Interrupts#Safe Interrupts|Safe Interrupts]] — safely handling interrupts
- [[CSE451/Virtualization/Mechanisms/Interrupts/InterruptsComponents/Source of Interrupts|Source of Interrupts]] — where interrupts come from
- [[CSE451/Virtualization/Mechanisms/Interrupts/polling|polling]] — polling vs interrupt-driven IO

**Memory**
- [[CSE451/Virtualization/Mechanisms/Memory/Base and Bounds|Base and Bounds]] — simple memory protection scheme
- [[CSE451/Virtualization/Mechanisms/Memory/Base and BoundsComponents/External Fragmentation|External Fragmentation]] — wasted memory between allocations
- [[CSE451/Virtualization/Mechanisms/Memory/Base and BoundsComponents/Internal Fragmentation|Internal Fragmentation]] — wasted memory within allocations
- [[CSE451/Virtualization/Mechanisms/Memory/Base and BoundsComponents/Limited Growth|Limited Growth]] — limitation of base and bounds
- [[CSE451/Virtualization/Mechanisms/Memory/Base and BoundsComponents/No Sharing Problem|No Sharing Problem]] — inability to share memory in base/bounds
- [[CSE451/Virtualization/Mechanisms/Memory/Base and BoundsComponents/Relocation Nightmare|Relocation Nightmare]] — problem of relocating processes
- [[CSE451/Virtualization/Mechanisms/Memory/Memory layout|Memory layout]] — process memory layout
- [[CSE451/Virtualization/Memory/Concepts/Virtual Addresses|Virtual Addresses]] — virtual address overview (kernel section)
- [[CSE451/Virtualization/Mechanisms/Memory/Virtual AddressesComponents/Demand Paging|Demand Paging]] — loading pages on demand
- [[CSE451/Virtualization/Mechanisms/Memory/Virtual AddressesComponents/Dynamic Growth|Dynamic Growth]] — virtual memory dynamic growth
- [[CSE451/Virtualization/Mechanisms/Memory/Virtual AddressesComponents/Easy Sharing|Easy Sharing]] — sharing via virtual memory
- [[CSE451/Virtualization/Mechanisms/Memory/Virtual AddressesComponents/No More Fragmentation|No More Fragmentation]] — paging solves fragmentation
- [[CSE451/Virtualization/Mechanisms/Memory/Virtual AddressesComponents/Page Protection|Page Protection]] — protecting pages with virtual memory
- [[CSE451/Virtualization/Mechanisms/Memory/Virtual AddressesComponents/Virtual Address Downsides|Virtual Address Downsides]] — downsides of virtual addressing

**Modes**
- [[CSE451/Virtualization/Mechanisms/Modes/Hardware Modes|Hardware Modes]] — CPU hardware privilege modes
- [[CSE451/Virtualization/Mechanisms/Modes/Hardware ModesComponents/Application Control|Application Control]] — application-level control restrictions
- [[CSE451/Virtualization/Mechanisms/Modes/Hardware ModesComponents/Kernel Mode|Kernel Mode]] — kernel privilege mode
- [[CSE451/Virtualization/Mechanisms/Modes/Hardware ModesComponents/Mode Storage|Mode Storage]] — how CPU stores current mode
- [[CSE451/Virtualization/Mechanisms/Modes/Hardware ModesComponents/OS Control|OS Control]] — OS-level control
- [[CSE451/Virtualization/Mechanisms/Modes/Hardware ModesComponents/User Mode|User Mode]] — user privilege mode
- [[CSE451/Virtualization/Mechanisms/Modes/Mode Switch|Mode Switch]] — transitioning between modes
- [[CSE451/Virtualization/Mechanisms/Modes/Privilege Level|Privilege Level]] — CPU privilege ring levels
- [[CSE451/Virtualization/Mechanisms/Modes/Privilege LevelComponents/Dual-Mode Restrictions|Dual-Mode Restrictions]] — restrictions in dual-mode operation
- [[CSE451/Virtualization/Mechanisms/Modes/Privilege LevelComponents/Ring 0|Ring 0]] — kernel ring (highest privilege)
- [[CSE451/Virtualization/Mechanisms/Modes/Privilege LevelComponents/Ring 3|Ring 3]] — user ring (lowest privilege)
- [[CSE451/Virtualization/Mechanisms/Modes/Privileged Instructions|Privileged Instructions]] — instructions only runnable in kernel mode

**Registers and Flags**
- [[CSE451/Virtualization/Mechanisms/Registers and Flags/Flags/CLI|CLI]] — clear interrupt flag instruction
- [[CSE451/Virtualization/Mechanisms/Registers and Flags/Flags/EFLAGS|EFLAGS]] — x86 flags register
- [[CSE451/Virtualization/Mechanisms/Registers and Flags/Flags/EFLAGSComponents/Control Flags|Control Flags]] — EFLAGS control flags
- [[CSE451/Virtualization/Mechanisms/Registers and Flags/Flags/EFLAGSComponents/Status Flags|Status Flags]] — EFLAGS status flags
- [[CSE451/Virtualization/Mechanisms/Registers and Flags/Flags/General Protection Fault (GPF)|General Protection Fault (GPF)]] — protection fault on privilege violation
- [[CSE451/Virtualization/Mechanisms/Registers and Flags/Flags/IF|IF]] — interrupt flag in EFLAGS
- [[CSE451/Virtualization/Mechanisms/Registers and Flags/Flags/STI|STI]] — set interrupt flag instruction
- [[CSE451/Virtualization/Mechanisms/Registers and Flags/GeneralPurpose/EAX|EAX]], [[CSE451/Virtualization/Mechanisms/Registers and Flags/GeneralPurpose/EBX|EBX]], [[CSE451/Virtualization/Mechanisms/Registers and Flags/GeneralPurpose/ECX|ECX]], [[CSE451/Virtualization/Mechanisms/Registers and Flags/GeneralPurpose/EDX|EDX]], [[CSE451/Virtualization/Mechanisms/Registers and Flags/GeneralPurpose/EDI|EDI]], [[CSE451/Virtualization/Mechanisms/Registers and Flags/GeneralPurpose/ESI|ESI]] — general purpose registers (32-bit)
- [[CSE451/Virtualization/Mechanisms/Registers and Flags/Pointers/EBP|EBP]], [[CSE451/Virtualization/Mechanisms/Registers and Flags/Pointers/EIP|EIP]], [[CSE451/Virtualization/Mechanisms/Registers and Flags/Pointers/ESP|ESP]] — 32-bit pointer registers
- [[CSE451/Virtualization/Mechanisms/Registers and Flags/Pointers/RBP|RBP]], [[CSE451/Virtualization/Mechanisms/Registers and Flags/Pointers/RIP|RIP]], [[CSE451/Virtualization/Mechanisms/Registers and Flags/Pointers/RSP|RSP]] — 64-bit pointer registers
- [[CSE451/Virtualization/Mechanisms/x86/Global Descriptor Table|Global Descriptor Table]] — x86 GDT for memory segmentation
- [[CSE451/Virtualization/Mechanisms/x86/Code Segment|Code Segment]] — x86 code segment register

**Traps**
- [[CSE451/Virtualization/Mechanisms/Traps/Atomic Transfer of Control|Atomic Transfer of Control]] — atomic trap handling
- [[CSE451/Virtualization/Mechanisms/Traps/Handle|Handle]] — trap handler
- [[CSE451/Virtualization/Mechanisms/Traps/System Call|System Call]] — user-space to kernel-space request via trap
- [[CSE451/Virtualization/Mechanisms/Traps/Transparent Restartable Execution|Transparent Restartable Execution]] — resuming after a trap
- [[CSE451/Virtualization/Mechanisms/Traps/Trap Table|Trap Table]] — table of trap handlers
- [[CSE451/Virtualization/Mechanisms/Traps/Traps|Traps]] — trap overview
- [[CSE451/Virtualization/Mechanisms/Traps/TrapsComponents/How Traps Work|How Traps Work]] — trap mechanism internals
- [[CSE451/Virtualization/Mechanisms/Traps/TrapsComponents/Trap vs Interrupt|Trap vs Interrupt]] — comparing traps and interrupts
- [[CSE451/Virtualization/Mechanisms/Traps/TrapsComponents/Types of Traps|Types of Traps]] — software exceptions, syscalls, interrupts

### Processes and threads

**CPUState**
- [[CSE451/Virtualization/Processes/CPUState/CPU State#Context Switch|Context Switch]] — saving and restoring CPU state
- [[CSE451/Virtualization/Processes/CPUState/CPU State#CPU Scheduling Information|CPU Scheduling Information]] — data used for scheduling decisions
- [[CSE451/Virtualization/Processes/CPUState/How does the CPU interact with proc|How does the CPU interact with proc]] — CPU-process interaction
- [[CSE451/Virtualization/Processes/CPUState/CPU State#Program Counter (PC)|Program Counter]] — instruction pointer in process context
- [[CSE451/Virtualization/Processes/CPUState/CPU State#Registers|Registers]] — register state in a process
- [[CSE451/Virtualization/Processes/CPUState/CPU State#Stack Pointer (SP)|Stack Pointer]] — stack pointer in process context

**Process**
- [[CSE451/Virtualization/Processes/Process|Process]] — process overview
- [[CSE451/Virtualization/Processes/ProcessComponents/Process vs Thread|Process vs Thread]] — process vs thread comparison
- [[CSE451/Virtualization/Processes/Process#Process vs Program|Process vs Program]] — difference between process and program
- [[CSE451/Virtualization/Processes/Process#Execution Context|Execution Context]] — CPU state captured in a process
- [[CSE451/Virtualization/Processes/Process#Machine State|Machine State]] — full machine state of a process
- [[CSE451/Virtualization/Processes/Process/Process Control Block|Process Control Block]] — PCB data structure
- [[CSE451/Virtualization/Processes/Process#Process Identification (PID)|Process ID]] — unique process identifier
- [[CSE451/Virtualization/Processes/Process#Process Identification (PID)|Process Identification]] — how processes are identified
- [[CSE451/Virtualization/Processes/Process/Process Management|Process Management]] — OS process management
- [[CSE451/Virtualization/Processes/Process/Process Operations|Process Operations]] — fork, exec, wait, exit
- [[CSE451/Virtualization/Processes/Process/Process State|Process State]] — running, ready, blocked states
- [[CSE451/Virtualization/Processes/Process/Representation of processes by the OS|Representation of processes by the OS]] — PCB and OS data structures
- [[CSE451/Virtualization/Processes/Process/State Queues|State Queues]] — ready queue and blocked queue
- [[CSE451/Virtualization/Processes/Process/Process State#User Process States (Diagram)|States of a user process]] — lifecycle states

**ProcessComponents**
- [[CSE451/Virtualization/Processes/Process#Process's Address Space (idealized)|Process Address Space]] — virtual address space of a process
- [[CSE451/Virtualization/Processes/Process#Process Contents|Process Contents]] — what a process contains
- [[CSE451/Virtualization/Processes/ProcessComponents/Process Creation|Process Creation]] — how processes are created
- [[CSE451/Virtualization/Processes/ProcessComponents/Process Lifecycle Events|Process Lifecycle Events]] — events in process lifetime
- [[CSE451/Virtualization/Processes/ProcessComponents/Sequential Process And what is Proc|Sequential Process And what is Proc]] — sequential process model

**Synchronization**
- [[CSE451/Concurrency/Synchronization/Mechanics/Binary Semaphore|Binary Semaphore]] — semaphore with binary value
- [[CSE451/Concurrency/Synchronization/Mechanics/Bounded Buffer Problem|Bounded Buffer Problem]] — producer-consumer with bounded buffer
- [[CSE451/Concurrency/Synchronization/Mechanics/Busy-Waiting|Busy-Waiting]] — spin-waiting for a condition
- [[CSE451/Concurrency/Synchronization/Mechanics/Condition Variables|Condition Variables]] — signaling mechanism for synchronization
- [[CSE451/Concurrency/Synchronization/Mechanics/Counting Semaphore|Counting Semaphore]] — semaphore with integer value
- [[CSE451/Concurrency/Synchronization/Mechanics/Critical Sections/Critical Sections|Critical Sections]] — mutual exclusion of critical code regions
- [[CSE451/Concurrency/Synchronization/Mechanics/Critical Sections/Critical SectionsComponents/Critical Section Patterns|Critical Section Patterns]] — common critical section patterns
- [[CSE451/Concurrency/Synchronization/Mechanics/Critical Sections/Critical SectionsComponents/Critical Section Requirements|Critical Section Requirements]] — atomicity, progress, bounded waiting
- [[CSE451/Concurrency/Synchronization/Mechanics/Disabling Interrupts|Disabling Interrupts]] — interrupt disable for mutual exclusion
- [[CSE451/Concurrency/Synchronization/Mechanics/Messages|Messages]] — message passing for synchronization
- [[CSE451/Concurrency/Synchronization/Mechanics/Monitors|Monitors]] — monitor synchronization construct
- [[CSE451/Concurrency/Synchronization/Mechanics/Semaphores|Semaphores]] — semaphore synchronization primitive
- [[CSE451/Concurrency/Synchronization/Mechanics/Spinlock|Spinlock]] — spin-based locking mechanism
- [[CSE451/Concurrency/Synchronization/Mechanics/Locks/Locks|Locks]] — lock synchronization overview
- [[CSE451/Concurrency/Synchronization/Mechanics/Locks/LocksComponents/Atomic|Atomic]] — atomic operations
- [[CSE451/Concurrency/Synchronization/Mechanics/Locks/LocksComponents/compare_and_swap|compare_and_swap]] — CAS atomic instruction
- [[CSE451/Concurrency/Synchronization/Mechanics/Locks/LocksComponents/test_and_set|test_and_set]] — TAS atomic instruction
- [[CSE451/Concurrency/Synchronization/Mechanics/Mutual Exclusion|Mutual Exclusion]] — mutual exclusion concept
- [[CSE451/Concurrency/Synchronization/Mechanics/Race Conditions/Race Condition|Race Condition]] — concurrent access causing incorrect results
- [[CSE451/Concurrency/Synchronization/Mechanics/Synchronization|Synchronization]] — synchronization overview
- [[CSE451/Concurrency/Synchronization|Synchronization Primitives]] — Mutex/Spinlock, CAS, RCU, and Deadlock

**Syscalls**
- [[CSE451/Virtualization/Processes/Syscalls/Fork|Fork]] — fork() syscall to create child process
- [[CSE451/Virtualization/Processes/Syscalls/Exec|Exec]] — exec() syscall to replace process image
- [[CSE451/Processes/Signals and Syscalls|Signals and Syscalls]] — Trap mechanism, vDSO, FDs, and Signal safety
- [[CSE451/Virtualization/Processes/Syscalls/clone|clone]] — Linux clone() syscall for threads
- [[CSE451/Virtualization/Memory/Concepts/Copy-on-Write|copy-on-write]] — COW optimization for fork
- [[CSE451/Virtualization/Processes/Syscalls/exec vs fork|exec vs fork]] — exec vs fork comparison
- [[CSE451/Virtualization/Processes/Syscalls/Optimizing Fork|Optimizing Fork]] — fork optimizations (COW, vfork)
- [[CSE451/Virtualization/Processes/Syscalls/vfork|vfork]] — vfork() syscall

**Threads**
- [[CSE451/Concurrency/Threads/Threads Overview|Threads Overview]] — overview of threading
- [[CSE451/Concurrency/Threads/Achieving Multithreading|Achieving Multithreading]] — how multithreading is implemented
- [[CSE451/Concurrency/Threads/Address Space with Threads|Address Space with Threads]] — shared address space in threads
- [[CSE451/Concurrency/Threads/Blocking IO Problem|Blocking IO Problem]] — threads solving blocking IO
- [[CSE451/Concurrency/Threads/Threads Overview#Concurrency vs. Parallelism|concurrency]] — concurrency definition and implications
- [[CSE451/Concurrency/Problems/Deadlocks|Deadlocks]] — circular wait causing system halt
- [[CSE451/Concurrency/Threads/Key Idea|Key Idea]] — core thread concept
- [[CSE451/Concurrency/Threads/Threads Overview#Concurrency vs. Parallelism|parallelism]] — true parallel execution
- [[CSE451/Concurrency/Problems/Starvation|Starvation]] — indefinite postponement of a thread
- [[CSE451/Concurrency/Threads/Thread Levels|Thread Levels]] — user vs kernel thread levels
- [[CSE451/Concurrency/Threads/Thread|Thread]] — thread definition
- [[CSE451/Concurrency/Threads/Threads and Processes|Threads and Processes]] — relationship between threads and processes

**Scheduling**
- [[CSE451/Virtualization/Processes/Scheduling|Scheduling]] — CPU scheduling overview

### Memory

**Address Translation**
- [[CSE451/Virtualization/Memory/Address Translation/Address Translation|Address Translation]] — virtual to physical address translation
- [[CSE451/Virtualization/Memory/Address Translation/Memory Management Unit|Memory Management Unit]] — hardware that performs address translation
- [[CSE451/Virtualization/Memory/Address Translation/MMU/MMU Address Translation|MMU Address Translation]] — MMU translation details
- [[CSE451/Virtualization/Memory/Address Translation/MMU/MMU Cache Control|MMU Cache Control]] — MMU role in cache management
- [[CSE451/Virtualization/Memory/Address Translation/MMU/MMU Memory Protection|MMU Memory Protection]] — MMU protection enforcement
- [[CSE451/Virtualization/Memory/Address Translation/MMU/MMU TLB and Page Tables|MMU TLB and Page Tables]] — MMU TLB and page table interaction
- [[CSE451/Virtualization/Memory/Address Translation/MMU/Why MMU is Important|Why MMU is Important]] — rationale for MMU
- [[CSE451/Virtualization/Memory/Address Translation/Page Table|Page Table]] — page table overview (OS section)
- [[CSE451/Virtualization/Memory/Address Translation/Page Table/Page Table Entry Anatomy|Page Table Entry Anatomy]] — fields inside a page table entry
- [[CSE451/Virtualization/Memory/Address Translation/Page Table/Page Table Purpose|Page Table Purpose]] — why page tables exist
- [[CSE451/Virtualization/Memory/Address Translation/Page Table/Page Table Storage|Page Table Storage]] — where page tables are stored
- [[CSE451/Virtualization/Memory/Address Translation/Page Table/Page Table Structure Diagram|Page Table Structure Diagram]] — visual of page table structure
- [[CSE451/Virtualization/Memory/Address Translation/Page Table/Page Table Translation Steps|Page Table Translation Steps]] — step-by-step translation walkthrough
- [[CSE451/Virtualization/Memory/Address Translation/Page Table/Per-Process Page Tables|Per-Process Page Tables]] — each process has its own page table
- [[CSE451/Virtualization/Memory/Address Translation/Page Table/Virtual Address Parts|Virtual Address Parts]] — parts of a virtual address
- [[CSE451/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]] — translation lookaside buffer overview

**Concepts**
- [[CSE451/Virtualization/Memory/Memory management|Memory management]] — OS memory management overview
- [[CSE451/Virtualization/Memory/Concepts/Accounting Information|Accounting Information]] — OS memory accounting
- [[CSE451/Virtualization/Memory/Concepts/Address Space Contents|Address Space Contents]] — what lives in an address space
- [[CSE451/Virtualization/Memory/Concepts/Embedded Systems|Embedded Systems]] — memory management in embedded systems
- [[CSE451/Virtualization/Memory/Concepts/Memory Management Information|Memory Management Information]] — OS memory management metadata
- [[CSE451/Virtualization/Memory/Concepts/Multiprogramming|Multiprogramming]] — running multiple programs concurrently
- [[CSE451/Virtualization/Memory/Concepts/OS Memory Responsibilities|OS Memory Responsibilities]] — what the OS manages in memory
- [[CSE451/Virtualization/Memory/Concepts/Page Coloring|Page Coloring]] — cache-aware page allocation
- [[CSE451/Virtualization/Memory/Concepts/Primary Memory|Primary Memory]] — RAM and primary storage
- [[CSE451/Virtualization/Memory/Concepts/Buddy Allocator|Buddy Allocator]] — binary tree-based page allocator
- [[CSE451/Virtualization/Memory/Concepts/Slab Allocation|Slab Allocation]] — kernel object caching allocator
- [[CSE451/Virtualization/Memory/Concepts/TLABs|TLABs]] — thread-local allocation buffers
- [[CSE451/Virtualization/Memory/Concepts/Swapping|Swapping]] — swapping processes to disk
- [[CSE451/Virtualization/Memory/Concepts/Virtual Addresses|Virtual Addresses]] — virtual address space concept
- [[CSE451/Virtualization/Memory/Concepts/Virtual and Physical Caches|Virtual and Physical Caches]] — caching with virtual vs physical addresses

**Memory Models**
- [[CSE451/Virtualization/Memory/Memory Models/Fixed Partitions|Fixed Partitions]] — dividing memory into fixed regions
- [[CSE451/Virtualization/Memory/Memory Models/Page Table Entries|Page Table Entries]] — PTE structure and flags
- [[CSE451/Virtualization/Memory/Memory Models/Paging|Paging]] — paging memory model
- [[CSE451/Virtualization/Memory/Memory Models/Segment and Paging|Segment and Paging]] — combining segmentation and paging
- [[CSE451/Virtualization/Memory/Memory Models/Segmentation|Segmentation]] — segment-based memory model
- [[CSE451/Virtualization/Memory/Memory Models/Variable Partitions|Variable Partitions]] — variable-size memory partitions

**Virtual Memory**
- [[CSE451/Virtualization/Memory/Paged Virtual Memory|Paged Virtual Memory]] — virtual memory via paging
- [[CSE451/Virtualization/Memory/Page Fault|Page Fault]] — page fault event
- [[CSE451/Virtualization/Memory/Page Replacement/Page replacement|Page replacement]] — page replacement overview
- [[CSE451/Virtualization/Memory/Demanding Page|Demanding Page]] — demand paging mechanism
- [[CSE451/Virtualization/Memory/How do we load a program|How do we load a program]] — program loading into virtual memory
- [[CSE451/Virtualization/Memory/How does the OS handle page faults|How does the OS handle page faults]] — OS page fault handler
- [[CSE451/Virtualization/Memory/Page Replacement/Belady's Algorithm|Belady's Algorithm]] — optimal page replacement algorithm
- [[CSE451/Virtualization/Memory/Page Replacement/Belady's Anomaly|Belady's Anomaly]] — more frames → more faults with FIFO
- [[CSE451/Virtualization/Memory/Page Replacement/Evicting the best page|Evicting the best page]] — choosing which page to evict
- [[CSE451/Virtualization/Memory/Page Replacement/LRU Clock|LRU Clock]] — clock algorithm approximating LRU
- [[CSE451/Virtualization/Memory/Page Replacement/LRU|LRU]] — least recently used page replacement
- [[CSE451/Virtualization/Memory/Page Replacement/Page FIFO|Page FIFO]] — FIFO page replacement algorithm
- [[CSE451/Virtualization/Memory/Thrashing|Thrashing]] — excessive paging degrading performance
- [[CSE451/Virtualization/Memory/Virtual Memory|Virtual Memory]] — virtual memory overview (CSE451)
- [[CSE451/Memory/Virtual Memory|Virtual Memory Deep Dive]] — Multi-level page tables, TLB shootdown, ASID, and Page Faults
- [[CSE451/Memory/Allocation|Memory Allocation]] — Slab allocator, sbrk/mmap, and Linux memory metrics
- [[CSE451/Virtualization/Memory/Working set of program behavior|Working set of program behavior]] — working set model

### Storage
- [[CSE451/Persistence/Storage/Persistent Storage|Persistent Storage]] — persistent storage overview
- [[CSE451/Persistence/Storage and FS|Storage and File Systems]] — SSD/HDD mechanics, Inodes, VFS, and Journaling
- [[CSE451/Persistence/Storage/Secondary Storage/Secondary Storage|Secondary Storage]] — secondary storage overview
- [[CSE451/Persistence/Storage/Secondary Storage/HDD|HDD]] — hard disk drive specifics
- [[CSE451/Persistence/Storage/Secondary Storage/SSD|SSD]] — solid-state drive specifics
- [[CSE451/Persistence/Storage/Organization of the IO Function|Organization of the IO Function]] — how IO is organized in OS
- [[CSE451/Persistence/Storage/IO System Hardware Environment|IO System Hardware Environment]] — hardware environment for IO
- [[CSE451/Persistence/Storage/File System/File Systems|File Systems]] — file system overview
- [[CSE451/Persistence/Storage/File System/Components/File|File]] — file abstraction in OS
- [[CSE451/Persistence/Storage/File System/Components/Directory|Directory]] — directory structure in file systems
- [[CSE451/Persistence/Storage/Defragmentation and TRIM operations|Defragmentation and TRIM operations]] — disk defrag and SSD TRIM
- [[CSE451/Persistence/Storage/File System/Components/File System Operations|File System Operations]] — common file system operations
- [[CSE451/Persistence/Storage/Flash Storage|Flash Storage]] — flash/SSD storage
- [[CSE451/Persistence/Storage/Magnetic Disks|Magnetic Disks]] — HDD mechanics and organization
- [[CSE451/Persistence/Storage/Secondary Storage/Disk Drives|Disk Drives]] — disk drive internals

### OS architecture
- [[CSE451/Virtualization/Architecture/Major OS Components|Major OS Components]] — kernel, shell, services overview
- [[CSE451/Virtualization/Architecture/OS Structure|OS Structure]] — OS architectural structure
- [[CSE451/Kernel/Kernel Internals|Kernel Internals and Performance]] — Interrupts, perf, eBPF, and architectures
- [[CSE451/Virtualization/Architecture/Microkernels|Microkernels]] — microkernel vs monolithic design
- [[CSE451/Virtualization/Architecture/Hardware Abstraction Layer|Hardware Abstraction Layer]] — HAL abstracting hardware details
- [[CSE451/Virtualization/Architecture/IO|IO]] — OS IO management
- [[CSE451/Virtualization/Architecture/Protection|Protection]] — OS protection mechanisms
- [[CSE451/Virtualization/Architecture/Command Interpreter (shell)|Command Interpreter (shell)]] — shell as command interpreter

### Virtualization
- [[CSE451/Virtualization/Virtual Machine/Virtual Machine|Virtual Machine]] — virtual machine abstraction
- [[CSE451/Virtualization/Containers and Virt|Containers and Virtualization]] — VT-x, KVM, Namespaces, and cgroups

### Security
- [[CSE451/Virtualization/Memory/Meltdown|Meltdown]] — Meltdown speculative execution vulnerability
