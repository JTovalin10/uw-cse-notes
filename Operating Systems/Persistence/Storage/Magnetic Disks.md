# CSE451: Magnetic Disks (HDD)

**Hard Disk Drives (HDDs)** are the traditional form of secondary storage, using rotating magnetic platters and moving heads. Their entire performance profile is shaped by the fact that reading or writing data requires physically moving mechanical parts into position first.

## Mechanics

- **Platters**: Circular disks coated with magnetic material, on which data is stored as tiny magnetized regions.
- **Spindle**: Rotates the platters at a constant speed (common speeds: 5400, 7200, 10000, 15000 RPM).
- **Arm and Head**: The arm moves the read/write head radially across the surface of the platters to position it over the desired track; the head itself senses (reads) or induces (writes) the magnetic state of the platter surface as it passes beneath.
- **Tracks and Sectors**: Each platter is divided into concentric tracks, and each track is further divided into sectors (traditionally 512 bytes, now often 4KB) — the sector is the smallest addressable unit of storage on the disk.

## Performance Characteristics

Because reading or writing any given sector requires physically positioning the arm and waiting for the platter to rotate into place, HDD performance is dominated by three sequential mechanical delays:

1. **Seek Time**: Time for the arm to move to the correct track. This is the most expensive part of a disk access, since it involves physically accelerating and decelerating the arm across the platter's radius.
2. **Rotational Latency**: Time for the desired sector to rotate under the head once the arm has reached the correct track. On average, this is half the time of one full rotation, since the desired sector could be anywhere along the track relative to the head's current position.
3. **Transfer Time**: Time to actually read/write the bits as they pass under the head, once both the correct track and the correct sector have been reached.

Because seek time and rotational latency are both paid once per access regardless of how much data is transferred, **sequential I/O is much faster than random I/O**: a sequential read pays the seek and rotational cost once and then streams data continuously, while random I/O pays both costs again for essentially every access.

## Disk Scheduling

Since seek time is the dominant cost, the OS attempts to minimize total seek distance by reordering pending I/O requests before dispatching them to the disk, rather than servicing them strictly in the order they arrived:

- **FCFS** (First-Come, First-Served): Services requests in arrival order. Simple but inefficient, since it ignores the physical location of each request relative to the arm's current position, potentially causing large unnecessary seeks.
- **SSTF** (Shortest Seek Time First): Always services whichever pending request is physically closest to the arm's current position. This minimizes seek distance in the short term but can cause starvation of requests that are physically far from the arm if closer requests keep arriving.
- **SCAN / ELEVATOR**: Moves the arm from one end of the disk to the other and back, servicing requests along the way (like an elevator servicing floor requests in one direction before reversing) — this bounds the worst-case wait for any given request while still exploiting locality.

## Maintenance

- **[[Defragmentation and TRIM operations|Defragmentation]]**: Reorganizing files to be contiguous on disk, which reduces the number of seeks required to read a single file, directly improving sequential access performance.

## Related
- [[HDD]] — brief HDD summary
- [[Secondary Storage]] — broader storage device context
- [[Defragmentation and TRIM operations]] — how fragmentation is fixed to maintain performance
- [[Flash Storage]] — the electronic SSD counterpart, useful for contrast
- [[Introduction to Data Management/Database Design/Disk Storage|Disk Storage (Database context)]] — how databases account for these same mechanical costs when costing query execution (see [[Introduction to Data Management/Query Execution/External Memory Algorithms|External Memory Algorithms]] for how this feeds into query costing)

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| SCAN / ELEVATOR | Elevator algorithm / LOOK scheduling |
| SSTF | Shortest Seek Time First (also standard industry term) |

