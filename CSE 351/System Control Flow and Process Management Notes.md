## Table of Contents

1. [System Control Flow Overview](#system-control-flow-overview)
2. [Exceptions](#exceptions)
3. [Processes](#processes)
4. [Context Switching](#context-switching)
5. [Fork-Exec Model](#fork-exec-model)
6. [Process Termination and Resource Management](#process-termination-and-resource-management)

---

## System Control Flow Overview

### Traditional vs. System Control Flow

#### Traditional Control Flow

- **Scope**: Order of execution within a single program
- **Responds to**: Changes in _program_ state
- **Limited to**: Individual process execution

#### System Control Flow (Exceptional Control Flow)

- **Scope**: Transfer of control between processes and operating system
- **Responds to**: Changes in _system_ state
- **Enables**:
    - Concurrent execution of multiple programs
    - Reaction to external signals (I/O devices)
    - Operating system intervention

### Why System Control Flow Matters

Modern computers execute multiple programs concurrently (often 100+ processes) even with limited CPUs. System control flow provides the mechanism to:

- Switch between processes efficiently
- Handle hardware events and interrupts
- Manage system resources safely
- Provide isolation between processes

---

## Exceptions

### Definition and Purpose

An **exception** is the transfer of execution/control to the operating system **kernel** in response to some event.

### Exception Handling Process

1. **Event occurs** (hardware interrupt, software trap, fault, etc.)
2. **Control transfers** to kernel
3. **Event handler executes** (kernel code that deals with the event)
4. **Handler completes** with one of three outcomes

### Exception Handler Outcomes

|Outcome|Description|When Used|
|---|---|---|
|**Re-execute current instruction**|Event handled, original instruction didn't complete|Recoverable faults (e.g., page fault)|
|**Execute next instruction**|Event handled, original instruction completed|Successful traps, interrupts|
|**Abort the process**|Event couldn't be handled|Unrecoverable errors|

### Types of Exceptions

#### Asynchronous Exceptions (Interrupts)

- **Cause**: Events _external_ to the processor (outside CPU's clock domain)
- **Examples**:
    - Hardware timer interrupts
    - I/O device completion signals
    - Network packet arrivals
- **Handler behavior**: Always returns control to _next_ instruction
- **Key characteristic**: Independent of current instruction execution

#### Synchronous Exceptions

- **Cause**: Executing an instruction (happens "on the clock")
- **Three subtypes**:

##### Traps

- **Nature**: _Intentional_ transfer of control to OS
- **Purpose**: Access privileged resources (disk, network, system calls)
- **Examples**:
    - `open()` system call
    - `malloc()` system call
    - `read()`/`write()` operations
- **Handler behavior**: Returns control to _next_ instruction (when successful)

##### Faults

- **Nature**: _Unintentional_ but _possibly recoverable_
- **Cause**: Unexpected outcomes from regular instructions
- **Examples**:
    - Division by zero
    - Segmentation faults (bad memory access)
    - Page faults (accessing unmapped memory)
- **Handler behavior**:
    - If recoverable: Returns to _current_ instruction (retry)
    - If unrecoverable: Abort process

##### Aborts

- **Nature**: _Unintentional_ and _unrecoverable_
- **Cause**: Serious hardware failures
- **Examples**: Hardware malfunction, memory corruption
- **Handler behavior**: Always abort process
- **Frequency**: Very uncommon

### Exception Example: File Operations

```c
// System call example
int fd = open("file.txt", O_RDONLY);  // Trap exception
```

- **Type**: Trap (intentional system call)
- **Handler outcome**: Execute next instruction (file is opened)
- **Why not re-execute**: File opening already completed successfully

---

## Processes

### Definition

A **process** is an instance of a running program/executable.

### Key Process Abstractions

The operating system provides two crucial abstractions:

#### 1. Logical Control Flow

- **Illusion**: Each process believes it has exclusive CPU use
- **Reality**: CPU time is shared among many processes
- **Implementation**: Context switching

#### 2. Private Address Space

- **Illusion**: Each process believes it has exclusive memory access
- **Reality**: Physical memory is shared and managed by OS
- **Implementation**: Virtual memory (covered in later lectures)

### Program vs. Process Distinction

```
Program: chrome.exe (executable file on disk)
↓
Process: Running instance of chrome.exe with:
         - Logical control flow abstraction
         - Private address space abstraction
         - Process ID (PID)
         - Execution state
```

### Concurrency

**Definition**: Two processes run **concurrently** if their instruction executions overlap in time.

#### Single CPU Concurrency

Even with one CPU, concurrency is achieved by:

- **Time slicing**: Rapidly switching between processes
- **Context switching**: Saving/restoring process state
- **Scheduling**: OS decides which process runs when

#### Viewing Running Processes

- **Windows**: Task Manager
- **macOS**: Activity Monitor
- **Linux**: `ps` command

---

## Context Switching

### Definition

**Context switching** is the mechanism by which the operating system switches execution between processes.

### Context Switching Process

1. **Save current state**
    
    - Save all CPU registers to memory
    - Save program counter (instruction pointer)
    - Save stack pointer and other process state
2. **Schedule next process**
    
    - OS scheduler selects next process to run
    - May consider process priority, waiting time, etc.
3. **Restore new process state**
    
    - Load saved registers from memory
    - Switch to new process's address space
    - Update memory management unit (MMU)

### Context Switching Visualization

```
Timeline: Process A → Context Switch → Process B → Context Switch → Process A

Process A: [Execute] [SAVE STATE] [Wait...] [RESTORE STATE] [Execute]
Process B: [Wait...] [RESTORE STATE] [Execute] [SAVE STATE] [Wait...]

CPU:       [A code] [OS switch] [B code] [OS switch] [A code]
```

### Performance Considerations

- **Overhead**: Context switches consume CPU cycles
- **Frequency**: Balance between responsiveness and efficiency
- **Hardware support**: Modern CPUs have features to speed up context switching

---

## Fork-Exec Model

### Overview

Linux uses the **fork-exec model** for process creation, splitting the operation into two distinct steps.

### Why Fork-Exec?

Instead of creating processes from scratch, this model provides:

- **Flexibility**: Can fork without exec, or prepare environment before exec
- **Simplicity**: Each operation has a single, well-defined purpose
- **Efficiency**: Can share resources between parent and child before exec

### Fork System Call

#### `fork()` Behavior

- **Purpose**: Duplicates the calling process
- **Result**: Creates a "child" process identical to "parent"
- **Return values**:
    - **Parent process**: Returns child's PID (positive integer)
    - **Child process**: Returns 0
    - **Error**: Returns -1

#### Fork Example

```c
#include <unistd.h>
#include <stdio.h>

int main() {
    pid_t pid = fork();
    
    if (pid > 0) {
        // Parent process
        printf("Parent: child PID is %d\n", pid);
    } else if (pid == 0) {
        // Child process  
        printf("Child: I am the child process\n");
    } else {
        // Fork failed
        perror("fork failed");
    }
    
    return 0;
}
```

### Exec Family Functions

#### Purpose

The `exec*()` family **overlays** the current process with a fresh instance of a specified program.

#### Exec Variants

|Function|Arguments|Environment|PATH|
|---|---|---|---|
|`execv`|Vector|Current|No|
|`execl`|List|Current|No|
|`execve`|Vector|Specified|No|
|`execle`|List|Specified|No|
|`execvp`|Vector|Current|Yes|
|`execlp`|List|Current|Yes|

- **Core system call**: `execve` (others are wrappers)
- **v/l**: Arguments as vector vs. list
- **e**: Specify environment variables
- **p**: Search PATH for executable

#### What Exec Overlays

|Memory Section|New State|Source|
|---|---|---|
|**Code**|Program instructions|Executable file|
|**Data**|Static data and literals|Executable file|
|**Heap**|Empty|No prior allocations|
|**Stack**|`main` stack frame setup|Library functions|
|**Registers**|Starting values for `main`|Library setup|

#### Register Setup for `main`

- **`%rdi`**: `argc` (argument count)
- **`%rsi`**: `argv` (argument vector)
- **`%rsp`**: Stack pointer to top of stack
- **`%rip`**: Instruction pointer to start of `main`

### Complete Fork-Exec Example

```c
#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>

void fork_exec(char *path, char *argv[]) {
    pid_t fork_ret = fork();
    
    if (fork_ret != 0) {
        // Parent process
        printf("Parent: created child with PID %d\n", fork_ret);
        // Parent continues execution
    } else {
        // Child process
        printf("Child: about to exec new program\n");
        execv(path, argv);
        // execv only returns if it fails
        perror("execv failed");
    }
    
    printf("This line printed by parent only!\n");
}

// Usage example
int main() {
    char *args[] = {"/usr/bin/ls", "-ahl", NULL};
    fork_exec("/usr/bin/ls", args);
    return 0;
}
```

### Key Fork-Exec Insights

1. **Child inherits everything** from parent at fork
2. **Exec completely replaces** process image
3. **Only parent continues** past successful exec in child
4. **Parent and child** execute concurrently after fork

---

## Process Termination and Resource Management

### Ways Processes Terminate

#### 1. Normal Termination

```c
int main() {
    // Process logic
    return 0;  // Status code 0 (success)
}
```

#### 2. Explicit Exit

```c
#include <stdlib.h>

int main() {
    // Process logic
    exit(0);  // Status code 0 (success)
    // Code after exit() never executes
}
```

#### 3. Exception Abort

- Process terminated by exception handler
- Usually due to unrecoverable error
- Examples: segmentation fault, illegal instruction

### Status Codes

- **Return from main**: Value becomes status code
- **Exit function**: Argument becomes status code
- **Abort**: No status code (abnormal termination)
- **Convention**: 0 = success, non-zero = error

### Process States and Resource Management

#### Zombie Processes

**Definition**: A terminated process whose resources haven't been cleaned up.

**Why zombies exist**:

- Process resources persist after termination
- Status code must be readable by parent
- System needs to track process until reaped

#### Process Reaping

**Definition**: Reading the status code and deallocating process resources.

**Reaping responsibility**: Parent process must reap its children

#### Reaping Methods

##### Explicit Reaping

```c
#include <sys/wait.h>

// Wait for any child to terminate
pid_t child_pid = wait(&status);

// Wait for specific child to terminate  
pid_t child_pid = waitpid(specific_pid, &status, 0);
```

##### Implicit Reaping

- Occurs automatically when parent process terminates
- All children are reaped when parent exits

### Orphaned Processes and `init`

#### Orphan Scenario

**Problem**: Parent terminates before child terminates **Solution**: Orphaned child is adopted by `init` process

#### The `init` Process

- **PID**: Always 1 (first process started by kernel)
- **Modern systems**: Often `systemd` instead of traditional `init`
- **Responsibility**: Reap orphaned processes
- **Behavior**: Automatically reaps any child that terminates

### Process State Examples

#### Example 1: Normal Parent-Child Lifecycle

```c
int main() {
    pid_t child = fork();
    
    if (child == 0) {
        // Child process
        printf("Child working...\n");
        exit(0);  // Child terminates → becomes zombie
    } else {
        // Parent process
        printf("Parent waiting...\n");
        wait(NULL);  // Parent reaps child → zombie cleaned up
        printf("Child reaped\n");
    }
    return 0;
}
```

#### Example 2: Zombie Creation

```c
int main() {
    pid_t child = fork();
    
    if (child == 0) {
        // Child process
        exit(0);  // Child terminates → becomes zombie
    } else {
        // Parent process
        sleep(10);  // Parent doesn't reap immediately
        // Child remains zombie for 10 seconds
        wait(NULL);  // Finally reap child
    }
    return 0;
}
```

#### Example 3: Orphan Adoption

```c
int main() {
    pid_t child = fork();
    
    if (child == 0) {
        // Child process
        sleep(5);    // Child outlives parent
        exit(0);     // Will be reaped by init/systemd
    } else {
        // Parent process
        exit(0);     // Parent terminates first → child becomes orphan
    }
}
```

### Best Practices

1. **Always reap children**: Use `wait()` or `waitpid()`
2. **Handle signals**: Set up signal handlers for child termination
3. **Avoid zombies**: Don't let children accumulate as zombies
4. **Error handling**: Check return values of all system calls
5. **Resource management**: Be aware of process lifecycle implications

---

## Summary

### Key Concepts

1. **Exceptional control flow** enables system-level process management
2. **Exceptions** provide mechanism for OS intervention and system calls
3. **Processes** give illusion of exclusive CPU and memory access
4. **Context switching** enables concurrent execution on shared hardware
5. **Fork-exec model** provides flexible process creation in Unix/Linux
6. **Process reaping** is essential for proper resource management

### System Call Summary

| System Call | Purpose                    | Returns                                   |
| ----------- | -------------------------- | ----------------------------------------- |
| `fork()`    | Create child process       | Child PID (parent), 0 (child), -1 (error) |
| `exec*()`   | Replace process image      | Only on error (-1)                        |
| `wait()`    | Wait for child termination | Child PID, -1 (error)                     |
| `waitpid()` | Wait for specific child    | Child PID, -1 (error)                     |
| `exit()`    | Terminate process          | Does not return                           |