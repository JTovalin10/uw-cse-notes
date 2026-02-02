Also known as *producer/consumer problem*
# what is it
- there is a circular buffer in memory with N entries (slots)
- producer threads insert entries into it (one at a time)
- consumer threads remove entries from it (one at a time)
## Threads are concurrent
- so, we must synchronization constructs to control access to shared variables describing buffer state![[Screenshot 2026-01-20 at 3.43.23 PM.png]]
# Solution(s)
## Semaphores
using [[Semaphores]] (both binary and counting) fixes this
![[Screenshot 2026-01-20 at 3.45.27 PM.png]]
## Conditional Variables
![[Screenshot 2026-01-20 at 3.53.03 PM.png]]