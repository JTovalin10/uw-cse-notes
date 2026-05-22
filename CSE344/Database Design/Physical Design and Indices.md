# CSE344: Physical Design and Indices

**Physical Design** concerns how relations are stored on disk and how indices are built to speed up queries. This is separate from [[Normalization|Normalization]] (logical design/schema design) and is hidden from SQL queries by [[Physical Data Independence|Physical Data Independence]].

## Key Topics

- [[Disk Storage|Disk Storage]] — how hard disks work, how relations are laid out (row-store, column-store, heap file, sequential file), and why sequential I/O is faster than random I/O
- [[Database Indices|Database Indices]] — what an index is, how to create one, multi-attribute indices, B+ tree structure
- [[Clustered and Unclustered Indices|Clustered and Unclustered Indices]] — how on-disk ordering affects index performance for selections and range scans

## Related
- [[Physical Data Independence|Physical Data Independence]] — why the physical layout is hidden from SQL queries
- [[Normalization|Normalization]] — logical design before physical design
- [[External Memory Algorithms|External Memory Algorithms]] — query algorithms whose cost is measured in block I/Os
- [[CSE451/Persistence/Storage/Magnetic Disks|CSE451 Magnetic Disks]] — OS-level view of the disks these indices live on
