# Magnetic Disks (HDD)

Hard Disk Drives (HDDs) are the traditional form of secondary storage, using rotating magnetic platters and moving heads.

## Mechanics
- **Platters**: Circular disks coated with magnetic material.
- **Spindle**: Rotates the platters (common speeds: 5400, 7200, 10000, 15000 RPM).
- **Arm and Head**: The arm moves the read/write head across the surface of the platters.
- **Tracks and Sectors**: Each platter is divided into concentric tracks, and each track is divided into sectors (traditionally 512 bytes, now often 4KB).

## Performance Characteristics
Performance is dominated by mechanical delays:
1.  **Seek Time**: Time for the arm to move to the correct track. This is the most expensive part of a disk access.
2.  **Rotational Latency**: Time for the desired sector to rotate under the head. On average, this is half the time of one rotation.
3.  **Transfer Time**: Time to actually read/write the bits as they pass under the head.

**Sequential I/O is much faster than Random I/O** because it minimizes seeking and rotational latency.

## Disk Scheduling
The OS attempts to minimize seek times by ordering pending requests:
- **FCFS** (First-Come, First-Served): Simple but inefficient.
- **SSTF** (Shortest Seek Time First): Can cause starvation.
- **SCAN / ELEVATOR**: Moves the arm from one end of the disk to the other and back, servicing requests along the way.

## Maintenance
- **[[Defragmentation and TRIM operations|Defragmentation]]**: Reorganizing files to be contiguous on disk, which reduces seeking.

## Related
- [[HDD]] — summary of HDD specifics
- [[Secondary Storage]] — broader context
- [[Defragmentation and TRIM operations]] — how to maintain performance
- [[CSE344/Database Design/Disk Storage|Disk Storage (Database context)]]
