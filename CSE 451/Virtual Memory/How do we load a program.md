1. create a process descirpt [[Process Control Block]]
2. create [[Page Table]]
3. put address space image on disk in page-sized chunks
4. build [[Page Table]] (pointed to by process descriptor)
	1. all PTE valid bits = false
	2. an analgous data structure indicates the disk location of the corresponding page
	3. when process starts executing
		1. instuction immed fault on both code and data pages
		2. fault tapers off, as the necessary code/data pages enter memory
This relies on [[spatial locality]] and [[Temporal locality]] as it means paging can be infrequent
![[Pasted image 20260213200417.png]]