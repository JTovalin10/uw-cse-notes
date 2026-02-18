# where it operates
it has a network interface card that interacts with the link layer. However, the operating system takes care of the link layer. However, things that are delay sensitive, it is operated on the hardware layer

![[Screenshot 2026-01-21 at 1.16.54 PM.png]]# What is it
concerns how to transfer messages over one or more connected links
- messages are frames, of limited size
- builds on the physical layer
![[Screenshot 2026-01-20 at 4.15.42 PM.png]]
# Network-link-physical
![[Screenshot 2026-01-20 at 4.18.36 PM.png]]

## Textbook Notes

At its core, the link layer is how we transmit raw bits over a medium (wireless or wired). They both carry analog signals (continuous wavelength) while we want to transmit digital signals (0, 1 or discrete wavelength).

### Coding and Modulation
#### Simple Coding
[[Non-Return to Zero (NRZ)]]
[[Return to Zero (RZ)]]]
#### Additions
what we can do is create 4 levels for 4 bits per symbol. for example
lets say:
0 Hz = 00
100 Hz = 01
200 Hz = 10
300 Hz = 11
This allows us to have more bits per second

### Clock Recovery
[[Clock Recovery 4B5B]]