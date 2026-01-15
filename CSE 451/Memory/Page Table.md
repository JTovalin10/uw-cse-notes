# What is it
A page table is a data structure responsible for translating **virtual memory** addresses into **physical memory** addresses

# What does it do
Every process (application) belives it has a huge chunk of contingous memory all to itself, usually starting at address 0
- virtual memory
	- the fake perfect view of memory the process sees
- physical memory
	- the messy scattered reality of where data actually lives in ram hardware

The OS chops memory into fixed-size blocks called **pages**
- virtual page
	- a block in the process's view
- physical frame
	- the corresponding block in actual ram
- the page table is the dictionary that says *virtual page 1 maps to physical frame 10*
# How it works
When a process tries to access a variable the cpu cannot use that address directly, it must translate it

## Parts of virtual memory
1. VPN (virtual page number)
	1. the index. it tells us which page of the book we are on
	2. offset
		1. the exact locaiton on that page
## The steps
1. extract VPN
	1. the hardware (memory mangement unit) akes the top bits of the virtual dddress to get the VPN
	2. look up
		1. it uses the VPN as an index to look inside the Page Table
	3. find PFN
		1. inside the page table, it finds the PFN (physical frame number)
	4. calculate
		1. it combines the PFN + original offset to create the final physical address
# Where is it stored
The page table is stored in memory (RAM)
This creates a performance problem. to fetch one piece of data, the CPU actually has to do two memory lookus
1. one lookup to read the page table (to find where the data is)
2. one loop up to read the actual data

## Solution
To fix this slowness, the CPU uses a fast hardware cache called TLB or [[Translation Lookside Buffer]] which remembers recent translations

# Anatomy of Page Table Entry
The page table is an array of entries. Each entry (PTE) contains the physical frame number (PFN) plus several critical "status bits"
- valid bit
	- does this virtual page exist? 
	- if a process tries to access an invalid page (valid=0), the OS raises a trap (segfault)
- protection bit
	- read/write/execute permissions
	- can this code write to this page, if not segfault
- present bit
	- is the page currently in RAM or has it been swapped out to the hard disk
	- if 0 it triggers page fault
- dirty bit
	- has this page been modified since it was brought into memory
	- important for saving changes back to disk
- accessed bit
	- has this page been read recently
	- used to decide which page to kick out when RAM is full
# per-process vs global
each single process has its own page table

This is how memory protection works
- Proc A page table points to PF 50
- Proc B page table points to PF 90
- there is no entry in Proc A table that points to frame 90. Therefore, it is physicall impossible for Proc A to touch Proc B memory