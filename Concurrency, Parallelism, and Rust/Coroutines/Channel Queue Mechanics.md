# Coroutines: Channel Queue Mechanics

## Channel Data Structure & Queue Mechanics
Each channel maintains internal wait queues for blocked routines:

```c
typedef struct Channel {
    Queue blocked_senders;    // FIFO queue of routines suspended waiting to send
    Queue blocked_receivers;  // FIFO queue of routines suspended waiting to receive
    bool has_terminated;      // True if the coroutine owning this channel has exited
    SendableData return_val;  // Cached terminal return value
} Channel;
```

### 1. `send(Channel* ch, SendableData data)`
When a coroutine invokes `send(ch, data)`:
- **Case A: Receiver Already Waiting**:
  If `ch->blocked_receivers` is not empty, a receiver is already suspended waiting for data:
  1. Dequeue the waiting receiver routine $R_{\text{recv}}$ from `ch->blocked_receivers`.
  2. Deliver `data` directly into $R_{\text{recv}}$'s payload slot (`R_recv->channel_data = data`).
  3. Enqueue $R_{\text{recv}}$ into `ready_q` so it can be scheduled to run.
  4. The sender does not need to block; it continues executing (or yields, depending on policy).
- **Case B: No Receiver Waiting**:
  If `ch->blocked_receivers` is empty, no routine is ready to consume the data:
  1. Store `data` in `current_routine->channel_data`.
  2. Enqueue `current_routine` into `ch->blocked_senders` using `yieldOnto(&ch->blocked_senders)`.
  3. Deschedule `current_routine`: dequeue the next ready coroutine from `ready_q` and call `routine_switch(next)`.

```c
void send(Channel* ch, SendableData data) {
    if (ch->blocked_receivers.empty()) {
        // No receiver waiting: record data in our control block and suspend
        current_routine->channel_data = data;
        yieldOnto(&ch->blocked_senders);
        // When routine_switch returns here, a receiver has consumed our data
    } else {
        // Receiver waiting: deliver data directly and wake the receiver
        Routine* r = ch->blocked_receivers.pop();
        r->channel_data = data;
        ready_q.push(r);
    }
}
```

### 2. `receive(Channel* ch)`
When a coroutine invokes `receive(ch)`:
- **Case A: Channel is Terminated / Coroutine Has Returned**:
  If `ch->has_terminated` is true:
  - The coroutine associated with this channel has exited and returned its final value.
  - Returns `ch->return_val` immediately without blocking.
- **Case B: Sender Already Waiting**:
  If `ch->blocked_senders` is not empty:
  1. Dequeue the waiting sender routine $R_{\text{send}}$ from `ch->blocked_senders`.
  2. Extract `data` from $R_{\text{send}} \to \text{channel\_data}$.
  3. Enqueue $R_{\text{send}}$ into `ready_q` so it can resume execution.
  4. Return `data` to the caller.
- **Case C: No Sender Waiting**:
  If `ch->blocked_senders` is empty:
  1. Suspend the calling routine onto the channel's wait queue via `yieldOnto(&ch->blocked_receivers)`.
  2. Deschedule `current_routine`: dequeue the next ready coroutine from `ready_q` and call `routine_switch(next)`.
  3. When awakened (by a future `send()`), retrieve the transferred message and return it.

```c
SendableData receive(Channel* ch) {
    // Fast-path: if the coroutine terminated, return cached latch result
    if (ch->has_terminated) {
        return ch->return_val;
    }

    if (ch->blocked_senders.empty()) {
        // No sender waiting: yield execution onto the channel's wait queue
        yieldOnto(&ch->blocked_receivers);
        
        // When routine_switch returns execution here, a matching send() has
        // popped us from blocked_receivers, written incoming data into
        // current_routine->channel_data, and placed us on ready_q.
        // Therefore, our payload is ready immediately:
        return current_routine->channel_data;
    } else {
        // Sender is waiting: rendezvous and consume its message
        Routine* r = ch->blocked_senders.pop();

        // Retrieve data stored by the sender in its Routine descriptor:
        SendableData data = r->channel_data;

        // Wake the blocked sender so it can continue execution
        ready_q.push(r);

        return data;
    }
}
```

### What Does `yieldOnto(Queue* q)` Do?
Standard `yield()` enqueues `current_routine` back onto the global `ready_q`. In contrast, `yieldOnto(Queue* q)`:
1. Enqueues `current_routine` into the specified waiting queue `q` (such as `ch->blocked_receivers` or `ch->blocked_senders`).
2. Dequeues the next runnable routine from the global `ready_q`.
3. Calls `routine_switch(next)` to transfer CPU execution.
4. When another routine eventually moves `current_routine` back to `ready_q` and the scheduler selects it, `routine_switch` returns directly into the instruction following `yieldOnto`.

## Industry Standard Terms

| Course Term | Industry / Standard Term |
| :--- | :--- |
| **`current_routine`** | Active Task Context Pointer / Thread Control Block (TCB) |
| **`Channel*`** | CSP Channel / Unbuffered Rendezvous Channel / Go Channel |

## Related

- [[Concurrency, Parallelism, and Rust/Coroutines|Coroutines]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Coroutines/Channels and Rendezvous Semantics|Channels and Rendezvous Semantics]] — CSP channels, causal consistency, and unbuffered rendezvous
- [[Concurrency, Parallelism, and Rust/Coroutines/Latching Return Values and Generators|Latching Return Values and Generators]] — Endless return streams
