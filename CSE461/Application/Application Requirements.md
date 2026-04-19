# CSE461: Application Requirements (Multimedia and Streaming)

![[Application Requirements.png]]

## Network Delay

Consider one direction of media transmission:
- A constant rate of media is generated at the source and later consumed at the receiver
- The network must have enough **bandwidth**, and adds a **delay**
- Network delay is variable:
	- **Message latency** + **queuing delay**
	- Variability in delay is called **jitter**

## Playout

Ideally, we want a fixed and small network delay for interactivity (emulating the telephone network):
- Media arrives at the receiver after variable network delay
- The **media arrival curve** determines the timeout in the playout buffer and the deadline

![[playout.png]]
![[Playout with variable media arrival.png]]

## Playout Buffer

A **playout buffer** at the receiver absorbs variable network delay:
- Stores incoming media and delays playback until the consumption time
- The media arrival curve determines time in the playout buffer and the deadline
- Pick the largest acceptable network delay to set the playout point

### Tradeoffs
- Larger acceptable network delay → larger buffer/more delay, less loss
- Smaller acceptable network delay → smaller buffer/less delay, more loss

![[Playout Buffer.png]]

## Streamed vs. Interactive Media

**Streamed media** is less demanding:
- Unidirectional
- Low delay is not essential; it affects startup but not interactivity
- Still needs to handle bandwidth and jitter

**Interactive media** is more demanding:
- Low delay is essential (e.g., VoIP, video calls)

### Handling Jitter
- Use a playout buffer
- Use high and low watermarks to control source overfill/underfill:
	- Start pulling media when the buffer level falls to the **low watermark**
	- Stop pulling media when the buffer level rises to the **high watermark**

![[High and Low water mark.png]]

## Handling Bandwidth

Send media in one of multiple encodings:
- Higher-quality encodings require more bandwidth
- Select the best encoding given the available bandwidth
- The server stores multiple compressed files; the client downloads and decompresses the best match

### Streaming: UDP or TCP?

- **UDP** minimizes message delay for interactive, real-time sessions
	- Used when late delivery is as bad as a dropped packet (e.g., VoIP)
- **TCP** is typically used for non-interactive streaming
	- Low delay is not essential (startup delay is acceptable)
	- Loss recovery simplifies presentation
	- HTTP/TCP passes through firewalls more easily
	- Use a playout buffer to store the next segment ahead of playback

## Related
- [[Multimedia - RTP, RTCP, and Playout Buffers]] — RTP/RTCP protocol details
- [[Transport Layer - Real-Time Transport (RTP and RTCP)]] — transport-layer details
- [[QoS and Admission Control - DiffServ and RSVP]] — network-level QoS mechanisms
- [[Transport Layer - Resource Allocation and QoS]] — fairness and queuing disciplines
