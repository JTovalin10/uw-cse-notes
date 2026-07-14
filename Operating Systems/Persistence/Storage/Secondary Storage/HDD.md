# CSE451: HDD

A **Hard Disk Drive (HDD)** uses moving disks (platters) to write data magnetically. See [[Magnetic Disks]] for the full mechanics of platters, spindles, arms, heads, tracks, and sectors.

## Performance

Performance suffers because an HDD has mechanically moving parts: the arm must physically move to the correct track (seek time), and the platter must rotate the target sector under the head (rotational latency) before any data can actually be transferred.

- Performance can be improved by limiting the amount of seeking needed to read or write data — this is why sequential I/O vastly outperforms random I/O on an HDD, and why the OS uses disk scheduling algorithms (FCFS, SSTF, SCAN/ELEVATOR) to reorder pending requests and minimize total seek distance.
- **[[Defragmentation and TRIM operations|Defragmentation]]** helps improve performance by keeping each file's blocks physically contiguous on disk, reducing the number of seeks needed to read that file.

## Related
- [[Magnetic Disks]] — full mechanics and disk scheduling detail
- [[Disk Drives]] — HDD vs SSD comparison
- [[Secondary Storage]] — broader storage device context
- [[SSD]] — the electronic counterpart, useful for contrast

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| HDD | Hard disk drive / spinning disk / mechanical drive |

