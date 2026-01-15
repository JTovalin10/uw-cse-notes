this is a specialized hardware cache inside the CPU that fixes the biggest problem with page tables: **SLOWNESS**

TLB acts as a *Cheat Sheet* for the [[Memory Management Unit]]. it remembers recent translations fso the CPU doesnt ahvhe to look them up in the slow page table every time
# What exactly is it
TLB is a tiny, ultra fast memory chip physically located inside inside the [[Memory Management Unit]]
- it stores pairs
	- Virtual Page Number | Physical Frame Number
- it is associative
	- the hardware searches the entire TLB in parallel (all at once) to find a match instatnly
# How it works
- when your process tries to access a virtual address
	- check TLB: teh ahrdware checks the TLB first
		- TLB hit
			- if translation is found, the hardware extracts teh PFN instatnly
		- TLB miss
			- if not found then it needs to go into ram, read the page table, find the PFN, and insert into TLB for next time
# Why is it so effective
- TLB is tiny (32-128 entries)
- works because of locality
	- spatial 
		- if you access a[0] you are likely to access a[1]. since they are on the same page the TLB alreayd has the translation ready
	- temporal
		- if you access a variable now, you will lokley access it again soon (loop). the translation is still in TLB cache
#  Hardware vs. Software Management

Who handles the "TLB Miss" (the slow path)?

- **Hardware Managed (e.g., x86/Intel):** The CPU handles it automatically. It pauses the current instruction, walks the page table in RAM, updates the TLB, and resumes. The OS doesn't even know it happened.
    
- **Software Managed (e.g., MIPS/RISC-V):** The CPU raises a **Trap**. The OS pauses the process, runs a specific kernel code to look up the address, updates the TLB, and then restarts the instruction.
    

# The Context Switch Problem

When the OS switches from Process A to Process B, the TLB contains translations for Process A. If Process B tries to use those, it will access Process A's memory (security breach!).

The OS must do one of two things during a switch:

1. **Flush the TLB:** Empty the entire cache. (Safe, but Process B starts with 0 hits and runs slowly at first).
    
2. **ASID (Address Space ID):** Add a tag to every TLB entry identifying _who_ owns it (e.g., "This translation belongs to PID 10"). This allows entries from multiple processes to coexist in the TLB safely.