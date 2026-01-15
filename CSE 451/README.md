# CSE 451 - Operating Systems

## Course Overview

CSE 451 covers the design and implementation of operating systems. The course explores how operating systems manage hardware resources, provide abstractions for applications, and ensure security and reliability.

## Topics Covered

### Introduction to Operating Systems
- What is an operating system: resource management software
- OS roles: Referee, Illusionist, Glue
- Mechanism vs Policy
- Key challenges: Portability, Reliability, Availability, Security, Privacy, Performance
- Performance metrics: Latency, Throughput, Overhead, Fairness
- Backward and forward compatibility

### Kernel Abstraction
- Hardware modes (user mode vs kernel mode)
- Privilege levels and privileged instructions
- Memory protection: Base and bounds
- Virtual addresses
- Code segments and stack segments

### Interrupts and Exceptions
- Interrupt handling and interrupt vectors
- Interrupt masking (CLI/STI instructions)
- Exception handling
- Polling vs interrupts
- Mode switching
- Atomic transfer of control
- Transparent restartable execution

### System Calls
- User-to-kernel interface
- Argument passing and validation
- Copying data between user and kernel space
- Examples: file operations, memory allocation

### Registers and Flags
- General-purpose registers (EAX, EBX, ECX, EDX, ESI, EDI)
- Stack registers (EBP, ESP)
- EFLAGS register
- Interrupt flag (IF)
- General Protection Fault (GPF)

### Memory Structures
- Global Descriptor Table (GDT)
- Local Descriptor Table (LDT)
- Kernel stack vs user stack
- Interrupt stack
- Memory layout

### OS Components and Structures
- Major OS components
- Process management
- OS structure and design

### Processes
- Process concept and abstraction
- Process Control Block (PCB)
- Process identification (PID)
- Process state (ready, running, blocked)
- Process operations
- Machine state: registers, memory, I/O

### Context Switching
- Execution context
- Context switch mechanism
- CPU scheduling information
- Trap tables and trap handling

### Memory Management
- Memory management information
- Page tables
- Accounting information
