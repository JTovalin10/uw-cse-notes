# Transport: Socket Errors and Resets

### Formal Definition
A **TCP Reset (RST)** is a signal used to abruptly terminate a connection, indicating that the sender has no record of the connection or refuses to accept further data. In POSIX programming, writing to such a socket results in **SIGPIPE** or **EPIPE**.

### Simplified Explanation
It’s like someone hanging up the phone without saying goodbye. If you try to keep talking to the dead air, the system stops you.

---

## 1. TCP Reset (RST)
The `RST` bit is set in the TCP header when:
- **Non-existent port**: A packet arrives at a port where no process is listening.
- **Connection Loss**: One side crashes and loses its TCB (Transmission Control Block) state.
- **Firewalls/Middleboxes**: A security appliance decides to terminate a flow.
- **Application Abortion**: An application calls `close()` with `SO_LINGER` set to 0, forcing an immediate teardown instead of the standard 4-way FIN handshake.

## 2. SIGPIPE and EPIPE
When a process attempts to `write()` to a socket that has received an RST:
1. **The First Write**: The kernel may return the number of bytes written, but it triggers an RST response from the peer (if not already received).
2. **The Second Write**: The kernel generates a **SIGPIPE** signal.
   - **Default Action**: The process is terminated immediately.
   - **Handling**: Applications can catch the signal or use `signal(SIGPIPE, SIG_IGN)` to ignore it.
3. **EPIPE Error**: If SIGPIPE is ignored, the `write()` or `send()` call returns `-1` and sets `errno` to `EPIPE` (Broken pipe).

## 3. MSG_NOSIGNAL
To avoid the complexity of signals in multi-threaded environments, Linux provides the `MSG_NOSIGNAL` flag for `send()` and `sendto()`.
- **Function**: Suppresses the generation of `SIGPIPE`.
- **Result**: The call returns `-1` with `EPIPE` immediately, allowing for local error handling.

## 4. Comparison Table: FIN vs RST
| Feature | FIN (Standard Close) | RST (Abrupt Reset) |
| :--- | :--- | :--- |
| **Workflow** | 4-way handshake (Graceful) | Immediate (Violent) |
| **Data Integrity** | All data in flight is acknowledged | Pending data is discarded |
| **Socket State** | Moves to `FIN_WAIT_1` / `CLOSE_WAIT` | Moves immediately to `CLOSED` |
| **Usage** | Normal termination | Error recovery / Security |

### Related
- [[CSE461/Transport/Transport Layer - Transmission Control Protocol (TCP)]]
- [[CSE461/Linux/Networking Debugging#strace]]
