Ethernet is mainly used in campus networks and data centers and is more formally known as **CSMA/CD** (Carrier Sense, Multi-Access with Collision Detection).

Ethernet is a multi-access network where a set of nodes sends and receives frames over a shared link.
- **Carrier Sense**: all nodes can distinguish between an idle and busy link.
- **Collision Detect**: a node listens as it transmits and can therefore detect when its frame has collided with a frame transmitted by another node.

## Physical Properties

- **Transceiver**: a small device directly attached to the tap. It detects when the line is idle and drives the signal when the host is transmitting. It also receives incoming signals. The transceiver connects to an Ethernet adaptor plugged into the host.

![[Pasted image 20260208021152.png]]

- **Repeaters**: a device that forwards digital signals, like an amplifier. No more than four repeaters could be positioned between any pair of hosts.

![[Pasted image 20260208021250.png]]

- **Terminators**: placed at the ends of the cable, they absorb the signal and prevent it from bouncing back and interfering with trailing signals.
- **Collision domain**: all hosts competing for access to the same link. The multi-access part of Ethernet is all about dealing with the competition that arises in a collision domain.

## Access Protocol

The algorithm used to control access to a shared Ethernet link is **Media Access Control (MAC)**. It is typically implemented in hardware on the network adaptor.

### Frame Format

- **64-bit preamble** allowing the receiver to synchronize with the signal.
- **Destination and source addresses**, each 48 bits.
- **Packet type field** (demultiplexing key). Each frame carries up to 1500 bytes and at minimum 46 bytes of data.
	- The minimum exists so that collisions can always be detected.
- **32-bit CRC** for error detection.
- From the host's perspective, an Ethernet frame has a 14-byte header. The sending adaptor attaches the preamble and CRC before transmitting, and the receiving adaptor removes them.

![[Pasted image 20260208021927.png]]

### Addresses

Addresses are burned into ROM. To ensure uniqueness, manufacturers of Ethernet devices are assigned different prefixes, so every address they produce is globally unique.

Every frame transmitted on an Ethernet is received by every adaptor connected to that Ethernet. Each adaptor checks the destination address and passes only matching frames to the host.

- **Promiscuous mode** — delivers all received frames to the host.
- **Unicast** — passes only frames addressed to this adaptor's own address.
- **Broadcast** — an Ethernet address consisting of all 1s.
- **Multicast** — an address with the first bit set to 1 that is not the broadcast address.

Every Ethernet adaptor receives all frames and accepts:
- Frames addressed to its own address
- Frames addressed to the broadcast address
- Frames addressed to a multicast address, if it has been instructed to listen to that address
- All frames, if it has been placed in promiscuous mode

It passes to the host only the frames that it accepts.

### Transmitter Algorithm

When the adaptor has a frame to send:
1. **Line idle** — transmit immediately. The 1500-byte upper bound ensures no single adaptor can monopolize the link.
2. **Line busy** — wait for idle, then transmit immediately (after a mandatory 9.6 µs inter-frame gap). This makes Ethernet a **1-persistent** protocol (transmit with probability 1 when the line goes idle).

> A **p-persistent** protocol transmits with probability *p* and defers with probability *1 − p*. Lower *p* reduces the chance of simultaneous transmissions when multiple adaptors are waiting, but Ethernet's 1-persistent approach has proven effective in practice.

**Collision handling:**
- When two or more frames collide, each sender transmits a **32-bit jamming sequence** then stops. The minimum transmission in a collision is therefore 96 bits (64-bit preamble + 32-bit jam), sometimes called a **runt frame**.
- The worst-case detection delay occurs when two hosts are at opposite ends of the network; this is why every Ethernet frame must be at least **512 bits (64 bytes)** and the maximum cable length is **2500 m**.

**Exponential backoff:**
- After a collision the adaptor picks a random *k* in `[0, 2^n − 1]` and waits *k × 51.2 µs*, where *n* is the number of collisions so far.
- *n* is capped (typically at 10), and the adaptor gives up after 16 failed attempts and reports a transmit error to the host.

![[Pasted image 20260208022712.png]]

### Longevity of Ethernet

Ethernet has endured because of two key advantages:
1. **Simple administration** — no routing or configuration tables to maintain; adding a new host is trivial.
2. **Low cost** — cable/fiber is cheap, and the only per-host cost is the network adaptor.

These factors made Ethernet deeply entrenched. Switch-based Ethernet eventually replaced multi-access Ethernet, largely because it could be **deployed incrementally**: some hosts connected via point-to-point links to switches while others remained on shared coax with repeaters or hubs, all while retaining the same simple administration model.
