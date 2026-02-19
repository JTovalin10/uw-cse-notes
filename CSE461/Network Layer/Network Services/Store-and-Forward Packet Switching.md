Both [[Virtual Circuit Switching]] and [[Datagrams]] are built from this.

A switch receives a **complete packet**, storing it temporarily if necessary, before forwarding it onward. [[Statistical Multiplexing]] is used to share [[Link]] bandwidth over time.

## Buffering

Each switching element has internal buffers to handle contention:
- Input and output buffers
- ![[Pasted image 20260218183207.png]]
- Buffer is typically a FIFO queue
- If the buffer is full, packets are discarded
![[Pasted image 20260218183346.png]]


## Why Store First

- The switch needs the full header before it can make a forwarding decision
- Buffering also absorbs bursts — if the output port is temporarily busy, the packet waits in the queue rather than being dropped immediately

## Tradeoff

Storing the full packet adds **queuing delay** proportional to packet size and link speed. Very large packets on slow links can cause significant delay for subsequent packets waiting in the queue.

See also: [[Datagrams]], [[Virtual Circuit Switching]], [[Statistical Multiplexing]]
