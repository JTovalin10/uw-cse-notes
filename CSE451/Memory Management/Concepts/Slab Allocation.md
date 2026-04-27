# Slab Allocation

**Slab Allocation** is a kernel-level memory management mechanism designed to eliminate internal fragmentation and reduce the overhead of allocating/deallocating small, frequently used kernel objects (e.g., `struct task_struct`, `struct file`, `struct inode`).

## The Core Problem
1. **Internal Fragmentation**: Standard page-level allocators (like the Buddy Allocator) allocate memory in large chunks (usually 4KB). If a kernel structure is only 256 bytes, using a full page is extremely wasteful.
2. **Allocation Overhead**: Frequent allocation and deallocation of specific structures require complex bookkeeping and lock acquisition on the global memory pool.

## The Slab Solution
Instead of allocating from a general pool, the kernel maintains **caches** for specific object types. Each cache is composed of one or more **slabs**.

### Slab Structure
- **Slab**: A contiguous block of physical memory (one or more pages) partitioned into fixed-size "slots" that exactly match the size of the target object.
- **States**:
    - **Full**: All slots are allocated.
    - **Empty**: All slots are free.
    - **Partial**: Some slots are allocated, some are free.

### Allocation Logic
1. When a kernel component requests an object (e.g., `kmem_cache_alloc`), the allocator first checks the **Partial** slabs for that object type.
2. If no partial slabs exist, it takes a slot from an **Empty** slab.
3. If no empty slabs exist, it allocates a new page from the Buddy Allocator and creates a new slab.

## Key Benefits
- **Zero Internal Fragmentation**: Slots are sized exactly to the object's requirements.
- **Performance (Object Reuse)**: Objects in the slab can be "pre-constructed." For example, a mutex or a pointer within a structure can be initialized once when the slab is created and reused across multiple allocation/deallocation cycles, avoiding repeated initialization costs.
- **Improved Cache Locality**: Keeping objects of the same type together in memory increases the likelihood of cache hits during traversal.

## Implementation Examples
- **Linux Kernel**: Heavily uses the slab allocator (and its variants like SLOB and SLUB).
- **Solaris**: The original implementation by Jeff Bonwick.

---
**See Also**: [[CSE451/Memory Management/Concepts/TLABs|TLABs]], [[Buddy Allocator]]
