# When a process is created
1.  OS allocates a proc for it
2. OS initializes proc
3.  (OS does other things not related to proc)
4. OS puts proc on the correct queue

# As a process computes
OS moves its proc from queue to queue
- [[State Queues]]

# When a process is terminated
- proc may be retained for a while (to receive signals, etc)
- eventually, OS deallocates proc
