named file that contains names of other files and metadata about those files (e.g., file size)
## What they provide
- a way for users to organize their files
- a convient file name space for both user and file system
## Multi-Level
- most file systems support multi-level directories
- c:\, c:\Document, etc
- absolute names: fully-qualified starting from root of the file system
- relative names: specified with respect to the current directory
## Internals
- a direcoty is typicaly just a file that happens to contain special metadata
- directory = list of (names of file, file attribute)
- attributes include such things as:
	- size, protection, location on disk, creation time, access time, etc
- the directory can be unordered (random)
	- ls or dis /on has to sort the results
	- sort file systems organize the directory file as BTree, giving natural ordering
		- 