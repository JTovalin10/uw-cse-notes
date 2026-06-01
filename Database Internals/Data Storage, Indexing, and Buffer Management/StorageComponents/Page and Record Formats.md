# Data Storage: Page and Record Formats

## Page Format

A **page** holds records and is the unit of I/O between disk and memory.

- **Record Id (RID)**: a pointer to a specific tuple on disk
  - Typically `RID = (pageId, slotNumber)`
  - Used by indexes and transaction logs to reference tuples
- Tuples are **fixed size** at the page level (e.g., `CHAR(100)` pads to 100 bytes even if shorter)
- Records can be **fixed-length** or **variable-length**

### Approach 1: Fixed-Length Records (Packed)
- Divide the page into fixed-size slots; each slot holds one tuple
- `RID = (PageID, SlotNumber)`
- **Adding a tuple**: find free space and claim it; update N (tuple count)
- **Deleting a tuple**: difficult — records cannot be moved because RIDs contain the slot number; also cannot handle variable-length tuples

![[Page Format Approach 1.png]]

### Approach 2: Slot Directory (Slotted Pages)
A **Slotted Page** is the standard way to organize records within a page.
- Sacrifice a small amount of space for a **slot directory** in the page header.
- The slot directory stores `(offset, length)` pairs — fixed-size entries pointing into the page body.
- **Decoupling**: The record's physical position can change (e.g., during compaction to reclaim space) while its **Record ID (RID)**—which points to the slot index—stays constant. This prevents index pointers from breaking when data moves within a page.
- Supports variable-length records cleanly.
- The slot directory grows right-to-left, while records grow left-to-right.

![[Page Format Approach 2.png]]

---

## Record Formats

### Fixed-Length Records
- Each field has a fixed, predetermined length
- The same byte length is used for every record in the relation
- Simple to navigate: field offset = sum of preceding field lengths

![[Record Formats.png]]

### Variable-Length Records
- Fields like `VARCHAR` can differ in length across records
- Requires storing offsets or delimiters to locate each field within a record

![[Variable length records.png]]
