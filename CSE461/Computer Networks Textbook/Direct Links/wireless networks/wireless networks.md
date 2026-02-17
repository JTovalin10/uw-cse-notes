## How Wireless Differs from Wired

- **Bit errors** are a greater issue in wireless than wired links.
- **Power** is a concern since wireless is most often used by mobile devices with limited battery.
- Wireless is **inherently multi-access** — this is the central challenge for wireless networks.
	- Another issue is **eavesdropping**, since you cannot control who receives your signal.

## Basic Issues

1. Wireless connections share the same medium, so we want them to share it efficiently without interfering with each other.
	- We can reduce the reach of a frequency to a certain area by **reducing the power** of the transmitter.
2. **Spread spectrum** — the idea is to spread the signal over a wider frequency band to minimize the impact of interference from other devices. See [[Spread Spectrum]] for details.

## Wavelength

Different parts of the electromagnetic spectrum have different properties.

Wireless networks today have two different classes of endpoints:
1. **Mobile nodes** — devices that move around.
2. **Base stations** — no mobility but have a wired connection to the internet or other networks.

![[Pasted image 20260209160526.png]]

## Topics

- [[Spread Spectrum]] — frequency hopping and direct sequence techniques
- [[WiFi]] — 802.11 physical properties, collision avoidance, hidden/exposed node problems, distribution system, and frame format
- [[Bluetooth]] — personal area networks, piconets, and frequency-hopping TDM
