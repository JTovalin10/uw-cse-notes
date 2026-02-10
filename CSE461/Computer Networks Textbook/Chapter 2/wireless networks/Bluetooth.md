Bluetooth is a convenient alternative to connecting two devices with a wire.

## Basics

- Operates in the **license-exempt band at 2.45 GHz**.
- Typical bandwidths around **1 to 3 Mbps** with a range of about **10 m**.
- Because the communicating devices typically belong to one individual or group, Bluetooth is sometimes categorized as a **Personal Area Network (PAN)**.

## Piconet

The basic Bluetooth network configuration is called a **piconet** and consists of a **master device** and up to **seven slave devices**.

![[Pasted image 20260209162026.png]]

## Spread Spectrum and Time Division

Since Bluetooth operates in a license-exempt band, it uses a **frequency-hopping** [[Spread Spectrum]] technique to deal with possible interference. It hops across **79 channels** (frequencies), using each for **625 microseconds** at a time. This provides a natural time slot for synchronous **time division multiplexing**.

- A frame takes up **1, 3, or 5 consecutive time slots**.
- Only the **master** can start transmitting in **odd-numbered** slots.
- A **slave** can start transmitting in an **even-numbered** slot — but only in response to a request from the master during the previous slot. This prevents contention between slave devices.

## Parked Devices

- A slave device can be **parked** — set to an inactive, low-power state.
- A parked device **cannot communicate** on the piconet; it can only be reactivated by the master.
- A piconet can have up to **255 parked devices** in addition to its active slave devices.
