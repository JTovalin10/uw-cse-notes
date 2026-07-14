# CSE451: IO

## What Is It
**I/O** stands for **Input/Output** and refers to the communication between the computer's information-processing stream and the outside world.

## The Two Directions
- **Input (read)**: Data received by the system.
	- Examples: typing on a keyboard, moving a mouse, a microphone recording audio, or reading a file from the hard drive into memory.
- **Output (write)**: Data sent from the system.
	- Examples: displaying an image on a monitor, playing sound through speakers, printing a document, or saving data back to the hard drive.

## Why I/O Matters to the OS
A big chunk of the OS kernel deals with I/O — hundreds of thousands of lines of code in Windows, UNIX, and other major operating systems. The OS provides a standard interface between programs (user or system) and devices, regardless of what specific hardware is underneath:
- The **file system** provides this standard interface for disks.
- **Sockets** provide this standard interface for networks.
- The **frame buffer** provides this standard interface for video output.

**Device drivers** are the routines that interact with specific device types. A device driver encapsulates device-specific knowledge — for example, how to initialize a device, how to request I/O from it, and how to handle its interrupts or errors — so that the rest of the OS does not need to know these hardware-specific details. Examples include SCSI device drivers, Ethernet card drivers, video card drivers, and sound card drivers. This is conceptually related to the [[Operating Systems/Virtualization/Architecture/Hardware Abstraction Layer|Hardware Abstraction Layer]], since device drivers are exactly the kind of hardware-specific routine the HAL isolates from the rest of the kernel.

## The Speed Gap Problem
A modern CPU can execute billions of instructions per second. Reading data from a hard drive, or waiting for a user to press a key, can take milliseconds — an eternity from the CPU's perspective. Essentially, I/O is incredibly slow compared to the CPU.

### So What Can We Do
The OS cannot afford to let the CPU sit idle waiting for a file to load or a key to be pressed. This is where the waiting/blocked [[Process State|process state]] comes in. When a process performs I/O, the OS follows this sequence of steps:

1. **Request**: A running process asks for I/O (e.g., by issuing a `read()` system call).
2. **Block**: Since the data isn't ready instantly, the OS moves the process from the running state to the waiting (blocked) state, so it does not occupy the CPU while it has nothing useful to do.
3. **Switch**: The OS performs a [[CPU State#Context Switch|Context Switch]] and gives the CPU to a different process that is ready to run, ensuring the CPU stays busy with useful work instead of idling.
4. **Interrupt**: When the I/O device finishes (e.g., the user presses a key, or the disk delivers the requested data), it sends an electrical signal — an [[Interrupts|interrupt]] — to the CPU to announce that the I/O operation has completed.
5. **Wake up**: The OS moves the original process back to the **Ready** state so it can be scheduled again to handle the new data.

```mermaid
flowchart LR
    A[Running Process] -->|(1) Request I/O| B[OS: Block Process]
    B -->|(2) Move to Waiting state| C[Waiting/Blocked]
    B -->|(3) Context Switch| D[Different Ready Process Runs]
    E[I/O Device Completes] -->|(4) Sends Interrupt| F[CPU]
    F -->|Interrupt Handler Runs| G[OS: Wake Up Process]
    G -->|(5) Move to Ready| H[Ready Queue]
```

## How the OS Manages I/O
- **Device Drivers**: Small software programs that act like translators, allowing the OS to speak to specific hardware without the rest of the OS needing to know how that hardware is built internally.
- **System Calls**: The API provided to [[Process|Process]](es) to perform I/O — for example, `read()`, `write()`, `open()`, and `close()`. These system calls are the standardized entry points a program uses to request I/O services from the kernel, tying back into the [[Operating Systems/Virtualization/Architecture/Operating System Roles#3. The Glue: Common Services and Interoperability|Glue role]] of the OS.
- **Buffering**: The OS stores data in a temporary memory area (a buffer) while it is being transferred. This helps smooth out the speed difference between a fast CPU and a slow device, since the CPU can hand off data to the buffer and move on to other work rather than waiting for the slow device to finish consuming or producing it directly.

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| Device Drivers | Device drivers / kernel modules |
| System Calls | Syscall interface / POSIX API |
| Buffering | I/O buffering / write-back caching |
| Interrupt | Hardware interrupt (IRQ) |

## Related
- [[Operating Systems/Virtualization/Architecture/Hardware Abstraction Layer|Hardware Abstraction Layer]] — abstracts the hardware-specific detail that device drivers encapsulate
- [[Interrupts|Interrupts]] — the mechanism used to notify the CPU that I/O has completed
- [[CPU State#Context Switch|Context Switch]] — mechanism used to give the CPU to another process while one is blocked on I/O
- [[Process State|Process State]] — the running/waiting/ready state model that I/O blocking relies on
- [[Operating Systems/Virtualization/Architecture/Operating System Roles|Operating System Roles]] — system calls as an example of the Glue role