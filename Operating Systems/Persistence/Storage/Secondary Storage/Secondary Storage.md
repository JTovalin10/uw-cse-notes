# CSE451: Secondary Storage

## What Is It

**Secondary storage** is anything outside of "primary memory" (RAM). It does not permit direct execution of instructions or data retrieval via machine load/store instructions the way RAM does — the CPU cannot directly address secondary storage; data must first be transferred into RAM before the CPU can operate on it. Common examples include disk, Flash, tape, and persistent memory. Secondary storage is usually independent of the file system, although there may be cooperation between the two (e.g., the file system can pass locality hints down to the storage layer).

## Characteristics

- **Persistent**: Data survives power loss, unlike RAM's volatile contents.
- **Slow**: Access times are on the order of milliseconds (vs. nanoseconds for RAM) — a difference of roughly six orders of magnitude, which is why the OS goes to great lengths (caching, buffering, scheduling) to minimize the number of secondary storage accesses on the critical path.
- **Occasionally fails**: Requires error handling, since secondary storage devices are mechanical or have limited write endurance and cannot be assumed to always succeed.
- Device types: [[HDD]], [[SSD]] (see [[Magnetic Disks]] and [[Flash Storage]] for full mechanics).

## Disk Routines (Storage Layer)

Routines that interact with disks are typically implemented at a very low level in the OS, beneath the file system:
- Used by many components (file system, virtual memory, etc.) — any part of the OS that needs to move data to or from persistent storage goes through this layer.
- Handle scheduling of disk operations, head movement, error handling, and management of free space on disks.
- File system knowledge of device details can help optimize performance (e.g., placing related files close together on disk to exploit locality and minimize seeks) — this is why the file system and storage layer, while conceptually independent, benefit from cooperating.

## Related

- [[HDD]] — hard disk drives
- [[SSD]] — solid-state drives
- [[Magnetic Disks]] — full HDD mechanics
- [[Flash Storage]] — full SSD mechanics
- [[Disk Drives]] — HDD vs SSD comparison
- [[File Systems]] — abstraction built on top of secondary storage
- [[Persistent Storage]] — the broader persistent storage stack this fits into

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| Secondary storage | Secondary storage / persistent storage / disk storage |
| Disk routines | Block layer / storage stack |

