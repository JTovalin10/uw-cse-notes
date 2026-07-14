# CSE451: Directory

A **Directory** is a named file that contains the names of other files and metadata about those files (e.g., file size). Conceptually, a directory is just a special kind of [[File]] whose contents are structured as a list of name-to-metadata mappings rather than arbitrary data.

## What They Provide
- A way for users to organize their files into a hierarchy instead of a flat, unstructured pool.
- A convenient file name space for both the user and the [[File Systems|file system]] — the user thinks in terms of human-readable path names, while the file system underneath translates those names to the on-disk location of the actual data.

## Multi-Level Directories
Most file systems support **multi-level directories**, meaning directories can contain other directories, forming a tree (e.g., `c:\`, `c:\Documents`, etc.). This nesting is what lets users organize files into arbitrarily deep hierarchies rather than being stuck with one giant flat namespace.

Paths into this hierarchy can be specified two ways:
- **Absolute names**: Fully qualified paths starting from the root of the file system (e.g. `c:\Documents\notes.txt`). These always resolve to the same file regardless of where the process currently "is" in the hierarchy.
- **Relative names**: Specified with respect to the current directory (e.g. `notes.txt` when already inside `Documents`). These are shorter to type but depend on the process's current working directory.

## Internals
A directory is typically just a [[File]] that happens to contain special metadata instead of ordinary user data. Structurally, a directory is a list of **(file name, file attributes)** pairs. The attributes stored per entry include things like:
- Size
- Protection (permissions)
- Location on disk
- Creation time
- Access time

The directory's internal list can be organized in different ways depending on the file system:
- **Unordered (random)**: Entries are stored in whatever order they were added. Listing commands like `ls` or `dir /on` must explicitly sort the results themselves before displaying them, since the underlying storage order carries no guarantee.
- **Ordered (B-Tree)**: Some file systems organize the directory's entries as a B-Tree, which gives natural ordering (e.g., alphabetical) "for free" as entries are inserted, without requiring a separate sort step at listing time.

## Related
- [[File]] — the more general abstraction a directory specializes
- [[File Systems]] — how directories fit into the overall file system abstraction
- [[File System Operations]] — operations like creation, deletion, and lookup that apply to directories
- [[Storage and FS#File System Structures|Dentry (Directory Entry)]] — the concrete on-disk/in-kernel structure mapping a filename to an Inode

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| Directory | Folder |
| Absolute name | Absolute path |
| Relative name | Relative path |
