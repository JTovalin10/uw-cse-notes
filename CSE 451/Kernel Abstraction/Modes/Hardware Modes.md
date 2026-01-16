# Question
who gets to control the hardware
## Applications:
### Advantages
-  No OS middleman (little to no latency)
- Clients can potentially implement it faster
### Disadvantages
- Malicious code is easier to create
- if someone creates an attack then they have full access to the computer as the kernel cannot protect it
- have to rely on programmer to create a clean up mechanism if their code fails
## Operating System:
### Advantages
-  clean up and security
- creates a standard so its easier to create applications
### Disadvantages
- more overhead as you have to get through the middle man
# Modes
- on x86 its stored in EFLAGS
	- when thread is running its stored in CPU EFLAGS register
	- when not running (context switched out) its stored in [[Kernel Stack]]
 - on MIPS its stored in status register

Process Control Block (PCB):
## User:
- limited privileges
## Kernel:
- execution with the full privildges of the hardware
- r/w to any memory, access any I/O device, R/W any disk sector, send/read any packet