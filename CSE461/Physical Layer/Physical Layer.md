# Physical Layer
The physical layer is the lowest layer of the network stack, responsible for transmitting raw bits over a communication [[Performance/Link|link]].

## Core Question
How can we send information across a link?

## Key Topics

### [[Media/Media|Media]]
The physical medium that propagates signals carrying bits of information:
- [[Media/Wires|Wires]] - Twisted pair, coaxial cable
- [[Media/Fiber|Fiber]] - Fiber optic cables
- [[Media/Wireless|Wireless]] - Radio, microwave, infrared
- [[Media/Signals over Fiber|Signals over Fiber]] - Wavelength Division Multiplexing
- [[Media/Wired Wireless Perspective|Wired vs Wireless]] - Design considerations

### [[Performance/Simple Link Model|Performance]]
Key metrics for characterizing links:
- [[Performance/Rate|Rate]] - Bandwidth/capacity in bits/sec
- [[Performance/Delay|Delay]] - Propagation time in seconds
- [[Performance/Message Latency|Message Latency]] - Total time = transmission + propagation delay
- [[Performance/Bandwidth-Delay (BD) Product|Bandwidth-Delay Product]] - Data "in flight"
- [[Performance/Link|Link]] - Channel connecting nodes

### [[Signals/Signal|Signals]]
Understanding signals and channel capacity:
- [[Signals/Signal|Signal]] - Frequency representation of signals
- [[Signals/Nyquist Limit|Nyquist Limit]] - Max rate for noiseless channels
- [[Signals/Shannon Capacity|Shannon Capacity]] - Max rate for noisy channels (practical limit)

### [[Encoding/Modulation vs Coding|Encoding]]
Converting bits to signals:
- [[Encoding/Simple Rate Model|Simple Rate Model]] - Clock recovery, 4B/5B encoding
- [[Encoding/Modulation vs Coding|Modulation vs Coding]] - Baseband vs passband
- [[Encoding/Modulation|Modulation]] - Amplitude, frequency, phase modulation
