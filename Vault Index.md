# Vault Index

Reference map of all files in the vault, organized by course and directory. Use this to find correct `[[link]]` targets when cross-referencing notes.

---

## CSE311 — Foundations of Computing I

### Part I - Mathematical Foundations

**Data Structures**
- [[Compound Types]] — union, tuple, and record types
- [[Data Types]] — basic types (ℕ, ℤ, ℝ, ℬ) and annotations
- [[Inductive Data Types]] — recursive type definitions
- [[List of Integers]] — recursive list definition with Nil and Cons
- [[Lists]] — list notation and cons (::) operator
- [[Rooted Binary Tree Definition]] — basis and recursive step for binary trees
- [[Rooted Binary Trees Functions]] — size and height functions on binary trees

**Functions**
- [[Abstract Function]] — formal definitions of abstract functions
- [[Composition]] — function composition operator
- [[Functions on a Set of Strings]] — length, concat, reversal, char-counting
- [[Functions on Lists]] — length and concatenation on lists
- [[Functions]] — type signatures and implementations with custom types

**Logic**
- [[Boolean Algebra]] — logic notation (¬, ∧, ∨) and algebraic identities
- [[DeMorgans Laws]] — De Morgan's laws for logic and quantifiers
- [[CSE311/Part I - Mathematical Foundations/Logic/Digital Circuits|Digital Circuits]] — logic gates (AND, OR, NOT)
- [[Logical Equivalence(s)]] — identity, domination, distributive equivalences
- [[Normal Form]] — DNF and CNF normal forms
- [[Tautologies]] — tautology, contradiction, and contingency definitions
- [[Truth Tables]] — constructing truth tables with alternation patterns

**Predicates and Quantifiers**
- [[Scope of Quantifiers]] — existential vs universal quantifier scope
- [[Translating Predicates with Quantifiers]] — English to formal predicate logic
- [[What are Quantifiers]] — universal (∀) and existential (∃) definitions
- [[What is a Predicate]] — predicate as truth-valued function

**Sets and Relations**
- [[Divides]] — divisibility definition (a | b iff b = ak)
- [[Operations on Sets]] — union, intersection, difference, symmetric difference
- [[Recursive Definition of Sets]] — basis and recursive steps for sets
- [[Relations]] — composition, transitivity, symmetry, reflexivity, antisymmetry
- [[Set of Strings]] — Kleene star notation for all strings over alphabet
- [[Sets and Logic]] — connection between sets and predicates
- [[Subset of Strings]] — languages as subsets of Σ*
- [[What is a Set]] — set definitions, equality, subsets, power sets, Cartesian product

### Part II - Formal Reasoning

**Automata and Languages**
- [[Regular Expressions]] — basis, union, concatenation, Kleene star operations
- [[Strings]] — alphabet and string definition

**Number Theory**
- [[Extended Euclid]] — extended Euclidean algorithm for modular inverses
- [[Modulo]] — congruence and modular arithmetic
- [[N-Bit Integer Representation]] — unsigned, signed, two's complement

**Proof Techniques**
- [[Formal and informal]] — formal systems vs informal descriptions
- [[Formal Proofs]] — elimination, introduction, modus ponens, direct proof
- [[Induction]] — mathematical induction with base case, hypothesis, step
- [[Proof by calculation]] — proving equations/inequalities from known facts
- [[Strong Induction]] — induction for multiple base cases in recursive functions
- [[Structural Induction]] — induction on recursively-defined sets

---

## CSE312 — Foundations of Computing II

### Part I - Discrete Mathematics

**Basic Probability**
- [[Bayes Rule]] — P(B|A) = P(A|B)P(B)/P(A)
- [[Chain Rule]] — joint probability multiplication chain
- [[Conditional Probability]] — probability given other events occurred
- [[Independence]] — P(A∧B) = P(A)P(B) for independent events
- [[Law of Total Probability]] — partitioning probability space
- [[Mutual Exclusion]] — disjoint events with zero intersection
- [[Union Bound]] — P(A∪B) ≤ P(A) + P(B)

**Counting and Combinatorics**
- [[Binomial Theorem]] — expanding (a+b)^n with coefficients
- [[Complementary Counting]] — counting via complement
- [[Factorial]] — n! definition and applications
- [[Number of Subsets Formula]] — power set size is 2^n
- [[Overcounting]] — recognizing and correcting double-counted items
- [[Permutation]] — ordered arrangements (n choose k)
- [[Pigeonhole principle]] — n items in m<n containers → some container has 2+
- [[Possibilities with Restrictions]] — counting constrained outcomes
- [[Principle of Inclusion-Exclusion]] — |A∪B| = |A| + |B| - |A∩B| extended
- [[Product Rule]] — multiply choices across independent decisions
- [[Sequences]] — ordered collections of elements
- [[Size of Cartesian Product]] — |A × B| = |A| × |B|
- [[Size of Power Set]] — |P(S)| = 2^|S|
- [[Stars and bars]] — distributing identical items into distinct bins
- [[Sum Rule]] — add choices across mutually exclusive decisions
- [[Symmetry of Combination]] — C(n,k) = C(n,n-k)

### Part II - Random Variables and Distributions

**Distributions**
- [[Distribution]] — probability distribution of a random variable
- [[Normal Random Variable]] — Gaussian/normal distribution properties

**Random Variables**
- [[Continuous Random Variable]] — RV on uncountable domain with PDF
- [[Cumulative Distribution Function]] — F(x) = P(X ≤ x)
- [[Discrete Random Variables]] — RV on countable domain with PMF
- [[Probability Mass Function]] — P(X=k) for discrete random variables
- [[Random Variables]] — function mapping outcomes to numerical values
- [[Range]] — set of possible values for a random variable
- [[Support]] — set of values with non-zero probability

### Part III - Statistical Analysis

**Expectation and Variance**
- [[Conditional Expectation]] — E[X|Y] expected value given condition
- [[Covariance]] — Cov(X,Y) = E[XY] - E[X]E[Y]
- [[Expectation]] — E[X] average value of random variable
- [[Joint Expectation]] — E[XY] expected value of product
- [[Law of Total Expectation]] — E[X] = Σ E[X|Y=y]P(Y=y)
- [[Linearity of Expectation]] — E[aX+bY] = aE[X] + bE[Y]
- [[Standard Deviation]] — sqrt(Variance)
- [[Variance]] — Var(X) = E[X^2] - (E[X])^2

**Inequalities and Bounds**
- [[Chebyshev's Inequality]] — P(|X - μ| ≥ kσ) ≤ 1/k²
- [[Chernoff Bound (Multiplicative)]] — exponential bound on tail probability
- [[Hoeffding's Inequality]] — bounds deviation of sample mean from true mean
- [[Markov Inequality]] — P(X ≥ a) ≤ E[X]/a for non-negative X

**Statistical Inference**
- [[Argmax]] — selecting argument that maximizes value
- [[Central Limit Theorem]] — sum of many independent RVs approaches normal
- [[Confidence Intervals]] — range of values likely containing true parameter
- [[Maximum Likelihood Estimation]] — finding parameter values maximizing likelihood

---

## CSE331 — Software Design and Implementation

### Part I - Software Specifications

**Definitions**
- [[@effects]] — JavaDoc annotation describing method side effects
- [[@modifies]] — JavaDoc annotation listing modified mutable arguments
- [[Exclusive and Exhaustive]] — non-overlapping cases covering all possibilities
- [[Facts]] — immutable values and objects in specifications
- [[Restricting Domain]] — limiting input domain in specifications
- [[Side Conditions]] — conditions on inputs beyond @requires

**Software Specifications**
- [[Floyd Logic]] — formal reasoning about program state and correctness
- [[Hoare Triples]] — {Precondition} Statement {Postcondition} notation
- [[Kinds of Specifications]] — different specification approaches
- [[Postcondition]] — expected program state after statement execution
- [[Pre and post conditions]] — contracts defining method behavior
- [[Propositions]] — logical statements that can be true or false
- [[Stronger Assertions]] — more restrictive preconditions or postconditions
- [[Writing methods specs in java]] — writing specs in Java

### Part II - Software Engineering

**Java Programming**
- [[Conditionals]] — if-else control flow in Java
- [[Generic Methods]] — type-parameterized method definitions
- [[Generics]] — generic types with type parameters for code reuse
- [[Loops]] — while and for loop control structures
- [[Pattern Matching]] — switch with pattern matching for instanceof
- [[SubTypes]] — type relationships and substitutability
- [[Type Erasure and Arrays]] — generic type information loss and array complications
- [[Visualizing array Algorithms]] — tracing array algorithm execution
- [[Wildcards]] — wildcard type parameters in Java generics

**Software Engineering**
- [[Abstract Data Type]] — mathematical type specification independent of implementation
- [[Debugging]] — techniques for finding and fixing bugs
- [[Documenting an ADT Implementation]] — writing clear ADT documentation
- [[Local Variable Mutation]] — mutating local variables vs fields
- [[Mutation]] — modifying state through reassignment or method calls
- [[Mutations in ADT]] — ADT operations that modify internal state
- [[Mutations of Arguments]] — methods that modify their parameter objects
- [[Representation Invariants]] — properties that must always hold on object fields
- [[Software Implementation]] — translating specifications to code
- [[Testing]] — verifying software correctness through tests
- [[The need to software design]] — why design matters for maintainability
- [[Types of operations]] — creator, mutator, observer, producer on ADTs
- [[Types of tests]] — unit, integration, stress testing

---

## CSE332 — Data Structures and Parallelism

- [[CSE332/ADT and Design/Abstract Data Type (ADT)|Abstract Data Type (ADT)]] — mathematical specification of data structure behavior
- [[asymptotic analysis]] — growth rate analysis of algorithm efficiency
- [[Big Oh formal definition]] — formal O(g(n)) definition with c and n₀

---

## CSE333 — Systems Programming

### Build Systems
- [[make file dependency diagrams]] — Makefile dependency visualization
- [[Make Files (c)]] — Makefile syntax for C projects
- [[Makefiles (c++)]] — Makefile syntax for C++ projects

### C Preprocessor
- [[C Preprocessor]] — preprocessor directives and macros
- [[Client Headers]] — header files for client consumption

### C++ OOP
- [[C++ Casting]] — type casting in C++
- [[C++ Inheritance I]] — basic inheritance concepts and syntax
- [[C++ Inheritance II]] — advanced inheritance patterns
- [[Copy Constructor (C++)]] — deep copying objects in C++
- [[Dynamic Dispatch]] — virtual function runtime resolution
- [[override]] — virtual function override syntax
- [[Pure Virtual Specifier]] — abstract methods in C++
- [[Static Dispatch]] — compile-time method resolution
- [[Upcasting]] — casting a derived type to a base type
- [[Virtual Indentifier]] — virtual function identifiers
- [[Virtual table]] — vtable mechanism for dynamic dispatch

### Data Structures
- [[CSE333/Data Structures/LinkedList|LinkedList]] — linked list data structure implementation
- [[CSE333/Data Structures/Struct|Struct]] — struct definition and usage in C/C++
- [[CSE333/Data Structures/Vector|Vector]] — dynamic array (std::vector) in C++

### Definitions
- [[Creating a new process]] — process creation mechanisms

### File IO and POSIX
- [[POSIX Close]] — closing file descriptors
- [[POSIX Create]] — POSIX file creation
- [[POSIX Mode]] — file permission bits in POSIX
- [[POSIX Open]] — opening files in POSIX
- [[POSIX perror]] — printing system error messages
- [[POSIX read]] — reading from file descriptors
- [[POSIX write]] — writing to file descriptors

### Memory Management
- [[Data Type Bytes]] — byte sizes of different C types
- [[Dereference a pointer]] — accessing pointed-to values
- [[Double Free (Delete)]] — security issue of freeing memory twice
- [[Free]] — C-style memory deallocation
- [[CSE333/Memory Management/heap|heap]] — dynamic memory allocation region
- [[malloc]] — C-style dynamic memory allocation
- [[Mallocing Structs]] — allocating struct instances dynamically
- [[CSE333/Memory Management/Pointers|Pointers]] — pointer definition and dereferencing
- [[CSE333/Memory Management/stack|stack]] — stack memory region

### Networking
- [[Client-Side Networking]] — networking from client perspective
- [[create socket]] — creating network sockets
- [[Datagram socket]] — UDP-like connectionless sockets
- [[Finding IP Address]] — DNS lookup and IP resolution
- [[HTTP (CSE 333)]] — HTTP protocol basics
- [[Network Application Layer]] — application layer networking concepts
- [[Network Layer (IP)]] — IP protocol and routing layer
- [[Network Transport Layer]] — TCP/UDP transport layer
- [[Networking Data Link Layer]] — Ethernet and link layer
- [[Networking Physical Layer]] — physical transmission medium
- [[Protocols]] — network protocol definitions
- [[Resolving DNS Names]] — DNS name resolution process
- [[Server-Side Programming]] — networking from server perspective
- [[Socket API Client TCP Connection]] — TCP connection from client
- [[Socket]] — network endpoint abstraction
- [[Steam sockets]] — stream-based TCP socket connections

### Smart Pointers
- [[Delete]] — manual memory deallocation in C++
- [[move]] — move semantics and rvalue references
- [[new]] — C++ dynamic memory allocation operator
- [[Shared Pointer]] — reference-counted shared ownership pointer
- [[Smart Pointer]] — automatic memory management pointers
- [[Unique Pointer]] — exclusive ownership smart pointer
- [[weak pointer]] — non-owning smart pointer reference

---

## CSE344 — Introduction to Data Management

### Database Design
- [[BCNF Decomposition]] — Boyce-Codd Normal Form normalization algorithm
- [[Closures and Keys]] — functional dependency closure and candidate keys
- [[Clustered and Unclustered Indices]] — primary and secondary index types
- [[Data Anomalies]] — insertion, update, deletion anomalies
- [[Database Applications]] — real-world database usage patterns
- [[Database Indices]] — indexing structures for query optimization
- [[Disk Storage]] — physical disk storage mechanisms
- [[Entities, Relationships, and ER Diagrams]] — entity-relationship modeling
- [[Functional Dependencies (FDs)]] — attribute dependency relationships
- [[Integrity Constraints]] — rules enforcing data validity
- [[Multi-tier Architecture]] — typical 3-tier database architecture
- [[Normalization]] — database normalization forms (1NF–BCNF)
- [[Password Handling]] — secure password storage in databases
- [[Physical Design and Indices]] — choosing indices and storage structures

### Query Execution
- [[Cardinality Estimation]] — query optimizer estimating result set size
- [[External Memory Algorithms]] — algorithms optimized for disk access
- [[Main Memory Join Algorithms]] — in-memory join algorithms
- [[Parallel Join Algorithms]] — distributed join execution
- [[Parallel Query Execution]] — distributed query processing
- [[Physical Algorithms and Pipelining]] — query execution plan details
- [[Pipelined Execution]] — pipeline-based query execution
- [[RA Operators]] — relational algebra operations
- [[RA Tree Transformations]] — query tree optimization
- [[Relational Algebra]] — formal query language with set operations
- [[SQL to RA Translation]] — translating SQL to relational algebra

### SQL
- [[Aggregates]] — SQL GROUP BY and aggregate functions
- [[Basics]] — SQL fundamentals
- [[Create Table]] — SQL CREATE TABLE syntax
- [[Decorrelation and Unnesting]] — query optimization subquery techniques
- [[Dynamic Pivots]] — dynamically unpivoting/pivoting tables
- [[Joins]] — SQL join operations and types
- [[NULL]] — NULL value handling in SQL
- [[ORDER BY and DISTINCT]] — SQL result ordering and deduplication
- [[Outer Joins]] — left, right, full outer joins
- [[Physical Data Independence]] — separating logical from physical schema
- [[Self Joins]] — joining a table to itself
- [[Set Operations]] — UNION, INTERSECT, EXCEPT in SQL
- [[Sparse Matrix Algebra]] — sparse matrix operations in SQL
- [[Sub-Queries]] — nested SELECT statements
- [[Table Division]] — relational division operation
- [[Witnessing Problem]] — existential witness queries in SQL

### Transactions
- [[ACID Properties]] — atomicity, consistency, isolation, durability
- [[Atomic and isolated Transactions in SQL]] — ACID in SQL transactions
- [[Atomic Transactions in SQL]] — all-or-nothing transaction execution
- [[Interleaving and Concurrency Control]] — handling concurrent transactions
- [[Isolation Levels]] — serializable, repeatable read, read committed, etc.
- [[Isolation Transactions in SQL]] — isolation guarantees in SQL
- [[Other Lock Modes and Lock Granularity]] — locking strategies beyond basic locks
- [[Phantom Reads]] — phantom read anomaly in transactions
- [[Precedence Graphs]] — serialization graphs for transaction ordering
- [[Schedules and Serial Schedules]] — transaction schedule theory

---

## CSE351 — The Hardware/Software Interface

### Cache
- [[Direct Associate Cache]] — direct-mapped cache structure
- [[fully associative cache]] — cache with full flexibility in placement
- [[N-Way associative cache]] — N-way set associative cache
- [[Spatial Locality]] — accessing nearby memory addresses
- [[Temporal locality]] — reusing recently accessed data

### Data Structures
- [[CSE351/Data Structures/Arrays|Arrays]] — array storage and indexing in memory
- [[Struct Alignment]] — struct field padding for alignment
- [[CSE351/Data Structures/Structs|Structs]] — struct layout in memory

### Memory Fundamentals
- [[Endianness]] — big-endian vs little-endian byte ordering
- [[Pointer Arithmetic]] — address calculation with pointers
- [[CSE351/Memory Fundamentals/Pointers|Pointers]] — pointer definition and dereferencing
- [[Words and Memory]] — word size and memory addressing

### Memory Management
- [[CSE351/Memory Management/Memory Allocation]] — malloc/free dynamic allocation
- [[Page Faults]] — accessing unmapped virtual memory
- [[Page Tables]] — virtual-to-physical address translation tables
- [[Paging]] — virtual memory paging mechanism
- [[Translation Lookaside Buffer (TLB 351)]] — TLB structure and operation
- [[Virtual Memory]] — virtual memory abstraction

### Number Representation
- [[Binary and Hexadecimal]] — number base conversion
- [[Bit Shifting]] — logical and arithmetic bit shifts
- [[Bitwise Operations]] — AND, OR, XOR, NOT bit operations
- [[Overflow]] — arithmetic overflow detection
- [[Two's Complement]] — signed integer representation
- [[Unsigned Integers]] — unsigned integer representation

### Procedures and Stack
- [[CALL Process]] — x86 CALL instruction mechanism
- [[Calling Conventions]] — System V AMD64 ABI (args, returns)
- [[CSE351/Procedures and Stack/Memory Layout|Memory Layout]] — stack, heap, data, code segment arrangement
- [[Program Counter]] — instruction pointer register (%rip)
- [[Recursion]] — recursive function implementation in assembly
- [[Register Saving Conventions]] — caller-saved vs callee-saved registers
- [[Stack Frames]] — activation record structure
- [[Stack Pointer]] — stack pointer register (%rsp)

### Security
- [[Buffer Overflow]] — buffer overrun security vulnerability

### System Programming
- [[Context Switching]] — process context save/restore
- [[Exceptions]] — CPU exceptions and handlers
- [[Fork-Exec Model]] — process creation with fork and exec
- [[Process Termination]] — exit codes and process cleanup
- [[CSE351/System Programming/Processes|Processes]] — process abstraction
- [[System Calls]] — kernel service requests

### x86-64 Assembly
- [[Condition Codes]] — CPU flags (Zero, Sign, Overflow, Carry)
- [[CSE351/x86-64 Assembly/Conditionals|Conditionals]] — if-else assembly patterns
- [[Extension Instructions]] — sign/zero extension instructions
- [[Jump Instructions]] — conditional and unconditional jumps
- [[Labels]] — assembly labels for jumps and addressing
- [[CSE351/x86-64 Assembly/Loops|Loops]] — loop implementation in assembly
- [[Switch Statements]] — switch statement assembly (jump tables)
- [[x86-64 Instruction Format]] — assembly instruction format
- [[x86-64 Memory Operands]] — memory addressing modes
- [[x86-64 Operand Types]] — register, immediate, memory operand types
- [[x86-64 Registers]] — 16 general-purpose registers and conventions

---

## CSE444 — Advanced Database Systems

### Content
- [[CSE444/DBMS architecture and deployments/Architecture|Architecture]] — DBMS architecture overview
- [[Data Storage and Buffer Management]] — physical data storage and buffer management
- [[CSE444/Review of relational model/Relational Model|Relational Model]] — relational database model (CSE444 version)

### Index
- [[CSE444/Index|CSE444 Index]] — master navigation hub

### Incomplete (no notes yet)
- NoSQL and NewSQL/
- Parallel Query Processing/
- Query Evalutation/
- Query Optimization/
- Replication and distribution/
- Transactions/

---

## CSE451 — Operating Systems

### Intro
- [[Mechanism]] — mechanism vs policy in OS design
- [[Operating System Roles]] — what an OS does
- [[Operating System]] — OS definition and purpose
- [[Policy]] — policy in OS design
- [[Simple Memory Protection]] — basic memory protection mechanisms
- [[Stack Segment]] — stack segment in process memory

### Kernel Abstraction

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

**x86**
- [[Code Segment]] — x86 code segment register
- [[Global Descriptor Table]] — x86 GDT for memory segmentation
- [[Kernel Stack]] — kernel-mode stack
- [[Local Descriptor Table]] — x86 LDT

### Memory Management

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
- [[Translation Lookaside Buffer (TLB) Context Switch Problem]] — TLB invalidation on context switch
- [[Translation Lookaside Buffer (TLB) Context Switches]] — TLB behavior across context switches
- [[Translation Lookaside Buffer (TLB) Effectiveness]] — TLB hit rate and efficiency
- [[Translation Lookaside Buffer (TLB) Entry Contents]] — what a TLB entry stores
- [[Translation Lookaside Buffer (TLB) Entry Layout]] — TLB entry field layout
- [[Translation Lookaside Buffer (TLB) Exploits Locality]] — TLB exploiting spatial/temporal locality
- [[Translation Lookaside Buffer (TLB) How It Works]] — TLB lookup process
- [[Translation Lookaside Buffer (TLB) In Hardware]] — hardware TLB implementation
- [[Translation Lookaside Buffer (TLB) Lookup Process]] — step-by-step TLB lookup
- [[Translation Lookaside Buffer (TLB) Managing]] — OS managing TLB entries
- [[Translation Lookaside Buffer (TLB) Miss Handling]] — what happens on a TLB miss
- [[Translation Lookaside Buffer (TLB) Miss Management]] — software vs hardware miss handling
- [[Translation Lookaside Buffer (TLB) Replacement Policies]] — evicting TLB entries
- [[Translation Lookaside Buffer (TLB) Structure]] — TLB hardware structure
- [[Translation Lookaside Buffer (TLB) What This Enhanced]] — what TLB improved over plain page tables
- [[Translation Lookaside Buffer (TLB) Why It Matters]] — TLB performance impact
- [[Translation Lookaside Buffer (TLB)]] — TLB overview (CSE451)

**Concepts**
- [[Accounting Information]] — OS memory accounting
- [[Address Space Contents]] — what lives in an address space
- [[Embedded Systems]] — memory management in embedded systems
- [[Memory Management Information]] — OS memory management metadata
- [[CSE451/Memory Management/Concepts/Memory|Memory]] — memory overview
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
- [[CSE451/Memory Management/Memory Models/Paging|Paging]] — paging memory model
- [[Segment and Paging]] — combining segmentation and paging
- [[Segmentation]] — segment-based memory model
- [[Variable Partitions]] — variable-size memory partitions

- [[Page Fault Frequency]] — working set and page fault rates
- [[Super Pages]] — huge pages for TLB efficiency
- [[Windows Kernel Heap]] — Windows-specific kernel heap
- [[Windows Paging]] — Windows-specific paging behavior

### OS Architecture
- [[Command Interpreter (shell)]] — shell as command interpreter
- [[Hardware Abstraction Layer]] — HAL abstracting hardware details
- [[IO]] — OS IO management
- [[Major OS Components]] — kernel, shell, services overview
- [[Microkernels]] — microkernel vs monolithic design
- [[OS Structure]] — OS architectural structure
- [[Protection]] — OS protection mechanisms

### Persistent Storage
- [[Defragmentation and TRIM operations]] — disk defrag and SSD TRIM
- [[Directory]] — directory structure in file systems
- [[File System Operations]] — common file system operations
- [[File]] — file abstraction in OS
- [[File Systems]] — file system overview
- [[Flash Storage]] — flash/SSD storage
- [[IO System Hardware Environment]] — hardware environment for IO
- [[Magnetic Disks]] — HDD mechanics and organization
- [[Organization of the IO Function]] — how IO is organized in OS
- [[Persistent Storage]] — persistent storage overview
- [[Disk Drives]] — disk drive internals
- [[HDD]] — hard disk drive specifics
- [[Secondary Storage]] — secondary storage overview
- [[SSD]] — solid-state drive specifics

### Processes

**CPUState**
- [[Context Switch]] — saving and restoring CPU state
- [[CPU Scheduling Information]] — data used for scheduling decisions
- [[How does the CPU interact with proc]] — CPU-process interaction
- [[CSE451/Processes/CPUState/Program Counter|Program Counter]] — instruction pointer in process context
- [[CSE451/Processes/CPUState/Registers|Registers]] — register state in a process
- [[CSE451/Processes/CPUState/Stack Pointer|Stack Pointer]] — stack pointer in process context

**Memory**
- [[swap space]] — disk space used for swapping pages

**Process**
- [[Process]] — process overview
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
- [[Process vs Program]] — difference between process and program
- [[Process vs Thread]] — process vs thread comparison
- [[Sequential Process And what is Proc]] — sequential process model

- [[Scheduling]] — CPU scheduling overview

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
- [[Languages with Monitor Support]] — languages supporting monitors
- [[Monitor Advantages]] — benefits of monitors
- [[Monitor Bounded Buffer Example]] — monitor-based producer-consumer
- [[Monitor Condition Variables]] — condition variables inside monitors
- [[Monitor Disadvantages]] — downsides of monitors
- [[Monitor Facilities]] — monitor operations (wait, signal)
- [[Monitor Key Properties]] — key monitor properties
- [[Monitor Lecture Notes]] — lecture notes on monitors
- [[Monitor Semantics Hoare vs Mesa]] — Hoare vs Mesa monitor semantics
- [[Monitor Structure]] — structural layout of a monitor
- [[Semaphores]] — semaphore synchronization primitive
- [[Classic Problems Solved with Semaphores]] — dining philosophers, etc.
- [[Semaphore Advantages]] — benefits of semaphores
- [[Semaphore Blocking Behavior]] — how semaphores block threads
- [[Semaphore Disadvantages]] — downsides of semaphores
- [[Semaphore Lecture Notes]] — lecture notes on semaphores
- [[Semaphore Mutual Exclusion Pattern]] — mutex pattern with semaphores
- [[Semaphore Operations]] — P (wait) and V (signal)
- [[Semaphore Types]] — binary and counting semaphores
- [[Spinlock]] — spin-based locking mechanism
- [[Spinlock Advantages]] — benefits of spinlocks
- [[Spinlock Disadvantages]] — downsides of spinlocks
- [[Spinlock Implementation Challenge]] — atomic instruction requirement
- [[Spinlock Implementation]] — implementing a spinlock
- [[Spinlock Use Cases]] — when to use spinlocks
- [[Code Centric Locks]] — lock organized around code
- [[Data Centric Locks]] — lock organized around data
- [[Locks]] — lock synchronization overview
- [[Atomic]] — atomic operations
- [[compare_and_swap]] — CAS atomic instruction
- [[test_and_set]] — TAS atomic instruction
- [[Mutual Exclusion]] — mutual exclusion concept
- [[Race Condition]] — concurrent access causing incorrect results
- [[Heisenbug]] — bug that disappears under observation
- [[Interleaved Schedules]] — how thread schedules interleave
- [[Temporal Relations]] — happens-before and temporal ordering
- [[Synchronization]] — synchronization overview

**Syscalls**
- [[clone]] — Linux clone() syscall for threads
- [[copy-on-write]] — COW optimization for fork
- [[exec vs fork]] — exec vs fork comparison
- [[Exec]] — exec() syscall to replace process image
- [[Fork]] — fork() syscall to create child process
- [[Optimizing Fork]] — fork optimizations (COW, vfork)
- [[vfork]] — vfork() syscall

### Threads
- [[Achieving Multithreading]] — how multithreading is implemented
- [[Address Space with Threads]] — shared address space in threads
- [[Blocking IO Problem]] — threads solving blocking IO
- [[concurrency]] — concurrency definition and implications
- [[Deadlocks]] — circular wait causing system halt
- [[Key Idea]] — core thread concept
- [[parallelism]] — true parallel execution
- [[Starvation]] — indefinite postponement of a thread
- [[The Big Picture]] — threads in the big picture
- [[Thread Levels]] — user vs kernel thread levels
- [[Kernel Threads]] — kernel-managed threads
- [[Scheduler Activations]] — hybrid user/kernel threading
- [[User Threads]] — user-space managed threads
- [[User vs Kernel Threads]] — comparison of thread implementations
- [[Thread]] — thread definition
- [[Threads and Processes]] — relationship between threads and processes
- [[Threads Overview]] — overview of threading
- [[Threads]] — threads summary
- [[Value of Process Thread Separation]] — why separate threads from processes
- [[What is a Process]] — process definition (threads section)

### Virtual Machine
- [[Virtual Machine]] — virtual machine abstraction

### Virtual Memory
- [[Demanding Page]] — demand paging mechanism
- [[How do we load a program]] — program loading into virtual memory
- [[How does the OS handle page faults]] — OS page fault handler
- [[Meltdown]] — Meltdown speculative execution vulnerability
- [[Page Fault]] — page fault event
- [[Belady's Algorithm]] — optimal page replacement algorithm
- [[Belady's Anomaly]] — more frames → more faults with FIFO
- [[Evicting the best page]] — choosing which page to evict
- [[LRU Clock]] — clock algorithm approximating LRU
- [[LRU]] — least recently used page replacement
- [[Page FIFO]] — FIFO page replacement algorithm
- [[Page replacement]] — page replacement overview
- [[Paged Virtual Memory]] — virtual memory via paging
- [[Solution to finding the needed page on disk and bringing it into the page frame]] — page-in process
- [[Thrashing]] — excessive paging degrading performance
- [[Virtual Memory]] — virtual memory overview (CSE451)
- [[Working set of program behavior]] — working set model

---

## CSE452 — Distributed Systems

### Index
- [[CSE452/Index|CSE452 Index]] — master navigation hub

### RPC/
- [[CSE452/RPC/Introduction to DS|Introduction to DS]] — what a DS is, challenges, why build one
- [[CSE452/RPC/Fault Model|Fault Model]] — types of faults: crashes, dropped/delayed/duplicate messages
- [[CSE452/RPC/Remote Procedure Call (RPC)|Remote Procedure Call (RPC)]] — request/response, sequence numbers, at-least/at-most/exactly-once
- [[CSE452/RPC/Deterministic State Machine|Deterministic State Machine]] — same commands in same order → same state on all replicas

### Primary-Backup/
- [[CSE452/Primary-Backup/Primary Backup|Primary Backup]] — primary orders, backup executes, view server, state transfer, split brain
- [[CSE452/Primary-Backup/Failover Protocol|Failover Protocol]] — detecting failure and transferring roles between nodes
- [[CSE452/Primary-Backup/Idempotence|Idempotence]] — operations safe to repeat without side effects
- [[CSE452/Primary-Backup/Why not just use TCP|Why not just use TCP]] — TCP cannot handle failure well; need application-level protocol

---

## CSE461 — Computer Networks

### Application
- [[Application Requirements]] — application-level network requirements
- [[Caching]] — caching at the application layer
- [[Content Distribution Networks (CDN)]] — CDN architecture and purpose
- [[DNS protocol]] — DNS protocol mechanics
- [[Domain Name System (DNS)]] — DNS overview
- [[Email - SMTP, IMAP, and MIME]] — email protocols
- [[HTTP - Protocol Mechanics and Evolution]] — HTTP versions and mechanics
- [[Iterative vs Recursive Queries]] — DNS query resolution styles
- [[Local Nameservers]] — local DNS resolver
- [[Multimedia - RTP, RTCP, and Playout Buffers]] — multimedia streaming protocols
- [[Network Management - SNMP and gNMI]] — network management protocols
- [[Overlay Networks - Fundamental Mechanics]] — overlay network mechanics
- [[Page Load Time (PLT)]] — web page load time optimization
- [[Parallel Connections]] — parallel TCP connections for HTTP
- [[Peer-to-Peer Networks]] — P2P architecture
- [[Persistent Connections]] — HTTP persistent connections
- [[QoS and Admission Control - DiffServ and RSVP]] — quality of service mechanisms
- [[Root Nameservers]] — DNS root nameservers
- [[Routing Overlays]] — overlay routing techniques
- [[Session Control - SIP and SDP]] — SIP and SDP protocols
- [[Web Caching]] — web proxy caching
- [[Web Proxies]] — forward and reverse web proxies
- [[Web Services - SOAP, REST, and gRPC]] — web service protocols
- [[World Wide Web - HTTP Evolution and Caching]] — HTTP evolution and caching

### Definitions (CSE461)
- [[Acknowledgment (ACK)]] — TCP acknowledgment
- [[Address Resolution Protocol (ARP)]] — MAC-to-IP resolution
- [[Advertised Window (rwnd)]] — TCP receiver window size
- [[CSE461/Definitions/Application|Application]] — application layer definition
- [[CSE461/Definitions/Applications|Applications]] — network applications
- [[Area Border Router (ABR)]] — OSPF area border router
- [[Asynchronous Transfer Mode (ATM)]] — ATM network technology
- [[Automatic Repeat Request (ARQ)]] — error recovery via retransmission
- [[Autonomous System (AS)]] — autonomous system in routing
- [[Baud Rate]] — signal transitions per second
- [[Binary Exponential Backoff (BEB)]] — exponential collision avoidance
- [[Broadband Base Unit (BBU)]] — cellular base unit
- [[Care-of Address (Mobile IP)]] — mobile IP care-of address
- [[Carrier Sense Multiple Access (CSMA)]] — listen before transmit
- [[Checksum]] — additive checksum error detection
- [[Classless Interdomain Routing (CIDR)]] — variable-length subnet masks
- [[Computer Network Names by Scale]] — LAN, WAN, MAN classifications
- [[Congestion Window (cwnd)]] — TCP congestion window
- [[Connectionless]] — connectionless network service
- [[Convergence]] — routing table convergence
- [[Cyclic Redundancy Check (CRC)]] — polynomial-based error detection
- [[Datagram]] — connectionless packet
- [[Definitions Overview]] — index of CSE461 definitions
- [[Direct Memory Access (DMA)]] — DMA data transfer
- [[Dynamic Host Configuration Protocol (DHCP)]] — automatic IP assignment
- [[Dynamic Random-Access Memory (DRAM)]] — DRAM memory type
- [[Encapsulation]] — wrapping data in protocol headers
- [[Foreign Agent (Mobile IP)]] — mobile IP foreign agent
- [[Forwarding Table]] — routing/forwarding table
- [[Forwarding]] — packet forwarding
- [[Frame]] — link layer data unit
- [[Frequency Division Multiplexing (FDM)]] — FDM channel division
- [[Frequency-Division Multiplexing]] — FDM definition
- [[Global System for Mobile Communications (GSM)]] — GSM standard
- [[Home Address (Mobile IP)]] — mobile IP home address
- [[Home Agent (Mobile IP)]] — mobile IP home agent
- [[Hop-by-Hop Flow Control]] — per-link flow control
- [[Host]] — network host definition
- [[iBGP and eBGP]] — internal and external BGP
- [[Internet Control Message Protocol (ICMP)]] — ICMP error messages
- [[Internet Protocol (IP)]] — IP protocol definition
- [[Internet Service Provider (ISP)]] — ISP definition
- [[IP Address Classes (Classful Addressing)]] — classful IP addressing
- [[Link-State Advertisement (LSA)]] — OSPF LSA
- [[Link-State Packet (LSP)]] — link-state routing packet
- [[Link]] — network link definition
- [[Local Area Network (LAN)]] — LAN definition
- [[Long-Term Evolution (LTE)]] — LTE cellular standard
- [[Loose Source Route]] — loose source routing option
- [[Maximum Transmission Unit (MTU)]] — max packet size
- [[Media Access Control (MAC)]] — MAC addressing
- [[Multiple Input Multiple Output (MIMO)]] — MIMO antenna technique
- [[Multiplexing]] — sharing a channel among multiple users
- [[Network Adaptor]] — network interface hardware
- [[Network Interface Card (NIC)]] — NIC hardware
- [[Network Operating System (NOS)]] — NOS definition
- [[Network Processor Unit (NPU)]] — network processor
- [[Next Hop Router]] — next hop in routing
- [[Open Shortest Path First (OSPF)]] — OSPF link-state protocol
- [[Optical Line Terminal (OLT)]] — PON OLT
- [[Optical Network Unit (ONU)]] — PON ONU
- [[Orthogonal Frequency-Division Multiple Access (OFDMA)]] — OFDMA wireless access
- [[OSPF Area 0 (Backbone)]] — OSPF backbone area
- [[OSPF Virtual Link]] — OSPF virtual link
- [[Passive Optical Network (PON)]] — PON fiber network
- [[Path Vector]] — BGP path vector routing
- [[Peripheral Component Interconnect Express (PCIe)]] — PCIe bus
- [[Permanent Virtual Circuit]] — permanent VC in ATM
- [[Quality of Service (QoS)]] — QoS definition
- [[Requirements]] — network requirements definition
- [[Round-Trip Time (RTT)]] — RTT measurement
- [[Router]] — routing device definition
- [[Routing Information Protocol (RIP)]] — RIP distance-vector protocol
- [[Routing]] — routing definition
- [[Signal-to-Noise Ratio (SNR)]] — SNR metric
- [[Signalling]] — network signalling
- [[Sliding Window Protocol]] — window-based flow control
- [[Software Defined Networking (SDN)]] — SDN definition
- [[CSE461/Definitions/Software|Software]] — software layer definition
- [[Source Routing]] — source-specified routing
- [[ssthresh]] — TCP slow start threshold
- [[Static Random-Access Memory (SRAM)]] — SRAM memory type
- [[Statistical Multiplexing]] — statistical sharing of bandwidth
- [[Strict Source Route]] — strict source routing option
- [[Subnet Mask]] — subnet mask definition
- [[Subnet]] — subnet definition
- [[Switch]] — network switch definition
- [[Switched Network]] — circuit/packet switched network
- [[Switched Virtual Circuit]] — SVC in ATM
- [[Synchronous Time-Division Multiplexing]] — synchronous TDM
- [[Ternary Content-Addressable Memory (TCAM)]] — TCAM for fast lookup
- [[Time Division Multiplexing (TDM)]] — TDM channel sharing
- [[Time to Live (TTL)]] — packet hop limit
- [[Transmission Control Protocol (TCP)]] — TCP definition
- [[User Datagram Protocol (UDP)]] — UDP definition
- [[User Equipment (UE)]] — mobile user device
- [[Virtual Circuit (VC)]] — virtual circuit definition
- [[Virtual Circuit Identifier (VCI)]] — VCI in ATM
- [[Virtual Local Area Network (VLAN)]] — VLAN definition
- [[Virtual Path Identifier (VPI)]] — VPI in ATM
- [[Virtual Private Network (VPN)]] — VPN definition
- [[Wide Area Network (WAN)]] — WAN definition

### Link Layer
- [[Bit Stuffing]] — escaping special bit sequences in frames
- [[Byte Count]] — frame length field framing
- [[Byte Stuffing]] — escaping special byte sequences in frames
- [[Link Layer - Access Networks (PON and Cellular)]] — PON and cellular access networks
- [[Link Layer - Error Detection and Correction]] — error detection and correction
- [[Link Layer - Framing]] — frame structure and framing methods
- [[Link Layer - Multiple Access (Wired)]] — wired multiple access protocols
- [[Link Layer - Multiple Access (Wireless)]] — wireless multiple access protocols
- [[Link Layer - Multiplexing (TDM and FDM)]] — TDM and FDM multiplexing
- [[Link Layer - Reliable Transmission]] — link-layer reliability mechanisms
- [[Link Layer - Software Defined Networking (SDN)]] — SDN at link layer
- [[Link Layer - Switching and Bridges]] — switching and bridge operation
- [[Link Layer - Virtual LANs (VLANs)]] — VLAN operation
- [[Link Layer Overview]] — link layer overview

### Network Layer
- [[Network Layer - Forwarding and Routing Mechanics]] — how forwarding and routing work
- [[Network Layer - Internetworking and IP]] — IP and internetworking
- [[Network Layer - IPv4 Addressing and Subnetting]] — IPv4 addressing
- [[Network Layer - IPv6]] — IPv6 protocol
- [[Network Layer - Mobility]] — mobile IP
- [[Network Layer - MPLS]] — MPLS label switching
- [[Network Layer - Multicast]] — multicast routing

### Physical Layer
- [[Physical Layer - Encoding and Modulation]] — signal encoding and modulation
- [[Physical Layer - Media and Links]] — physical media types
- [[Physical Layer - Performance and Latency]] — latency and throughput
- [[Physical Layer - Signals and Channel Capacity]] — Shannon capacity and signals

### Routing Layer
- [[Routing Layer - Border Gateway Protocol (BGP)]] — BGP interdomain routing
- [[Routing Layer - Delivery Models]] — unicast, multicast, anycast
- [[Routing Layer - Interdomain Concepts]] — interdomain routing concepts
- [[Routing Layer - Intradomain Routing (DV and LS)]] — distance-vector and link-state
- [[Routing Layer - Open Shortest Path First (OSPF)]] — OSPF details

### Transport
- [[Network-Side Congestion Control]] — congestion control at network
- [[Timeout Misfortune]] — TCP timeout issues
- [[Transport Layer - Advanced Transport (QUIC, SCTP, and RPC)]] — QUIC, SCTP, RPC
- [[Transport Layer - Real-Time Transport (RTP and RTCP)]] — real-time streaming
- [[Transport Layer - Resource Allocation and QoS]] — resource allocation
- [[Transport Layer - TCP Congestion Control]] — TCP congestion control algorithms
- [[Transport Layer - Transmission Control Protocol (TCP)]] — TCP in depth
- [[Transport Layer - UDP and Port Demultiplexing]] — UDP and port demuxing
- [[Weighted Fair Queuing]] — WFQ scheduling algorithm

---

## CSE484 — Computer Security

### Anonymity and Privacy
- [[Anonymity in data]] — de-identification and k-anonymity
- [[Anonymity in networks & messaging]] — Tor, VPNs, network anonymity

### Cryptography
- [[Asymmetric Cryptography + key Exchange]] — public key crypto and Diffie-Hellman
- [[Cryptography]] — cryptographic principles and algorithms
- [[Hashing + Ciphertext Integrity]] — hash functions and HMAC

### Debugging Tools
- [[How to enter GDB]] — using GDB debugger for security analysis

### Machine Learning Security
- [[Machine Learning Security]] — adversarial attacks on ML models

### Memory Exploits
- [[Buffer Overflows]] — stack buffer overflow attacks
- [[Defenses against buffer overflows]] — ASLR, stack canaries, DEP/NX
- [[Memory Layout in a Program]] — stack, heap, data, code sections
- [[CSE484/Memory Exploits/Memory Layout|Memory Layout]] — address space layout details
- [[Off-by-One Overflow]] — single-byte buffer overflows
- [[CSE484/Memory Exploits/Stack|Stack]] — stack structure and function calls
- [[Writing Stack with Format Strings]] — format string exploits

### Policy and Access Control
- [[Groups]] — user/group permission systems
- [[Targets for policy]] — what security policies protect

### Security Fundamentals
- [[Bug, Vulnerabilities, and exploits]] — relationship between bugs, vulns, exploits
- [[How Systems Fails]] — common security failure modes
- [[Other types of attacks]] — various attack categories
- [[Root Cause Analysis and Patching]] — finding root causes and patching
- [[Threat Model]] — defining threat model and adversary capabilities
- [[What is security]] — security fundamentals (CIA triad, etc.)

### Side Channel Attacks
- [[CSE484/Side Channel Attacks/Side Channel Attacks]] — timing, power, cache side channels
- [[Spectre]] — Spectre speculative execution vulnerability

### Usable Security
- [[Usable Security]] — user-centered security design

---

## Disambiguation Notes

Several file names appear in multiple courses — always use disambiguated paths when cross-linking:

| Name | Courses |
|------|---------|
| `Pointers` | CSE333, CSE351, CSE484 |
| `Memory Layout` | CSE351, CSE484, CSE451 |
| `Virtual Addresses` | CSE451 (two locations) |
| `Loops` | CSE311, CSE331, CSE351 |
| `Conditionals` | CSE331, CSE351 |
| `Abstract Data Type` | CSE331, CSE332 |
| `Relational Model` | CSE344, CSE444 |
| `Paging` | CSE451 (two locations), CSE351 |
| `Exceptions` | CSE351, CSE451 |
| `Stack Pointer` | CSE351, CSE451 |
| `Program Counter` | CSE351, CSE451 |
| `Registers` | CSE451 (two locations) |
| `System Call` | CSE451, CSE351 |
| `LinkedList` | CSE333 |
| `Processes` | CSE351, CSE451 |
| `Heap File Implementations` | CSE444 screenshots |
| `Failover Protocol` | CSE452 (two locations) |
| `Idempotence` | CSE452 (two locations) |
| `Primary Backup` | CSE452 (two locations) |
| `Deterministic State Machine` | CSE452 (two locations) |
| `Fault Model` | CSE452 (two locations) |
| `Introduction to DS` | CSE452 (two locations) |
| `Remote Procedure Call (RPC)` | CSE452 (two locations) |
