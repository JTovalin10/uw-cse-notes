# CSE391: Unix File System

The Unix file system is hierarchical, starting from the **Root Directory** (denoted as `/`).

## Directory Conventions
| Directory | Description |
|-----------|-------------|
| `/`       | Root directory that contains all other directories. |
| `/bin`    | Applications and programs (binary files). |
| `/dev`    | Hardware devices. |
| `/etc`    | System configuration files. |
| `/home`   | Contains users' home directories. |
| `/proc`   | Information about running programs (processes). |
| `/tmp`, `/var` | Temporary and variable files. |
| `/usr`    | Universal system resources. |

## Relative Directory References
- **`.`**: References the current working directory.
- **`..`**: References the parent of the current working directory.
- **`~username`**: References `username`'s home directory.
- **`~/Desktop`**: References your desktop.

## Related/See-also
- [[Linux Fundamentals/Basic Commands|Basic Commands]]
- [[Users Groups and Permissions/The PATH Variable|The PATH Variable]]
