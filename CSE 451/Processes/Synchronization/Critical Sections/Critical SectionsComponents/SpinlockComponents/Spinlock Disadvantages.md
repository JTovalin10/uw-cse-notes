## Disadvantages
- wastes CPU cycles ([[Busy-Waiting]])
- not fair - no guarantee of ordering
- bad for long critical sections
- cache line bouncing on multiprocessors
- the OS can deschedule the thread holding the spinlock which does not release the lock. So all other procs are spinning and waiting for a thread that isnt even running