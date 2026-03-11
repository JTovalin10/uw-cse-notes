# Meltdown
this is when a user space program is allowed to read kernel space memory
## Reading Kernel Memory from User Space
- Three parts
	- what is my cache? Pipelining and branch prediction
	- use timing to determine if something is in the cache or not
	- A simple coding example to determine the value of a byte
### Determining the value of a byte
- this snippet of ode reads a byte and uses its value as an index to an array
```c
if (cond) {
	unsigned char value = *(unsigned char*) ptr; // pointer to secret
	maccess(&data[(value & 0xff)*0x100]); // strides of 256 bytes
}
```
- now determine what data item was accessed based on what is now in the cache. For each potential value record how long it takes to access the data
- the value with the fastest delta time exposes the secret
	- this means its cached
	- as we are checking every 256 bytes, cache lines wont overlap so even if a cache miss happens it wont grab 64 bytes which contain the next index of the array

![[Determining the value of a byte.png]]### Instruction Pipeline and Branch Predicitoin
![[Instruction Pipeline and Branch Predicition.png]]
- This is a big optimization, if we can keep the pipeline full
- What about branches? unconditional and conditional
	- remember what we did last 4 times; like a cache
- HW keeps track if a conditional branch is or isn't taken, and keeps the pipeline full on where it believes the branch will go
- And if its predicition is wrong it stops executing the instruction in the pipeline
- no harm because it doesnt allow those instructions to complete, however Meldown exploited a side effect
### Putting it all together
1. teach the HW to predicit the branch (may not be necessary if the HW automatically does pipelining across branching
2. Flush the cache
3. "Trick" the HW to load the cache based on the secret value. But don't raise an exception now by having cond be FALSE
4. scan through memory to see what part of data was loaded into the cache
5. rinse and repeat
## Possible fixes
*Caches and Optimizations work great, except when they don't, and especially when they leak information*
1. remove cache, branch prediction, or pipelining
2. don't rely on protection but in the [[Page Table Entries]] to stop users from accessing kernel data, redo how the OS uses page tables.
3. Is AI currently capable of discovering security holes like meltdown on its own