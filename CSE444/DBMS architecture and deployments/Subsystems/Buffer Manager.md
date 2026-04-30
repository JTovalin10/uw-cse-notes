# DBMS Architecture: Buffer Manager

The **Buffer Manager** brings pages into memory and caches them in the **buffer pool**.

- The buffer pool is divided into fixed-size **frames** (slots in memory); each frame holds one page
- **Pin count**: each frame has a pin count incremented when an operator is using the page and decremented when done — a frame with `pin_count > 0` cannot be evicted
- **Eviction policies** (when all frames are unpinned and the pool is full):
  - Random page
  - **Least Recently Used (LRU)**
  - The **clock algorithm** (approximates LRU with low overhead)
- Tracks which pages are **dirty** (modified in memory but not yet written to disk)
  - Each frame has a **dirty bit**
  - A dirty frame must be **flushed** to disk before it can be evicted (write-back)

![[Screenshots/Buffer Manager.png]]

See [[CSE444/Data Storage, indexing, and buffer mgmt/StorageDetails/Buffer Manager - Eviction and Updates|Data Storage — Buffer Manager]] for details on page formats and record layouts.
