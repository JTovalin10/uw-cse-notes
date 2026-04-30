# Data Storage: Heap File and LOBs

## Large Objects (LOB)

- **BLOB** (**Binary Large Object**): binary data (images, audio, video)
- **CLOB** (**Character Large Object**): large text data
- Supported by modern database systems
- Storage strategy: attempt to **cluster blocks** of the LOB together on disk to enable sequential reads

---

## Heap File Implementations

A **heap file** is an unordered collection of pages containing records. It is the simplest file organization.

![[Screenshots/Heap File Implementations.png]]
