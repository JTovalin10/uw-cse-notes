## What is it
**Execution Context** referes to dynamic parts of a running program. For example, if we were to "freeze" a program in the middle of a calculation, the execution context is exactly what we need to save to resume it later without the program knowing it stopped
## Examples
- [[Program Counter]]
- Registers
- [[Virtual Addresses]]
- OS Resources
	- if the process what writing to a file, the OS needs to remember which file was open and the current position of the "cursor" in that file (fd)