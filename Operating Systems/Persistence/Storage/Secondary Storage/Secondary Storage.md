# Secondary Storage

## What is it

- Anything outside of "primary memory" (RAM)
- Does not permit direct execution of instructions or data retrieval via machine load/store instructions
- Disk, Flash, tape, persistent memory
- Usually independent of file system (although there may be cooperation)

## Characteristics

- **Persistent** — data survives power loss
- **Slow** — milliseconds to access (vs nanoseconds for RAM)
- **Occasionally fails** — requires error handling
- Device types: [[HDD]], [[SSD]]

## Disk routines (storage layer)

Routines that interact with disks are typically at a very low level in the OS:
- Used by many components (file system, VM, etc.)
- Handle scheduling of disk operations, head movement, error handling, and management of space on disks
- File system knowledge of device details can help optimize performance (e.g., place related files close together on disk)

## Related

- [[HDD]] — hard disk drives
- [[SSD]] — solid-state drives
- [[File Systems]] — abstraction built on top of secondary storage
