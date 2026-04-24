# CSE 333: Concurrency Intro

**Concurrency** refers to a version of a program that executes multiple tasks simultaneously. It is essential for high-performance applications, especially those that are I/O bound.

## Motivation: I/O Latency
I/O operations are orders of magnitude slower than CPU operations (Jeff Dean's "Numbers Everyone Should Know"):
*   L1 cache reference: 0.5 ns
*   Main memory reference: 100 ns
*   Read 1 MB sequentially from network: 10,000,000 ns (10 ms)
*   Read 1 MB sequentially from disk: 30,000,000 ns (30 ms)

In a **sequential** implementation, the CPU sits idle (**blocked**) while waiting for I/O to complete. Concurrency allows the CPU to work on other tasks (like processing another query) while waiting for I/O.

## Concurrency vs. Parallelism
*   **Concurrency**: Multiple tasks are in progress at the same time (interleaved).
*   **Parallelism**: Multiple tasks are executing at the exact same physical time (requires multiple CPUs/cores).

## Concurrent Programming Styles
1.  **Threads**: Multiple threads of control within a single process.
2.  **Processes**: Forking multiple processes.
3.  **Asynchronous I/O**: Also known as **non-blocking I/O** or **event-driven programming**.

### Event-Driven Programming
The program is structured as an **event-loop**.
*   The program registers interest in data with the OS.
*   The OS delivers an event when data is ready.
*   The program "dispatches" the event to a handler.
*   **Advantages**: Avoids locks and race conditions; simple for GUIs.
*   **Disadvantages**: Can lead to complex, "jumbled" code (callback hell).
*   **Note**: You are the scheduler in event-driven code; tasks do not have their own stacks and must bundle state into "continuations".
