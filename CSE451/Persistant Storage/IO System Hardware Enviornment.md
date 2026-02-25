## Hardware
### I/O Devices
- block devices: stores information in fixed-sized blocks; typical sizes: 128-4096 bytes
- character devices: devices -- delivers/accepts stream of characters (bytes)
### Device Controllers:
- connects physical device to system bus (Minicomputers, PCs)
- mainframes use a more complex model:
	- multiple buses and specialized I/O computers (I/O channels)
### Communication
We know if it is a block or character device but how do they communicate
- memory-mapped I/O, controller registers
- direct memory access - DMA

## Bus
in older systems
 we had a single bus
![[Single Bus.png]]
today, we have a multiple bus
![[Multi Bus.png]]
## Characteristics
I/O system has to consider device characteristics
1. data rate
	1. may vary by several orders of magnitude
2. complexity of control
	1. exclusive vs shared device
3. unit of transfer
	1. stream of bytes vs block-I/O
4. data representation
	1. character encoding, error codes, parity conventions
5. error conditions
	1. consequences, range of responses
6. applications:
	1. impact on resource scheduling, buffering schemes