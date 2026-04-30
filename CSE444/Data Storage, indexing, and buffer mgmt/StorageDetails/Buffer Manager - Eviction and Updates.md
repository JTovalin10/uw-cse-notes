# Data Storage: Buffer Manager

The **buffer manager** sits between the storage layer and the rest of the DBMS. It caches disk pages in memory so operators don't read the same page from disk repeatedly.

- Brings pages in from disk and caches them in the **buffer pool**
- **Eviction policies** (which page to flush when the pool is full):
  - Random page (acceptable for simple implementations)
  - **Least-Recently Used (LRU)**
  - The **clock algorithm** (approximates LRU with lower overhead)
- Tracks which pages are **dirty** — a dirty page has in-memory modifications not yet written back to disk
  - Each frame has a **dirty bit**; a dirty frame must be flushed before eviction

![[Screenshots/Buffer Manager Image.png]]

### Pushing Updates to Disk

- When inserting or deleting a tuple, `HeapFile` modifies the in-memory page but does **not** immediately write it to disk
- The buffer manager decides when to flush pages to disk (and when to read them in)
  - Cannot keep all pages in memory forever — flush only dirty pages when a frame is needed
- When adding a brand-new page to a file, `HeapFile` writes the page to disk and then reads it back through the buffer manager

> For pin counts, frame slots, and deeper buffer pool details see [[CSE444/DBMS architecture and deployments/Subsystems/Buffer Manager|DBMS Architecture — Buffer Manager]].
