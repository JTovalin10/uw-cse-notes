# what is it
a lock is a memory object with two opeations
```c
acquire() // obtain the right to enter the critical section
release() // give up the right to be in the critical section
```
Note: acquire prevents progress of the thread until the lock can be acquired
![[Pasted image 20260117081754.png]]

references:
[[Critical Sections]]
