Question of the day: In what env should data center apps execute
- utilization

## Types of apps
### Data Center Apps
Virtualy anything can run in datacenters, here are some:
- websites and retail (etsy, ebay, doordash, small scale websites)
	- providing full linux instance to small website is wasteful
	- interactive, diurnal, sporadic, many need only sliver of a server
- traditional SaaS (gmail, salesforce, epic)
	- interactive, diurnal, CPU/network heavy
- Scientific/engineering computing
- ML tranining/inference
	- background, interactive, GPU/memory/network heavy
- Content Distribution (zoom, netflix, spotify)
	- network heavy, diurnal, and response time propeties
- data analysus (web indexing)
	- background, CPU, network heavy
- network functions (firewalls, vpn)
	- interactive, CPu, network heavy
- fil sharing (dropnbox)
	- non-interactive, diurnal, storage heavy
We can pause background applications for interactive applications. As such, we can pair them together
### Run Apps in Isolated Linux Servers
naturally, we will underutilize the serverr
- some apps dont use a full CPU, but want to scale up if popular
- diverse workload
	- mixture of background and foreground tasks
	- etc
### Diurnal Usage
- when a network or resource is scaled up and then is underutilized, you can give that to other clients
## Resource sharing and consolidation
### Sharing is Essential
- Sharing (consolidation) raises server utilization
	- can better utilize each server's resources
- however, uptime goal makes this tricky
	- need very strng isolation between users
	- a wonky app shuld not impact others at all
	- also, need to consider tail latency
		- datacenters ran studies that found response times of a website is longer than 0.5 seconds, more users leave
### Do Linux Processes provide strong isolation
- kernel's job is to isolate processes from each other
	- assign each app its own process
	- schedulers to isolate performance of different applications
	- each process has its own user-space
- is execution identical (semantic, performance) when sharing system with other apps
	- as we share resources, depending on the type of access, it can affect the performance of other applications
		- random seek vs sequential seek
	- default scheduling for OS is best effort which is fine for single-user
		- try their best to share their resources but a whale app can potentially hoard the scheduler
	- namespace sharing
		- want to sahre machine that all want to run a website
			- all want their own web server (port 80)
				- one port 80 for all applications
				- you need to multiplex port 80 so it can go to differnet applications (need to virtualize)
			- bugs can trigger performance problems in other applications (app or kernel)
			- security trick: write a process that looks at resources of other applications
				- virtualization addresses another level of resources 
			- user can be malevolent and create an IO heavy process or fork-bomb (threads or paging) to reduce performance
				- use up all processes, and other user cannot make more processes
#### Scenarios
- upgrading kernel
	- typically entails rebooting machine
		- how long will it be down, what if reboot fails, what if user doesnt finish their work
		- virtulization helps: virtual machine doesnt need to go down as you can move it across physical hardware
		- harder to do with processes as they use shared resources
		- bare-metal brings a lot of issues that virtualization handles
	- the new OS can make the old application incompatible
- security vulnerability
- Applications run in virtual (nearly unlimited) memory
- Linux kernel runs in physical (limited) memory
	- Fixed amount of space for process table, socket table, file descriptors, write ahead log, …
- What if one app uses up all the process or socket table space?


## Virtualization
- A virtual $X$ is an efficient, isolation duplicate of the real $X$
	- proposed to deal with the upgrade problem as new updates meant a entirely new OS
- $X = \{\text{processor, memory, disk, machine, network, datacenter}\}$
- duplicate: virtual X behaves identically to real $X$, the OS shouldnt tell that its running on different hardware (exceot timing differences)
	- programs cant tell the differences
	- except timing
- isolated
	- several $X$ execute without interference
	- multiple $X$ can be running at the same time
- efficient
	- speed close to that of the real hardware which requires that most mechanims run directly by hardware (too much software/emulator becomes too slow)
	- running fairly similar hardware
	- acts like a OS but different goals and garder isolation constraints
### Virtual Machines
Centralized datacenter shares resources and provides better scaling. For this, it requires a virtual abstraction to run like its original intent
- Each virtual machine runs its own operating system, multiplexed on physical machine’s resources
	- no one-size fits all
- Behavior of application plus its OS is isolated to the virtual machine
- Reproducible execution
- Easy to debug/checkpoint/restart/migrate (e.g., if need to upgrade the

underlying physical machine, first move apps to another physical machine)
#### Terms
- Guest Operating System
	- the OS that runs inside the virtual machine
	- gies application: an app run by the guest OS
- host operating system/hypervisor/virutal machine montior
	- the OS that multiplexs resources between virtual machines
	- the actual machine
- same for meory
	- host physical memory
	- guest  physical memory
	- guest virtual memory
#### Advantages
- server consolidation
	- for applications that need less than a while server, we can better match to better utilize resources
- sharing of server resources
	- foreground and background VMs, CPU and memory and disk intenvie VMs
- transparent checkpointing, and restart, transparent migration
	- we can checkpoint the VM when hardware is faulty and move it
	- fault tolerance, server softare/hardware upgrades
- I/O indirection/resource disaggregation
	- share disk storage across many applications
	- disk doesnt need to live in the same server (network in a different datacenter)
		- virtual disk that behaves like real one
- downsides
	- solutions are complex, worse single server performance
	- extra level of indreiction makes things slower but better for avaluability and manageability which are more heavy in pryamid of concerns