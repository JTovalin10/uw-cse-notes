## Usage Pattern for Mutual Exclusion
```c
semaphore mutex = 1;

// Thread code
wait(&mutex);
// critical section
signal(&mutex);
```
