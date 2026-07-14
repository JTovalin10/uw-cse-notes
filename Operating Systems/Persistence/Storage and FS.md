# CSE451: Storage and File Systems

**File systems** provide a long-term storage abstraction, mapping human-readable names and hierarchies to raw disk blocks. This note ties together the physical storage layer, the on-disk structures a file system builds on top of it, and the reliability mechanisms needed to keep those structures consistent across crashes.

## Physical Storage

The performance characteristics of the underlying physical device shape almost every design decision a file system makes.

- **[[HDD|Hard Disk Drive (HDD)]]**: Performance is limited by mechanical movement. See [[Magnetic Disks]] for full mechanics.
    - **Seek Latency**: Time for the head to move to the correct track.
    - **Rotational Latency**: Time for the platter to rotate the desired sector under the head.
- **[[SSD|Solid State Drive (SSD)]]**: Uses flash memory with no moving parts. See [[Flash Storage]] for full mechanics.
    - **Write Amplification**: Occurs because data cannot be overwritten directly — a block must be erased before a page within it can be written again, so a single logical write can trigger the SSD's controller to erase and rewrite far more physical data than the logical write itself contained.
    - **Wear Leveling**: An internal controller algorithm that ensures write cycles are distributed evenly across the drive, since flash cells wear out after a limited number of program/erase cycles; without wear leveling, frequently-rewritten regions would fail long before the rest of the drive.

## File System Structures

On top of the physical storage layer, the file system builds its own on-disk structures to represent files, directories, and free space:

- **Inode**: A data structure representing a file. It contains metadata (size, owner, permissions) and pointers to the file's data blocks, but notably does *not* contain the file's name — see [[Storage/File System/Components/File System Operations#Unix File System|Unix File System]] for how the inode area fits into the overall disk layout.
- **Dentry (Directory Entry)**: Maps a filename to an Inode number. This is the mechanism that lets a human-readable path resolve down to the underlying inode and its data blocks — see [[Directory]] for how directories store these mappings.
- **Superblock**: Contains filesystem-wide metadata (total blocks, free block count, filesystem type). See [[Storage/File System/Components/File System Operations#Unix File System|Superblock]] for its role bounding the inode and file-content regions on disk.

## Links

Because a Dentry only maps a name to an inode number, and multiple dentries can point at the same inode, a single file's data can be reachable through more than one name:

- **Hard Link**: A second directory entry pointing to the same Inode. Deleting the original name does not delete the file's data until the "link count" (the number of directory entries referencing that inode) reaches zero.
- **Soft Link (Symbolic Link)**: A special file that contains the path to another file, rather than pointing at the same inode directly. If the original file is deleted, the soft link becomes "broken," since it only stores a path string, not an inode reference.

## Reliability and Journaling

The structures above only stay consistent if updates to them are atomic. A crash during a multi-block write can leave the file system in an inconsistent state — for example, a data block might be marked as "in use" in the free map, but not yet linked to any Inode, because the crash happened between updating the free map and updating the inode's block pointers.

- **Journaling**: Before making changes to the file system's actual structures, the OS first writes the intended actions to a **Journal** (a sequential log). After a crash, the system simply replays the journal to restore consistency, redoing (or undoing) whatever operations were in flight, rather than having to scan the entire disk for inconsistencies.
- **fsync()**: A system call that forces all "dirty" (modified but not yet written back) data and metadata for a file to be written to physical storage, giving the caller a guarantee that the data has actually reached durable storage rather than merely sitting in an in-memory cache.

## Virtual File System (VFS)

The **Virtual File System (VFS)** is a kernel abstraction layer that allows different physical file systems (ext4, NTFS, NFS) to appear as a single, unified hierarchy to userspace. Userspace programs issue the same read/write/open system calls regardless of which underlying file system actually backs a given path, and the VFS dispatches each call to the appropriate file-system-specific implementation.

## Formal Definition

A journaling file system maintains the invariant that any operation touching multiple on-disk structures is made atomic with respect to crashes by first appending a record of the intended writes to the journal, then only later applying ("checkpointing") those writes to their final on-disk locations:

$$\text{Journal write} \prec \text{Checkpoint write}$$

If a crash occurs before the checkpoint completes, recovery replays the journal to reach the same final state the checkpoint would have produced, rather than leaving the structures partially updated.

## Simplified Explanation

Instead of directly editing the file system's real data structures and risking a half-finished edit if the power goes out, the OS first writes down "here's what I'm about to do" in a notebook (the journal). If it crashes partway through, it just re-reads the notebook on reboot and finishes (or redoes) whatever it was in the middle of, so the file system never gets caught in an inconsistent, half-updated state.

## Related
- [[Magnetic Disks]] — full HDD mechanics behind the Physical Storage section
- [[Flash Storage]] — full SSD mechanics behind the Physical Storage section
- [[File Systems]] — the higher-level file system abstraction hub
- [[File System Operations]] — FAT and Unix File System on-disk layouts, including the inode area and superblock
- [[Directory]] — how directory entries (dentries) are stored
- [[File]] — the file abstraction these structures represent

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| Journal | Write-ahead log (WAL) |
| Journaling | Write-ahead logging |
| Dentry | Directory entry cache entry (dcache entry) |
| VFS | Virtual filesystem switch / filesystem abstraction layer |
