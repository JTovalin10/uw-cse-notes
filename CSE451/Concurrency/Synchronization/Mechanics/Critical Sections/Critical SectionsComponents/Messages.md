# Messages
a synchronization model based on atomic transfer of data across a channel

direct application to distributed systems where shared memory is not available

## Basic Operations
```c
send(destination, message)
receive(source, message)
```

## Synchronization Semantics
### Blocking (Synchronous)
- **Blocking send**: sender waits until message is received
- **Blocking receive**: receiver waits until message arrives
- creates a synchronization point (rendezvous)

### Non-blocking (Asynchronous)
- **Non-blocking send**: sender continues immediately (message buffered)
- **Non-blocking receive**: returns immediately with message or indication of no message

## Addressing
### Direct Communication
- processes explicitly name each other
```c
send(P, message)    // send to process P
receive(Q, message) // receive from process Q
```

### Indirect Communication (Mailboxes/Ports)
- messages sent to/received from mailboxes
```c
send(mailbox_A, message)
receive(mailbox_A, message)
```

## Implementing Mutual Exclusion with Messages
```c
// Using a token-passing approach
void process(int id) {
    while (true) {
        receive(token);      // wait for permission
        // critical section
        send(next, token);   // pass permission
        // remainder section
    }
}
```

## Advantages
- natural for distributed systems
- no shared memory required
- explicit communication makes data flow visible
- can be easier to reason about

## Disadvantages
- overhead of copying messages
- more complex for simple mutual exclusion
- buffering and flow control issues
- message ordering can be tricky

## Examples
- Unix pipes
- TCP/IP sockets
- MPI (Message Passing Interface)
- Go channels
- Erlang processes

## Related
- [[Critical Sections]]
- [[Semaphores]]
