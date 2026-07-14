# CSE451: Flash Storage (SSD)

**Solid State Drives (SSDs)** use semiconductor memory (typically NAND flash) to store data persistently. Unlike [[Magnetic Disks|HDDs]], they have no moving parts, which fundamentally changes their performance profile and failure modes.

## Characteristics

- **No mechanical delay**: Seek time and rotational latency — the two dominant costs for [[Magnetic Disks|HDDs]] — are effectively zero, since there is no physical arm to move and no platter to rotate into position.
- **High random I/O performance**: Much faster than HDDs for random accesses, since random access on an SSD costs roughly the same as sequential access (no seek penalty), whereas random access on an HDD requires a fresh, expensive seek for nearly every access.
- **Limited write endurance**: Flash cells wear out after a certain number of program/erase (P/E) cycles, since each erase cycle physically stresses the oxide layer that traps charge in the cell, eventually causing it to fail to hold a charge reliably.

## Mechanics: Blocks and Pages

- **Pages**: The smallest unit of reading and writing (typically 4KB-16KB).
- **Blocks**: A collection of pages (typically 128 or 256 pages).
- **Erase-before-write**: A page can only be written if it is clean (erased). To overwrite data that has already been written, an entire **block** — not just the individual page — must be erased first, because flash memory's electrical write mechanism can only push a cell's charge in one direction (e.g., from 1 to 0); returning it to the other state requires a coarser-grained erase operation that resets an entire block at once.

## Performance Optimization

Because of the erase-before-write constraint above, SSDs rely on several optimizations layered on top of the raw hardware:

- **Flash Translation Layer (FTL)**: Hardware/firmware that maps logical addresses (as seen by the OS) to physical flash locations, handles wear leveling, and manages garbage collection. The FTL is what lets the OS keep treating the SSD like an ordinary block device, even though the physical mapping of logical block to physical cell location is constantly shifting underneath it.
- **Wear Leveling**: Ensuring that all flash blocks wear out at approximately the same rate, by spreading writes across the whole device rather than repeatedly erasing the same physical blocks — this maximizes the drive's overall usable lifetime instead of letting a "hot" region fail first.
- **Garbage Collection**: Reclaiming blocks by moving any still-valid pages to new locations and then erasing the old block, freeing it up to accept new writes. This is necessary because a block cannot be partially erased — even if only one page in it is stale, the whole block must be cleared, so any live data in it has to be relocated first.
- **[[Defragmentation and TRIM operations|TRIM]]**: An OS command that tells the SSD which blocks are no longer in use by the file system, allowing the SSD to garbage collect them early rather than waiting until it runs out of clean blocks and is forced to do so under write pressure.

## Caution

**Never defragment an SSD.** It does not improve performance (since there is no seek time to eliminate) and only wears out the flash cells by performing unnecessary writes, consuming program/erase cycles for no performance benefit. See [[Defragmentation and TRIM operations]] for the full contrast with HDD defragmentation.

## Related
- [[SSD]] — brief SSD summary
- [[Secondary Storage]] — broader storage device context
- [[Defragmentation and TRIM operations]] — full details on the TRIM command and why it replaces defragmentation for SSDs
- [[Magnetic Disks]] — the mechanical HDD counterpart, useful for contrast
- [[Storage and FS#Physical Storage|Write Amplification and Wear Leveling]] — how these SSD mechanics feed into the broader storage/file-system picture

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| Flash Translation Layer (FTL) | FTL (also standard industry term) |
| Program/erase (P/E) cycle | Write endurance cycle |

