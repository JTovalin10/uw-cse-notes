# Operations
- the file system interface defines standard operations
	- file (or dir) creation or deletion
	- manipulation of files and directories (read, write, extend, rename, protect)
	- copy
	- lock
- file systems also provide higher level services
	- accounting and quotas
	- backup (must be incremental and online)
	- (sometimes) indexing or search
	- (sometimes) file versioning
## Constratints
- small files
	- small blocks for storage efficiency
	- files used together should be stored together
- large files
	- contingous allocation for sequential access
	- efficient lookup for random access
- may not know at file creation
	- whether the file will become small or big
## Design
- data structures
	- directories: fle name -> file metadata
		- stores directories as fils
	- file metadata: how to find file data blocks
	- free map: list of free disk blocks
## Challenges
- where to store the file's data
	- most foten within a block(s) aka ckuset's
	- disk are dividec into equal sized blocks, 0 to n
- index structure
	- how do we lcote the blocks of a file: block numbers
- index granularity
	- what block size do we use
		- often a multiple of the disk sector size
- free space
	- how do we find unused blocks on disk: often a bitmap, but other options
- locality
	- how do we presevre spatial locaity: an HDD issue, fragmenetian is tied to this
- reliability
	- what if the machine crashes in the middle of a file system operation
## Options
![[File System Design Optiobs.png]]

### Microsoft's File Allocation Table (FAT
- linked list index structure
	- simple and easy to implement
	- still widely used
- file table
	- linear map of all blocks on disk
	- each file is a linked list of blocks
- allocation granliarty
pros:
- easy to find free block
- easy to append to a file
- easy to delete a file
cons
- small file access is slow
- random access is very slow
- fragmentation
	- file blocks for a given file may be scattered
	- files in the same directory may be scattered
	- becomes worse
	- as disk is used
#### Disk Layout
- reserved area (boot sector and FAT
- root directory area
- data region
![[FAT disk layout.png]]
## Unix File System
Disks are divided into 5 parts
- boot block
	- can boot the system by loading this block
- superblock
	- specifies boundary of the next 3 areas, and contains head of freelist of inodes and file blocks
- i-node area
	- contains descriptors (i-nodes) for each file on the disk; all i-nodes are the same size; head of freelist is in the superblock
	- each file is known by a number (inode)
	- files are created empty and grow when extended through writes
- file contents area
	- fixed-size blocks; head of freelist is in the superblock
- swap area
	- holds processes that have been swapped out of memory