# CSE344: Disk Storage

Understanding disk storage is essential for understanding why [[Database Indices|indices]] exist and how [[External Memory Algorithms|external memory algorithms]] are costed.

## Hard Disk Characteristics

**Mechanical characteristics:**
- Rotational speed: ~7200 RPM
- Number of platters: 1–30
- Number of tracks: ≤10,000
- Number of bytes/track: ~10^5

**Disk access characteristics:**
- **Disk latency** = time between a request and when data is in memory
	- Lower-bounded by seek time + rotational latency
	- **Seek time** = time for the head to reach the correct track (10ms–40ms)
	- **Rotational latency** = time for the platter to rotate to the correct sector (~5ms)
- Bandwidth: typically 40–80 MB/s

**How disk is organized:**
- Disk is organized in chunks called **pages** or **blocks**
- Data elements that are close together on disk are accessed together
	- An entire block is loaded into main memory at once

**Caching/Buffering:**
- Read an entire block into a section of main memory called the **cache**
	- When the same element is needed again, it is read from cache instead of going back to disk

## Representing Relations on Disk

[[Physical Data Independence|Physical data independence]] means there are many storage options:

| Format | Description |
|---|---|
| **Row-store** | Attributes of a single row are stored together; rows may be sorted or unsorted |
| **Column-store** | One file per column (e.g., one file with all flight IDs, one with all prices) |
| **Heap file** | File is unsorted |
| **Sequential file** | File is ordered by something, usually the primary key |

**Goals:**
- DBMS attempts to store table files in **contiguous chunks** on disk — sequential reads are far faster than random ones
- DBMS attempts to **minimize unnecessary copying** of table data into memory — load entire blocks at a time

## Querying Without Indices

Without indices, any query requires an $O(n)$ sequential scan over the entire table. This motivates [[Database Indices|index creation]].

## Related
- [[Database Indices]] — how indices speed up queries beyond a sequential scan
- [[Clustered and Unclustered Indices]] — how the physical ordering of data on disk relates to index type
- [[External Memory Algorithms]] — algorithms whose cost is measured in block I/Os
- [[Physical Design and Indices]] — the broader physical-design context this fits into
- [[CSE451/Persistent Storage/Magnetic Disks|CSE451 Magnetic Disks]] — OS-level view of HDD mechanics (seek, rotational latency, tracks, sectors)
- [[CSE451/Persistent Storage/Flash Storage|CSE451 Flash Storage]] — SSD characteristics that change the cost model
- [[CSE351/Cache/Spatial Locality|CSE351 Spatial Locality]] — why loading whole blocks at once pays off
- [[CSE351/Cache/Temporal locality|CSE351 Temporal Locality]] — why caching recently-read blocks pays off
