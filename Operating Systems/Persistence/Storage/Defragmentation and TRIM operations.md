# CSE451: Defragmentation and TRIM Operations

**Defragmentation** and **TRIM** are two different maintenance operations for keeping secondary storage devices performant, but they apply to opposite ends of the storage spectrum — one for mechanical [[Magnetic Disks|HDDs]], one for electronic [[Flash Storage|SSDs]] — precisely because HDDs and SSDs fail in opposite ways as they age.

## Defragmentation (for HDDs)

**Defragmentation** is the process of reorganizing the data on a [[Magnetic Disks|hard disk]] so that the parts of each file are stored in contiguous sectors.

- **Why it's needed**: As files are created, deleted, and modified, they become "fragmented" (scattered across different tracks and sectors), since new writes get placed wherever free space happens to be available rather than adjacent to the rest of the file.
- **Benefit**: Defragmentation minimizes the number of expensive **seeks** the disk arm must perform to read a single file, significantly improving sequential read/write performance, since a contiguous file can be read in one continuous sweep of the head rather than many small seeks between scattered fragments.
- **Note**: It is only useful for mechanical disks with moving heads — there is no seek penalty to eliminate on a device with no moving parts.

## TRIM (for SSDs)

**TRIM** is an OS-level command that informs a [[Flash Storage|Solid State Drive]] which blocks of data are no longer considered in use by the file system.

- **Why it's needed**: SSDs must erase an entire block before any page within it can be written to again. Because the SSD's firmware doesn't naturally know which files the OS has "deleted" (from the SSD's perspective, a deleted file's blocks look identical to a live file's blocks — the OS just removed its own directory entry pointing to them), the drive might keep this stale data around, making garbage collection less efficient since the controller has no signal that those blocks are actually free to reclaim.
- **Benefit**: TRIM allows the SSD to garbage collect those blocks early, ensuring a pool of clean, already-erased blocks is always available for high-speed writes, rather than being forced to erase-then-write at the moment a write request arrives.
- **Caution**: **Never defragment an SSD.** It does not improve performance, since there is no seek time to eliminate, and it only reduces the drive's lifespan by performing unnecessary writes that consume program/erase cycles.

## Related
- [[Magnetic Disks]] — full HDD mechanics and why fragmentation hurts performance there
- [[Flash Storage]] — full SSD mechanics and why erase-before-write makes TRIM necessary
- [[HDD]] — brief HDD summary
- [[SSD]] — brief SSD summary
- [[Secondary Storage]] — broader storage device context

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| Defragmentation | Disk defragmentation ("defrag") |
| TRIM | TRIM command (ATA) / UNMAP (SCSI) |

