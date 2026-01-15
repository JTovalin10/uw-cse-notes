# Fork-Exec Model

Linux uses the **fork-exec model** for process creation, splitting the operation into two steps.

**Related:** [[Processes]], [[Context Switching]], [[System Calls]]

---

## Why Fork-Exec?

- **Flexibility:** Fork without exec, or prepare environment before exec
- **Simplicity:** Each operation has single, well-defined purpose
- **Efficiency:** Share resources between parent and child before exec

---

## Fork System Call

### `fork()` Behavior

- **Purpose:** Duplicates the calling process
- **Result:** Creates "child" process identical to "parent"

### Return Values

| Process | Return Value |
|---------|--------------|
| Parent | Child's PID (positive) |
| Child | 0 |
| Error | -1 |

### Example

```c
pid_t pid = fork();

if (pid > 0) {
    // Parent process
    printf("Parent: child PID is %d\n", pid);
} else if (pid == 0) {
    // Child process
    printf("Child: I am the child\n");
} else {
    perror("fork failed");
}
```

---

## Exec Family Functions

### Purpose

**Overlay** current process with fresh instance of specified program.

### Variants

| Function | Arguments | Environment | PATH |
|----------|-----------|-------------|------|
| `execv` | Vector | Current | No |
| `execl` | List | Current | No |
| `execve` | Vector | Specified | No |
| `execvp` | Vector | Current | Yes |

### What Exec Overlays

| Section | New State |
|---------|-----------|
| Code | From executable |
| Data | From executable |
| Heap | Empty |
| Stack | `main` frame setup |
| Registers | Starting values |

---

## Complete Example

```c
void fork_exec(char *path, char *argv[]) {
    pid_t pid = fork();

    if (pid != 0) {
        // Parent continues
        printf("Parent: created child %d\n", pid);
    } else {
        // Child execs new program
        execv(path, argv);
        perror("execv failed");  // Only reached on error
    }
}
```

---

## Key Insights

1. Child inherits **everything** from parent at fork
2. Exec **completely replaces** process image
3. Only parent continues past successful exec
4. Parent and child execute **concurrently** after fork

**Related:** [[Processes]], [[Process Termination]]
