# Problem
1. the semantics of [[Fork]] say the child's address space is a copy of the parent's
2. implementing fork() that way is too slow
	1. have to allocate physical memory for the new address space and reserve [[swap space]]
	2. have to set up child's page tables to map new address space
	3. have to copy the parent's address space contents into child's address space
		1. which we will likely throw away with an [[Exec]]
# Solutions
1. [[vfork]]
2. [[clone]]
