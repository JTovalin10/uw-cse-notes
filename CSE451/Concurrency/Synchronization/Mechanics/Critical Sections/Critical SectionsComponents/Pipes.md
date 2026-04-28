# Pipes

Pipes are a classic Unix mechanism for **Inter-Process Communication (IPC)**, allowing the output of one process to serve as the input for another.

## Low-Level Representation: `struct pipe`

In the kernel, a pipe is represented as a **Circular Buffer** (typically 4KB to 64KB) in memory.

### Key Fields in the Kernel Structure:
1.  **`buffer`**: A pointer to the memory page(s) allocated for the data.
2.  **`head`**: Index/offset for the next byte to be written.
3.  **`tail`**: Index/offset for the next byte to be read.
4.  **`lock` (Mutex)**: A kernel lock that ensures only one process (reader or writer) can modify the pipe's metadata at a time, preventing race conditions.
5.  **`wait_queues`**: 
    - **Reader Wait Queue**: Processes that tried to read from an empty pipe.
    - **Writer Wait Queue**: Processes that tried to write to a full pipe.

## Synchronization Logic
The kernel manages synchronization between readers and writers transparently:

-   **Empty Pipe**: If a process attempts to read from a pipe with no data (`head == tail`), it is placed on the **Reader Wait Queue** and put to **Sleep**.
-   **Full Pipe**: If a process attempts to write to a pipe that is full, it is placed on the **Writer Wait Queue** and put to **Sleep**.
-   **Wakeup Mechanism**:
    -   When a writer adds data to the pipe, it triggers a wakeup for any processes on the Reader Wait Queue.
    -   When a reader removes data from the pipe, it triggers a wakeup for any processes on the Writer Wait Queue.

## The EOF Mechanic
A reader receives an **EOF (End of File)** (return value 0 from `read()`) only when **all** file descriptors pointing to the "write end" of the pipe have been closed. 
- **Interview Tip**: If a child process is reading from a pipe and the parent (writer) forget to close its own copy of the read end, or if the child forgets to close its own copy of the write end, the reader may hang forever waiting for more data.

## Shared Memory vs. Pipes
-   **Pipes**: Involve data copying (User Space -> Kernel Buffer -> User Space). Slower but provide built-in synchronization.
-   **Shared Memory**: Zero-copy (Direct access to physical frames). Fastest but requires manual synchronization (Mutexes/Semaphores).
