# CSE451: File System Operations

The **file system interface** defines the standard operations that userspace programs can perform on [[File|files]] and [[Directory|directories]]:
- File (or directory) creation or deletion
- Manipulation of files and directories (read, write, extend, rename, protect)
- Copy
- Lock

Beyond these basic operations, file systems also provide higher-level services:
- Accounting and quotas
- Backup (must be incremental and online, since a system typically cannot be taken offline just to back up its files)
- (Sometimes) indexing or search
- (Sometimes) file versioning

## Design Constraints

Before deciding on an on-disk layout, a file system's design must satisfy competing constraints depending on file size, and it generally cannot know in advance which case a given file will fall into:

- **Small files**: Favor small blocks for storage efficiency (a small file shouldn't waste a huge block), and files that are used together should be stored together (physical locality reduces seek overhead when related files are accessed in sequence).
- **Large files**: Favor contiguous allocation for fast sequential access, but also need an efficient lookup mechanism for random access into the middle of the file.
- **Uncertainty at creation time**: The file system may not know at file creation time whether the file will end up staying small or growing large, so its data structures must gracefully handle both cases without requiring the file's eventual size to be known up front.

## Design: Core Data Structures

To meet these constraints, a file system design settles on three core data structures:
- **Directories**: Map a file name to file metadata. Directories are themselves stored as files (see [[Directory]]).
- **File metadata**: Records how to find a given file's data blocks (e.g., an [[Storage and FS#File System Structures|Inode]]).
- **Free map**: A list of free disk blocks, used to know where new data can be written.

## Design Challenges

Given those data structures, several concrete challenges must be resolved:

- **Where to store the file's data**: Most often within one or more blocks (also called "clusters"). Disks are divided into equal-sized blocks, numbered `0` to `n`.
- **Index structure**: How do we locate the blocks that make up a file? This is the core question of how a file's metadata records its block numbers.
- **Index granularity**: What block size do we use? This is often chosen as a multiple of the underlying disk sector size.
- **Free space**: How do we find unused blocks on disk? Often tracked with a bitmap, though other representations are possible.
- **Locality**: How do we preserve spatial locality? This is primarily an [[Magnetic Disks|HDD]] issue, since [[Defragmentation and TRIM operations|fragmentation]] on rotating media directly increases seek costs.
- **Reliability**: What happens if the machine crashes in the middle of a file system operation? A crash partway through a multi-block update can leave the file system in an inconsistent state (see [[Storage and FS#Reliability and Journaling|Reliability and Journaling]]).

![[File System Design Optiobs.png]]

## Concrete Walkthrough: Two Historical Designs

The following two designs show contrasting answers to the challenges above — a simple linked-list approach (FAT) and a more structured, inode-based approach (Unix).

### Microsoft's File Allocation Table (FAT)

**FAT** uses a linked-list index structure:
- Simple and easy to implement.
- Still widely used today (e.g. on USB drives and SD cards for cross-platform compatibility).

Its core data structure is the **file table**: a linear map of all blocks on the disk, where each file is represented as a linked list of blocks threaded through that table.

**Pros**:
- Easy to find a free block (scan the table for an unused entry).
- Easy to append to a file (just add the next block to the linked list and update the table).
- Easy to delete a file (walk the linked list, freeing each block).

**Cons**:
- Small file access is slow, since even a tiny file requires following the table's linked-list pointers.
- Random access is very slow, since reaching block `k` of a file requires walking through all `k-1` preceding blocks in the linked list rather than jumping directly to it.
- Fragmentation: file blocks for a given file may be scattered across the disk, and files that live in the same directory may also be scattered relative to each other. This problem becomes worse as the disk fills up and free blocks become harder to find contiguously.

#### FAT Disk Layout

The FAT file system organizes the disk into three regions:
- **Reserved area**: Boot sector and the File Allocation Table itself.
- **Root directory area**: The top-level directory of the file system.
- **Data region**: Where actual file contents live.

![[FAT disk layout.png]]

### Unix File System

The **Unix File System** takes a different approach, dividing the disk into five parts:

- **Boot block**: The system can boot by loading this block.
- **Superblock**: Specifies the boundaries of the next three areas, and contains the head of the freelist of inodes and file blocks. See [[Storage and FS#File System Structures|Superblock]].
- **I-node area**: Contains descriptors (i-nodes) for each file on the disk. All i-nodes are the same fixed size, and the head of their freelist is stored in the superblock. Each file is known internally by a number — its inode number — and files are created empty, growing only as they are extended through writes. See [[Storage and FS#File System Structures|Inode]].
- **File contents area**: Fixed-size blocks; the head of this area's freelist is also stored in the superblock.
- **Swap area**: Holds processes that have been swapped out of memory.

Unlike FAT's single linked-list-per-file approach, indexing a file's blocks through a fixed-size inode (rather than following a chain through a shared table) is what allows the Unix File System to support efficient random access — the inode can hold direct pointers to blocks (and indirect pointers for larger files) so that any block of the file can be located without walking a linked list.

## Deep Dive

The **swap area** described above is a holdover from an era when swap space was allocated as a dedicated disk partition alongside the file system itself, rather than as a swap file living inside a mounted file system (a common approach in modern Linux and other systems). Treating swap as its own fixed region on disk simplified the original Unix file system's five-part layout, since the kernel could then treat swapped-out process memory as sitting in region with known, fixed boundaries — set once at format time — rather than needing to negotiate space with the general-purpose file allocator.

## Related
- [[File]] — the abstraction these operations act on
- [[Directory]] — the specialized file type used to implement one of the three core data structures
- [[File Systems]] — the higher-level file system abstraction this file's operations belong to
- [[Storage and FS]] — Inode, Superblock, Dentry, and journaling details referenced above
- [[Magnetic Disks]] — the physical medium whose seek costs motivate the locality challenge
- [[Defragmentation and TRIM operations]] — how fragmentation caused by these allocation strategies is mitigated after the fact

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| File Allocation Table (FAT) | FAT file system (still an industry-standard term itself) |
| I-node area | Inode table |
| Free map | Free space bitmap / free space map |
| Swap area | Swap partition |
