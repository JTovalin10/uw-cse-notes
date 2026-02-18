# What is it
a specific type of [[Interrupts]] caused by the program currently running

You can think of a trap as a formal request for help or an alarm triggered by the process itself. It is the mechanism a process uses to tell the OS "I need you to do something I'm not allowed to do" or "I made a mistake."

# Core purpose
The trap is a doorway into kernel mode, through which a process running in user mode can execute a special trap instruction to run kernel mode code.

# Components
- [[How Traps Work]]
- [[Types of Traps]]
- [[Trap vs Interrupt]]
