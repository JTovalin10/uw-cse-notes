# CSE391: Unix Permissions

Unix permissions define who can do what with a file or directory. These are visible when running `ls -l`.

## Permission Structure
A permission string looks like `drwxrwxrwx`:
- `d`: Indicates if it's a directory (`-` if it's a file).
- `rwx` (1st set): Permissions for the **Owner** (u).
- `rwx` (2nd set): Permissions for the **Group** (g).
- `rwx` (3rd set): Permissions for **Others** (o).

### Action Types
- **r** (read): Permission to read the file or list directory contents.
- **w** (write): Permission to modify the file or add/remove files in a directory.
- **x** (execute): Permission to run the file as a program or enter the directory.

## Modifying Permissions (`chmod`)
The `chmod` command is used to change permissions.

### Symbolic (Letter) Mode
`chmod [who][action][permission] file`
- **Who:** `u` (user/owner), `g` (group), `o` (others), `a` (all).
- **Action:** `+` (add), `-` (remove), `=` (set exactly).
- **Example:** `chmod u+x script.sh` (gives owner execute permission).
- **Example:** `chmod ug+rw,o+r file.txt` (gives owner/group read/write, others read only).

### Octal (Numeric) Mode
`chmod NNN file`
Each digit is the sum of permissions: **4 (read) + 2 (write) + 1 (execute)**.
- **7** (4+2+1): read, write, and execute.
- **6** (4+2): read and write.
- **5** (4+1): read and execute.
- **4**: read only.
- **Example:** `chmod 754 file.txt` (u=rwx, g=rx, o=r).

## Default Permissions (`umask`)
The `umask` command sets the default permissions for newly created files. It "masks out" (removes) permissions from the default (usually 666 for files, 777 for directories).
- Example: `umask 022` results in new files having 644 permissions.

## Related/See-also
- [[Users Groups and Permissions/The PATH Variable|The PATH Variable]]
- [[Users Groups and Permissions/Shell Customization|Shell Customization]]
