# Database Internals: Buffer Manager

The **Buffer Manager** sits between the storage layer and the rest of the DBMS. It is responsible for bringing pages from disk into memory and caching them in the **buffer pool** to minimize expensive disk I/O.

## Buffer Pool Structure

![[Buffer Manager.png]]

The buffer pool is a large array in memory divided into fixed-size **frames** (slots). Each frame can hold exactly one page of data.

- **Frame Metadata**: The DBMS maintains an internal table to track the state of each frame.
- **Pin Count**: Each frame has a pin count that is incremented when an operator is using the page and decremented when it is done.
  - A frame with `pin_count > 0` is considered "pinned" and **cannot be evicted**.
  - High concurrency can lead to "pinning pressure," where too many pages are pinned simultaneously, exhausting the available frames.
- **Dirty Bit**: Tracks which pages have been modified in memory but not yet written back to disk.
  - A dirty frame must be **flushed** to disk (write-back) before it can be evicted and replaced by a new page.

## Eviction Policies

When the buffer pool is full and a new page needs to be loaded, the buffer manager must choose an unpinned page to evict.

- **Least Recently Used (LRU)**: Evicts the page that has not been accessed for the longest time. Requires maintaining a timestamp or queue of accesses.
- **Clock Algorithm**: An efficient approximation of LRU. It uses a "use bit" for each frame and a rotating clock hand. If the hand hits a frame with `use_bit=1`, it sets it to 0 and moves on. If it hits `use_bit=0`, that frame is evicted.
- **LRU-K Replacement**: Standard LRU suffers from **Sequential Flooding** (where a single large scan evicts the entire "hot" cache). LRU-K tracks the time of the last $K$ references. A page read only once (during a scan) will have an extremely old $K$-th reference time and be evicted quickly, protecting frequently accessed "hot" data.
- **Random**: A simple policy that selects any unpinned page for eviction.

## Pushing Updates to Disk

The buffer manager decides when to flush pages to disk based on its eviction policy and the needs of the system.

- **Delayed Writes**: When an operator (e.g., `HeapFile`) modifies a tuple, it updates the in-memory page but does **not** immediately write it to disk.
- **Flush Mechanism**: Dirty pages are only flushed when:
  1. The page is selected for eviction by the replacement policy.
  2. The system performs a checkpoint (to bound recovery time).
  3. A transaction commit requires the log to be flushed (WAL protocol).
- **New Pages**: When adding a brand-new page to a file, the storage engine typically writes the page to disk and then reads it back through the buffer manager to ensure it is properly cached.

---

## Industry Standard Terms
- **Buffer Pool** $\rightarrow$ Page Cache / Buffer Cache
- **Frame** $\rightarrow$ Slot / Page Frame
- **Pinning** $\rightarrow$ Locking in memory / Fix
- **Dirty Bit** $\rightarrow$ Modified bit

## Related

- [[Database Internals/Data Storage, Indexing, and Buffer Management/Data Storage and Buffer Management|Data Storage and Buffer Management]] — hub file for storage components
- [[Database Internals/Data Storage, Indexing, and Buffer Management/Storage Engine Fundamentals|Storage Engine Fundamentals]] — overview of buffer management in context
- [[Database Internals/DBMS Architecture and Deployments/Architecture|DBMS Architecture]] — how the buffer manager fits into the full DBMS stack
- [[Buffer Management Policies|Buffer Management Policies (Steal/Force)]] — steal/force decisions and their impact on recovery
