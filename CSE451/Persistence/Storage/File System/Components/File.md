named collection of persistent information
## What are files
- a file is a collection of data with some properties
	- contents, size, owner, last read/write, protection
- file may also have types
	- some understood by file system
		- device, directory, symbolic link
	- some understood by other parts of OS or by runtime libraries
		- executable, dll, source/object code, text file, more
- type can be encoded in the file's name or contents
	- windows encodes types in name (and content)
		- .com, .exe, .bat, .dll, .jpg, etc
	- old mac stored the name of the creating program along with the file
	- unix does both as well