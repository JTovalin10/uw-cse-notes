# CSE451: File Systems

[[Secondary Storage]] devices are crude and awkward — they only expose raw, fixed-size blocks with no notion of names, organization, or byte-level addressing. A **file system** provides a convenient abstraction on top of this raw device interface.

## What Is It

A file system defines logical objects like files and directories, hiding the details of exactly where on disk a given file's data physically lives. Alongside these objects, it defines operations on them like read and write, letting callers work in terms of byte ranges instead of raw disk blocks.

- A **[[File]]** is the basic unit of long-term storage.
- A **[[Directory]]** is just a special kind of file, one whose contents are structured as a list of (name, metadata) entries rather than arbitrary data.
- Note: a sequential byte stream is only one possible way to organize a file's contents — it happens to be the dominant model (Unix and Windows both expose files this way), but it is not the only one a file system could choose.

## Operations

See [[File System Operations]] for the standard operations the file system interface defines, the design constraints and challenges involved, and concrete walkthroughs of the FAT and Unix File System designs.

## Related
- [[Persistent Storage]] — the broader storage stack this abstraction sits atop
- [[Secondary Storage]] — the raw device layer the file system abstracts over
- [[Storage and FS]] — Inode, Superblock, Dentry, VFS, and journaling details
- [[File]] — the basic unit of long-term storage
- [[Directory]] — the specialized file type used for organization

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| File system | Filesystem (FS) |
| Sequential byte stream | Flat byte-stream file model (as opposed to record-oriented files) |

