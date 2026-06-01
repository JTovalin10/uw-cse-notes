# CSE451: Storage and File Systems

File systems provide a long-term storage abstraction, mapping human-readable names and hierarchies to raw disk blocks.

### Physical Storage
- **[[Hard Disk Drive (HDD)]]**: Performance is limited by mechanical movement:
    - **[[Seek Latency]]**: Time for the head to move to the correct track.
    - **[[Rotational Latency]]**: Time for the platter to rotate the sector under the head.
- **[[Solid State Drive (SSD)]]**: Uses flash memory with no moving parts.
    - **[[Write Amplification]]**: Occurs because data cannot be overwritten directly; a block must be erased before a page can be written.
    - **[[Wear Leveling]]**: An internal controller algorithm that ensures write cycles are distributed evenly across the drive to prevent cell failure.

### File System Structures
- **[[Inode]]**: A data structure representing a file. It contains metadata (size, owner, permissions) and pointers to data blocks.
- **[[Dentry (Directory Entry)]]**: Maps a filename to an Inode number.
- **[[Superblock]]**: Contains filesystem-wide metadata (total blocks, free block count, type).

### Links
- **[[Hard Link]]**: A second directory entry pointing to the same Inode. Deleting the original name does not delete the file until the "link count" reaches zero.
- **[[Soft Link (Symbolic Link)]]**: A special file that contains the path to another file. If the original file is deleted, the soft link becomes "broken."

### Reliability and Journaling
A crash during a multi-block write can leave the filesystem in an inconsistent state (e.g., block marked as used but not linked to an Inode).

- **[[Journaling]]**: Before making changes, the OS writes the intended actions to a **[[Journal]]**. After a crash, the system simply replays the journal to restore consistency.
- **[[fsync()]]**: A system call that forces all "dirty" data and metadata for a file to be written to physical storage.

### Virtual File System (VFS)
The **[[Virtual File System (VFS)]]** is a kernel abstraction layer that allows different physical filesystems (ext4, NTFS, NFS) to appear as a single, unified hierarchy to userspace.

### Related
- [[CSE451/Persistence/Inodes]]
- [[CSE451/Persistence/Journaling]]
