[[Secondary Storage]] devices are crude and awkward

# what is it
- file system: a convenient abstraction
- defines logical objects like files and directories
	- hide details about where on disk files live
- as well as operations on object like read and write
	- read/write bytes ranges instead of blocks
- a [[File]] is the basic unit of long-term storage
- A [[Directory]] is just a special kind of file
- NOTE:
	- sequential byte steam is only one possability
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