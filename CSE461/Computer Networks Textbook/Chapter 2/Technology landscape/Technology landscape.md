## Intro
network operators build global networks that span hundreds or thousands of kilometers connecting large routers.

Users encounter links mostly as a way to connect  a computer to existing internet.

The links can be anywhere and wither wired or wireless
![[Pasted image 20260206191702.png]]
This illustration shows the variety of end users and the ways they connect to the rest of the internet. The links look alike because the network architecture provides a common abstraction so the device doesn't have to care what sort of link its connected to, just that it has a link to the internet.
## Link characteristics
- medium
	- copper wire
		- [[Twisted Pair]]
	- air/free space for wireless
- frequency (Hz)
	- the distance between pairs of adjacent maxima or minima - wavelength
	- wavelength = (light in medium) / frequency
## Complications
Electromagnetic waves span a range of frequencies however specific frequency bands are licensed for cellular networks. This makes things complicated as network operators have to support both legacy and new technologies which occupy different frequency bands. For example, old tech is 700-2400 MHz while new ones are at 6GHz

# Data
we encode binary data into the signal we are sending. However this is a complex issue that can be split into two layers:
1. modulation
	1. varying frequencies, amplitudes, or phase of the signal to effect the transmission of information
2. distance
	1. the medium, has a distance and bandwidth that information can travel
	2. known as last mile connections