# Lecture
- A big chunk of the OS kernel deals with I/O
	- hundreds of thousands of lines in Windows, Unix, etc
- The OS provides a standard interface between programs (user or system) and devices
	- file system (disk), sockets (networks), frame buffer (video)
- **Device drivers** are the routines that interact with specific devices types
	- encapsulates device-specific knowledge
		- eg how to initialize a device how to request I/O how to handle interrupts or errors
		- example: SCSI device drivers, Ethernet card drivers, video card drivers, sound card drivers, ...

# What is it
I/O stands for **Input/Output**

refers to the communication between the computer information processing stream and the outside world

# The two directions
- Input (read): Data received by the system
	- examples: typing on a keyboard, moving a mouse, a microphone recording audio, or reading from a file from the hard drive into memory
- Output (Write): Data sent from the system
	- example: displaying an image on a monitor, playing sound through speakers, printing a document, or saving data back to the HD
# The speed gap problem
- a modern CPU can execute billions of instructions per second
- reading data from a harddrive or waiting for a user to press a key can take milliseconds (eternity for a CPU)
Essentially I/O is incredibly slow compared to the CPU
## So what can we do
The OS cannot afford to let the CPU sit idle waiting for a file to load or a key to be pressed. So, this is where waiting/blocked state comes in
1. **request**
	1. a running process asks for I/O
2. **Block**
	1. since the data isnt ready instantly the OS moves the process from running to waiting
3. **switch**
	1. the OS performs a [[Context Switch]] and gives the CPU to a different process that is ready to run
4. **interrupts**
	1. when the I/O device finishes (the user pressed a key), it sends an electrical signal (interrupt) to the CPU
5. **Wake up**
	1. the OS moves the original process back to **Ready** so it can handle the new data
# How the OS manages I/O
- Device Drivers
	- small software programs that act like translators which allow the OS to speak to specific hardware without knowing how the hardware is built
- system calls
	- the API provided to [[Process]](es) to perform I/O
		- read(), write(), open(), close(), etc
- Buffering
	- the OS stores data in a temporary memory area (buffer) while it is being transferred. This helps smooth out the speed difference between a fast CPU and a slow device.