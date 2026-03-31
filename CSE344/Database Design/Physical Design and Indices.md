# Database Design: Physical Design and Indices

Physical design concerns how relations are stored on disk and how indices are built to speed up queries. This is separate from [[Normalization|logical design]] (schema design) and is hidden from SQL queries by [[Physical Data Independence|physical data independence]].

## Key Topics

- [[Disk Storage]] — how hard disks work, how relations are laid out (row-store, column-store, heap file, sequential file), and why sequential I/O is faster than random I/O
- [[Database Indices]] — what an index is, how to create one, multi-attribute indices, B+ tree structure
- [[Clustered and Unclustered Indices]] — how on-disk ordering affects index performance for selections and range scans

## Related
- [[Physical Data Independence]] — why the physical layout is hidden from SQL queries
- [[Normalization]] — logical design before physical design
- [[External Memory Algorithms]] — query algorithms whose cost is measured in block I/Os
