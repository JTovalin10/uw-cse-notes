## Table of Contents

1. [Virtual Memory Overview](#virtual-memory-overview)
2. [Paging System](#paging-system)
3. [Virtual Memory and the Memory Hierarchy](#virtual-memory-and-the-memory-hierarchy)
4. [Page Tables and Address Translation](#page-tables-and-address-translation)
5. [Memory Protection](#memory-protection)
6. [Address Translation Process](#address-translation-process)
7. [Translation Lookaside Buffer (TLB)](#translation-lookaside-buffer-tlb)
8. [Complete Address Translation Flow](#complete-address-translation-flow)

---

## Virtual Memory Overview

### Definition and Purpose

**Virtual memory** is the process abstraction that provides each process with the illusion of a private address space, hiding the actual amount of physical RAM from running processes.

### Key Address Spaces

#### Virtual Address Space

- **Definition**: Set of bytes each process _thinks_ it has available
- **Size**: N = 2ⁿ bytes (n-bit virtual addresses)
- **Characteristics**: Private to each process, can exceed physical memory

#### Physical Address Space

- **Definition**: Set of bytes actually available in physical memory
- **Size**: M = 2ᵐ bytes (m-bit physical addresses)
- **Characteristics**: Shared across all running processes

#### Swap Space

- **Definition**: Region of disk used to temporarily hold excess memory
- **Purpose**: Allows virtual address space to exceed physical memory
- **Access**: Much slower than physical memory

### Address Types

|Address Type|Width|Space Size|Usage|
|---|---|---|---|
|**Virtual Address**|n bits|N = 2ⁿ bytes|Program instructions (`movq (%rdi), %rax`)|
|**Physical Address**|m bits|M = 2ᵐ bytes|Actual memory hardware locations|

### The Indirection Layer

Virtual memory works through **address translation** - mapping virtual addresses (used in programs) to physical addresses (actual memory locations).

### Key Insights

- **Address width in programs**: Refers to virtual addresses (determined by machine word size)
- **Physical memory sizing**: For 8 GiB RAM = 2³³ bytes, need minimum 33 physical address bits

---

## Paging System

### Page Concept

A **page** is a fixed-width unit of data transfer between memory levels, analogous to cache blocks but much larger.

### Page Parameters

- **Page Size**: P = 2ᵖ bytes
- **Page Offset**: p bits needed to reference every byte within a page
- **Page Numbers**: Both virtual and physical memory divided into pages

### Page Number Types

#### Virtual Page Number (VPN)

- **Purpose**: Identifies pages in virtual address space
- **Range**: 0 to (N/P - 1) where N is virtual address space size

#### Physical Page Number (PPN)

- **Purpose**: Identifies pages in physical address space
- **Range**: 0 to (M/P - 1) where M is physical address space size

### Address Structure

```
Virtual Address: [VPN (n-p bits)][Page Offset (p bits)]
Physical Address: [PPN (m-p bits)][Page Offset (p bits)]
```

### Example Calculation

**System Parameters**:

- Physical memory: 4 KiB (2¹² bytes) → 12-bit physical addresses
- Virtual addresses: 14 bits → 16 KiB virtual space
- Page size: 1 KiB (2¹⁰ bytes) → 10-bit page offset

**Results**:

- Physical pages: 4 KiB / 1 KiB = 4 pages (PPNs 0-3)
- Virtual pages: 16 KiB / 1 KiB = 16 pages (VPNs 0-15)
- PPN width: 12 - 10 = 2 bits
- VPN width: 14 - 10 = 4 bits

### Address Examples

**Address 0x123 (291 decimal)**:

- Binary: `0b 00|01 0010 0011`
- Page offset: `01 0010 0011` = 291 % 1024 = 291
- PPN: `00` = 291 / 1024 = 0

**Address 0x1234 (4660 decimal)**:

- Binary: `0b 01 00|10 0011 0100`
- Page offset: `10 0011 0100` = 4660 % 1024 = 660
- VPN: `0100` = 4660 / 1024 = 4

---

## Virtual Memory and the Memory Hierarchy

### Virtual Memory's Role

Virtual memory is **not a level** in the memory hierarchy - it's an abstraction layer that manages the mapping between virtual and physical addresses.

### Process Memory Usage Reality

Most processes use only a small fraction of their available virtual address space:

- **64-bit machine**: 2⁶⁴ = 16 EiB virtual space per process
- **Typical usage**: 2-4 physical pages (Stack, Heap, Code, Data)
- **Efficiency**: Unused virtual pages never get physical memory allocated

### Physical Memory as Cache

#### Cache Analogy

Physical memory acts as a cache for:

1. **Virtual address spaces**: Holds subset of virtual pages
2. **Disk storage**: Transfers pages to/from swap space

#### Cache Characteristics

Due to extremely high disk access penalty, physical memory uses:

|Parameter|Value|Reason|
|---|---|---|
|**Page Size**|Large (4KB-4MB)|Amortize disk access cost|
|**Associativity**|Fully associative|Minimize page faults|
|**Write Policy**|Write-back + Write allocate|Reduce disk writes|
|**Replacement**|Sophisticated OS algorithms|Optimize for workload|

---

## Page Tables and Address Translation

### Page Table Structure

**Page tables** are lookup tables that perform address translation from virtual to physical addresses.

#### Page Table Entry (PTE)

Similar to cache lines, PTEs contain:

- **Data**: Physical Page Number (PPN)
- **Management bits**: Control access and state

#### Page Table Organization

- **Index**: Virtual Page Number (VPN)
- **Requirement**: One entry for every possible VPN
- **Size**: For n-bit virtual addresses with P-byte pages: 2^(n-p) entries

### Page Table Entry Fields

|Field|Purpose|Description|
|---|---|---|
|**Valid Bit**|Presence|Is this virtual page in physical memory?|
|**Dirty Bit**|Write tracking|Has page been modified? (write-back)|
|**Access Rights**|Protection|Read/Write/Execute permissions|
|**PPN**|Translation|Physical page number for address translation|

### Address Translation Process

1. **Extract VPN** from virtual address
2. **Index page table** using VPN
3. **Check valid bit** in PTE
4. **Extract PPN** if valid
5. **Combine PPN + page offset** to form physical address

### Page Table Size Example

**32-bit machine with 2 MiB pages**:

- Virtual address space: 2³² bytes
- Page size: 2²¹ bytes
- Number of virtual pages: 2³²⁻²¹ = 2¹¹ = 2,048 entries
- **Page table size**: 2,048 PTEs per process

---

## Memory Protection

### Process Isolation

Each process has its own page table, enabling:

- **Protection**: No shared PPNs between different processes
- **Sharing**: Multiple VPNs can map to same PPN when desired

### Access Rights Bits

Similar to Linux file permissions, stored in each PTE:

|Bit|Permission|Description|
|---|---|---|
|**R**|Read|Can process read data from this page?|
|**W**|Write|Can process modify data on this page?|
|**X**|Execute|Can process fetch instructions from this page?|

### Example Access Rights by Section

|Memory Section|R|W|X|Rationale|
|---|---|---|---|---|
|**Code**|1|0|1|Read and execute instructions, no modification|
|**Data**|1|1|0|Read and write variables, no execution|
|**Literals**|1|0|0|Read constants, no modification or execution|
|**Stack**|1|1|0|Read and write local variables, no execution|

### Protection Benefits

1. **Between processes**: Prevent unauthorized access to other processes' memory
2. **Within process**: Prevent misuse of different memory sections (e.g., executing data)
3. **Security**: Hardware-enforced protection against common attacks

---

## Address Translation Process

### Components

- **CPU**: Issues virtual addresses
- **MMU (Memory Management Unit)**: Performs address translation
- **PTBR (Page Table Base Register)**: Points to current process's page table

### Page Hit Scenario

**Steps**:

1. **CPU → MMU**: Sends virtual address
2. **MMU → Memory**: Looks up PTE using VPN + PTBR
3. **Memory → MMU**: Returns PTE with valid bit = 1
4. **MMU**: Translates virtual address to physical address
5. **MMU → Memory**: Requests data using physical address
6. **Memory → CPU**: Returns requested data

**Memory accesses**: 2 (PTE lookup + data fetch)

### Page Fault Scenario

**Steps**:

1. **CPU → MMU**: Sends virtual address
2. **MMU → Memory**: Looks up PTE using VPN + PTBR
3. **Memory → MMU**: Returns PTE with valid bit = 0
4. **MMU**: Triggers page fault exception
5. **OS Handler**:
    - Identifies victim page in physical memory
    - Pages out victim (if dirty) to disk
    - Pages in requested page from disk
    - Updates PTE with new PPN and valid = 1
6. **Handler**: Returns control to restart instruction
7. **Restart**: Guaranteed page hit on retry

**MMU memory accesses**: 3 (initial PTE lookup + 2 for subsequent page hit)

---

## Translation Lookaside Buffer (TLB)

### Purpose and Design

The **TLB** is a small hardware cache in the MMU that reduces memory accesses during address translation by caching page table entries.

### TLB Structure

- **Cached data**: Page table entries (PPN + management bits)
- **Index**: TLB Index (TLBI) extracted from VPN
- **Tag**: TLB Tag (TLBT) for comparison
- **Organization**: Set associative cache

### VPN Field Breakdown

```
VPN: [TLBT (TLB Tag)][TLBI (TLB Index)]
```

### TLB Entry Components

|Component|Description|Source|
|---|---|---|
|**Valid Bit**|Is this TLB entry valid?|TLB management|
|**TLB Tag**|Tag for TLB hit detection|Upper bits of VPN|
|**PTE Data**|Management bits + PPN|From page table|

### TLB Operation

#### TLB Hit

- **Process**: VPN found in TLB
- **Result**: Direct address translation without page table access
- **Performance**: Fastest path

#### TLB Miss

- **Process**: VPN not found in TLB
- **Action**: Fetch PTE from page table in memory
- **Update**: Load new PTE into TLB
- **Subsequent access**: Will be TLB hit

### TLB Size Calculation Example

**System parameters**:

- 12-bit virtual addresses (n = 12)
- 8-bit physical addresses (m = 8)
- 16-byte pages (P = 16, p = 4)
- 5 management bits per PTE
- 4-way set associative TLB with 16 entries

**Calculations**:

- VPN width: 12 - 4 = 8 bits
- PPN width: 8 - 4 = 4 bits
- TLB sets: 16/4 = 4 sets
- TLBI width: log₂(4) = 2 bits
- TLBT width: 8 - 2 = 6 bits

**TLB entry size**: 1 (valid) + 6 (tag) + 5 (management) + 4 (PPN) = **16 bits**

---

## Complete Address Translation Flow

### Two-Stage Process

Address translation involves two independent stages:

#### Stage 1: Virtual to Physical Address Translation

1. **Check TLB** with VPN
    - **TLB Hit**: Get PPN directly
    - **TLB Miss**: Access page table
        - **Page Hit**: Load PTE into TLB
        - **Page Fault**: OS loads page, updates page table and TLB

#### Stage 2: Cache Access with Physical Address

2. **Check Cache** with physical address
    - **Cache Hit**: Return data to CPU
    - **Cache Miss**: Fetch from memory, load into cache

### Performance Paths

|Path|TLB|Page Table|Cache|Total Accesses|
|---|---|---|---|---|
|**Best Case**|Hit|-|Hit|1|
|**TLB Miss**|Miss|Hit|Hit|2|
|**Cache Miss**|Hit|-|Miss|2|
|**Both Miss**|Miss|Hit|Miss|3|
|**Page Fault**|Miss|Fault|-|Many (disk I/O)|

### Address Manipulation Flow

```
Virtual Address:    [VPN][Offset]
                       ↓
TLB/Page Table:    [VPN] → [PPN]
                       ↓
Physical Address:   [PPN][Offset]
                       ↓
Cache Access:      [Tag][Index][Offset]
```

### Key Characteristics

- **Independence**: Stage 1 must complete before Stage 2 begins
- **Caching**: All memory accesses (including page table) go through cache
- **Physical caches**: Caches operate on physical addresses
- **Performance**: TLB dramatically reduces translation overhead

### Protection Checking

During translation, MMU also checks:

- **Valid bit**: Is page in physical memory?
- **Access rights**: Does operation match R/W/X permissions?
- **Protection fault**: Generated if access violates permissions

---

## Summary

### Key Concepts

1. **Virtual memory** provides process isolation and memory abstraction
2. **Paging** divides memory into fixed-size units for efficient management
3. **Page tables** map virtual pages to physical pages
4. **TLB** caches translations to improve performance
5. **Protection bits** enforce memory access policies
6. **Two-stage translation** separates address translation from cache access

### Performance Implications

- **TLB hits** eliminate page table accesses
- **Page faults** incur massive disk I/O penalties
- **Large pages** reduce TLB pressure but increase internal fragmentation
- **Spatial locality** benefits from page-based organization

### Design Trade-offs

- **Page size**: Larger pages reduce overhead but increase fragmentation
- **TLB size**: More entries reduce misses but increase cost and access time
- **Associativity**: Higher associativity reduces conflicts but increases complexity
- **Protection granularity**: Page-level protection balances security and performance