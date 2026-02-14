## Intro
Network operators build global networks spanning hundreds or thousands of kilometers connecting large routers. Users encounter links mostly as a way to connect a computer to the existing internet — wired or wireless.

![[Pasted image 20260206191702.png]]
This shows the variety of end users and how they connect. The network architecture provides a common abstraction so the device doesn't care what sort of link it's connected to, just that it has one.

## Link Characteristics
- **Medium** — copper wire ([[Twisted Pair]]), fiber, or air/free space (wireless)
- **Frequency (Hz)** — the distance between adjacent maxima/minima is the **wavelength**
	- wavelength = speed of light in medium / frequency

## Complications
Electromagnetic waves span a range of frequencies, but specific bands are **licensed** for cellular networks. Operators must support legacy and new technologies occupying different bands (e.g. old tech at 700–2400 MHz, new at 6 GHz).

# Data
We encode binary data into the signal being sent. This splits into two layers:
1. **Modulation** — varying frequency, amplitude, or phase of the signal to carry information
2. **Distance** — the medium limits how far and at what bandwidth information can travel (known as **last mile** connections)
