# Defragmentation and TRIM operations

Two different methods for maintaining the performance and health of secondary storage devices.

## Defragmentation (for HDDs)
**Defragmentation** is the process of reorganizing the data on a [[Magnetic Disks|hard disk]] so that the parts of each file are stored in contiguous sectors.

- **Why it's needed**: As files are created, deleted, and modified, they become "fragmented" (scattered across different tracks and sectors).
- **Benefit**: It minimizes the number of expensive **seeks** the disk arm must perform to read a single file, significantly improving sequential read/write performance.
- **Note**: It is only useful for mechanical disks with moving heads.

## TRIM (for SSDs)
**TRIM** is an OS-level command that informs a [[Flash Storage|Solid State Drive]] which blocks of data are no longer considered in use by the file system.

- **Why it's needed**: SSDs must erase a block before it can be written to again. Because the SSD's firmware doesn't naturally know which files the OS has "deleted," it might keep stale data around, making garbage collection less efficient.
- **Benefit**: TRIM allows the SSD to garbage collect those blocks early, ensuring a pool of clean blocks is always available for high-speed writes.
- **Caution**: **Never defragment an SSD.** It does not improve performance and only reduces the drive's lifespan by performing unnecessary writes.

## Related
- [[Magnetic Disks]]
- [[Flash Storage]]
- [[HDD]]
- [[SSD]]
