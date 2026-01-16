# What is it
a specific type of [[Interrupts]] caused by the program currently running

You can think of a trap as a formal request for help or an alarm triggered by the process itself. it is the mechanism a process uses to tell the OS "i need you to do something im not allowed to do" or "I made a mistake"

# Core purpose
the trap is a doorway between [[Mode Switch]] where a process running in user mode can execute a special trap instruction to do kernel mode code

# Components
- [[How Traps Work]]
- [[Types of Traps]]
- [[Trap vs Interrupt]]
