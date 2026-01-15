# What is it?
OSTEP defines it as *A running program* where we have to understand its [[Machine State]]

A process is an **abstraction** provided by the OS that encapsulates:
- The program code (text segment)
- Current activity (program counter, registers)
- Memory (stack, heap, data segments)
- OS resources (open files, network connections)

# Process vs Program
| Program | Process |
|---------|---------|
| Static code on disk | Dynamic execution in memory |
| One copy | Multiple instances possible |
| Passive | Active |

# Key Components
- **[[Process Control Block]]**: OS data structure storing process state
- **[[Execution Context]]**: CPU state needed to resume execution
- **Address Space**: Virtual memory assigned to the process

# Process Lifecycle
1. **New**: being created
2. **Ready**: waiting for CPU
3. **Running**: executing on CPU
4. **Waiting/Blocked**: waiting for I/O or event
5. **Terminated**: finished execution

# Related
- [[Context Switch]]
- [[Machine State]]
- [[Process Control Block]]
- [[Virtual Addresses]]


