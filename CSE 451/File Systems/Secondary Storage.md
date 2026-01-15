# what is it
- Disk, FLASH, tape
- persistant memory
- usually independent of file system
	- although there may be cooperation
	- file system knowledge of device details can help optimize performance
		- place related files close together on disk
# what does it do
- routine that interacts with disks are typically at a very low level in the OS
	- used by many components (file system, VM, ...)
	- handle scheduling of disk operations, head movement, error handling, and often management of space on disks