# CSE451: File

A **File** is a named collection of persistent information. It is the basic unit of long-term storage exposed by a [[File Systems|file system]] to userspace.

## What Are Files
A file is a collection of data along with some associated properties (metadata):
- Contents
- Size
- Owner
- Last read/write time
- Protection (permissions)

Files may also have **types**. Some types are understood directly by the file system itself, such as:
- Device (a special file representing a hardware device)
- **[[Directory]]** (a special file containing names and metadata of other files)
- Symbolic link (a special file containing a path to another file)

Other types are not understood by the file system itself, but rather by other parts of the OS or by runtime libraries layered on top, such as:
- Executable
- DLL (dynamically linked library)
- Source/object code
- Text file
- And more

## Encoding a File's Type
Since the file system only natively understands a small set of types (device, directory, symbolic link), everything else needs some way to communicate its type to whichever program or library interprets it. This type information can be encoded either in the file's name or in its contents, and different operating systems have historically chosen different conventions:
- **Windows** encodes types in the file's name (via extension) and sometimes in its content as well — e.g. `.com`, `.exe`, `.bat`, `.dll`, `.jpg`, etc.
- **Old Mac OS** instead stored the name of the creating program alongside the file, so the OS knew which application to launch to open it, without relying on a naming convention.
- **Unix** does both: it supports filename extensions as a convention, but many Unix tools (e.g. the `file` command) also inspect the file's actual contents (magic numbers/headers) to determine its type independent of the name.

## Related
- [[Directory]] — a specialized kind of file that stores names and metadata of other files
- [[File Systems]] — the abstraction layer that exposes files to userspace
- [[File System Operations]] — the operations (create, read, write, rename, etc.) that apply to files
- [[Storage and FS#File System Structures|Inode]] — the on-disk data structure that represents a file's metadata and data block pointers

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| File type encoded in name | File extension |
| File type encoded in contents | Magic number / file signature |
