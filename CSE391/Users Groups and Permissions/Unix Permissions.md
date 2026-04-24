# Unix Permissions

Unix permissions define who can do what with a file or directory. These are visible when running `ls -l`.

## Permission String Structure
A permission string looks like `-rwxr-xr--`:
- **Type (1st char):** `-` for file, `d` for directory, `l` for symbolic link.
- **User/Owner (chars 2-4):** `rwx`
- **Group (chars 5-7):** `r-x`
- **Others (chars 8-10):** `r--`

### Action Types Breakdown
| Permission | On a File | On a Directory |
| :--- | :--- | :--- |
| **r** (read) | View the file's content. | List the files inside (e.g., `ls`). |
| **w** (write) | Modify the file's content. | Add, delete, or rename files inside. |
| **x** (execute) | Run the file as a program/script. | Enter the directory (e.g., `cd`). |

---

## Modifying Permissions (`chmod`)
The `chmod` (change mode) command is used to modify these settings.

### 1. Symbolic (Letter) Mode
`chmod [who][action][permission] file`
- **Who:** `u` (user), `g` (group), `o` (others), `a` (all).
- **Action:** `+` (add), `-` (remove), `=` (set exactly).
- **Example: Give owner execute permission**
  ```bash
  chmod u+x script.sh
  ```
- **Example: Remove write permission for group and others**
  ```bash
  chmod go-w sensitive_data.txt
  ```
- **Example: Set specific permissions for everyone**
  ```bash
  chmod a=r public_note.txt
  ```

### 2. Octal (Numeric) Mode
`chmod NNN file`
Each digit represents one of the three "who" categories (User, Group, Others). The digit is calculated by summing the values of the permissions:
- **4**: Read (r)
- **2**: Write (w)
- **1**: Execute (x)

| Sum | Permissions | Description |
| :--- | :--- | :--- |
| **7** | `rwx` | Full access (4+2+1) |
| **6** | `rw-` | Read and Write (4+2) |
| **5** | `r-x` | Read and Execute (4+1) |
| **4** | `r--` | Read Only |
| **0** | `---` | No permissions |

**Common Octal Examples:**
- `chmod 755 script.sh`: `rwxr-xr-x` (Owner can do anything; others can read/execute).
- `chmod 644 file.txt`: `rw-r--r--` (Owner can read/write; others can only read).
- `chmod 600 private.key`: `rw-------` (Only the owner can read/write).
- `chmod 700 secret_dir`: `rwx------` (Only the owner can enter/modify the folder).

---

## Recursive Modification
Use the `-R` flag to apply changes to a directory and all its contents (subfolders and files).
```bash
chmod -R 755 project_folder/
```

---

## Changing Ownership (`chown` and `chgrp`)
While `chmod` changes *what* can be done, these commands change *who* owns the file.
- **chown (change owner):** `chown username file.txt`
- **chgrp (change group):** `chgrp groupname file.txt`
- **Both at once:** `chown username:groupname file.txt`

## Related/See-also
- [[The PATH Variable\|The PATH Variable]]
- [[Shell Customization\|Shell Customization]]
- [[Linux Fundamentals/Commands/ls\|ls Command]]
