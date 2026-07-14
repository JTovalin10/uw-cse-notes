# CSE451: I/O System Hardware Environment

The I/O system's hardware environment consists of the devices themselves, the controllers that interface them to the rest of the system, the buses that carry data between them, and the physical characteristics that any I/O subsystem design must account for.

## I/O Devices

Devices are classified into two broad categories based on how they present data:
- **Block devices**: Store information in fixed-sized blocks, with typical sizes ranging from 128 to 4096 bytes. Disks are the canonical example — see [[Magnetic Disks]] and [[Flash Storage]].
- **Character devices**: Deliver or accept a stream of characters (bytes) rather than fixed-size chunks, such as a keyboard or serial port.

## Device Controllers

A **device controller** connects the physical device to the system bus. This is the model used in minicomputers and PCs, where a relatively simple controller chip bridges a single device (or a small number of devices) to the shared system bus.

Mainframes use a more complex model: instead of simple controllers on a shared bus, they employ multiple buses and specialized I/O computers (I/O channels) dedicated entirely to managing I/O traffic, offloading that work from the main CPU entirely.

## Communication

Once it's established whether a device is block or character-oriented, the remaining question is how the processor actually communicates with its controller. Two mechanisms are used:
- **Memory-mapped I/O / controller registers**: Device control and status registers are mapped into the processor's address space, so reading and writing to specific memory addresses corresponds to reading and writing device registers.
- **[[Organization of the IO Function#Direct Memory Access (DMA)|Direct Memory Access (DMA)]]**: A DMA controller moves data directly between the device and main memory, without requiring the CPU to shuttle each unit of data itself. See [[Organization of the IO Function]] for the full comparison against polling and interrupt-driven I/O.

## Bus Architecture

In older systems, a single bus connected the CPU, memory, and all I/O devices.

![[Single Bus.png]]

Today's systems use multiple buses instead, since a single shared bus becomes a bottleneck as more devices with varying speeds are attached.

![[Multi Bus.png]]

## Characteristics the I/O System Must Consider

Because I/O devices vary enormously, the I/O system's design has to account for several device characteristics:

1. **Data rate**: May vary by several orders of magnitude between devices (e.g., a keyboard vs. an SSD).
2. **Complexity of control**: Whether a device is used exclusively by one process or shared among many.
3. **Unit of transfer**: Stream of bytes vs. block-I/O, as described above.
4. **Data representation**: Character encoding, error codes, and parity conventions differ by device.
5. **Error conditions**: The consequences of an error and the range of possible responses differ by device (e.g., a disk read error vs. a dropped network packet).
6. **Applications**: The characteristics above ultimately impact resource scheduling and buffering schemes the OS must implement for that device.

## Related
- [[Organization of the IO Function]] — how the processor and I/O controllers actually coordinate (polling, interrupts, DMA)
- [[Magnetic Disks]] — a canonical block device
- [[Flash Storage]] — another canonical block device
- [[Persistent Storage]] — the broader storage stack this hardware sits underneath

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| I/O channels | Channel controllers / I/O processors (mainframe terminology) |
| Device controller | Host bus adapter (HBA) / controller chip |
