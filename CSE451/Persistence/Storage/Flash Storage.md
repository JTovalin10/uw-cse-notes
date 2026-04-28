# Flash Storage (SSD)

Solid State Drives (SSDs) use semiconductor memory (typically NAND flash) to store data persistently. Unlike HDDs, they have no moving parts.

## Characteristics
- **No mechanical delay**: Seek time and rotational latency are effectively zero.
- **High Random I/O performance**: Much faster than HDDs for random accesses.
- **Limited write endurance**: Flash cells wear out after a certain number of program/erase (P/E) cycles.

## Mechanics: Blocks and Pages
- **Pages**: The smallest unit of reading and writing (typically 4KB–16KB).
- **Blocks**: A collection of pages (typically 128 or 256 pages).
- **Erase-before-write**: A page can only be written if it is clean. To overwrite data, an entire **block** must be erased first.

## Performance Optimization
- **Flash Translation Layer (FTL)**: Hardware/firmware that maps logical addresses to physical flash locations, handles wear leveling, and manages garbage collection.
- **Wear Leveling**: Ensuring that all flash blocks wear out at approximately the same rate.
- **Garbage Collection**: Reclaiming blocks by moving valid pages to new locations and erasing the old block.
- **[[Defragmentation and TRIM operations|TRIM]]**: An OS command that tells the SSD which blocks are no longer in use by the file system, allowing the SSD to garbage collect them early.

## Caution
**Never defragment an SSD.** It does not improve performance (since there is no seek time) and only wears out the flash cells by performing unnecessary writes.

## Related
- [[SSD]] — summary of SSD specifics
- [[Secondary Storage]] — broader context
- [[Defragmentation and TRIM operations]] — details on the TRIM command
