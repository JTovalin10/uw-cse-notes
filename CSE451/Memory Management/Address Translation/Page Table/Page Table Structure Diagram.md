# Page Table Structure Diagram

A page table is an **array** indexed by virtual page number (VPN). Each row is a **Page Table Entry (PTE)**.

## Layout

```
Virtual Page Number (VPN)
         │
         ▼
┌─────┬──────────────────────────────────────────────────────────┐
│ VPN │                  Page Table Entry (PTE)                  │
├─────┼──────────┬────────┬─────────┬───────┬──────┬────────────┤
│     │   PFN    │ Valid  │ Present │ Dirty │ Accsd│  Protect   │
├─────┼──────────┼────────┼─────────┼───────┼──────┼────────────┤
│  0  │ 0x0A3F2  │   1    │    1    │   0   │  1   │  R / X     │
│  1  │ 0x00000  │   0    │    0    │   0   │  0   │  ---       │  ← invalid (segfault if accessed)
│  2  │ 0x1B8C0  │   1    │    0    │   1   │  0   │  R / W     │  ← swapped to disk (page fault)
│  3  │ 0x0F1A4  │   1    │    1    │   1   │  1   │  R / W     │
│  4  │ 0x00000  │   0    │    0    │   0   │  0   │  ---       │  ← invalid
│ ... │   ...    │  ...   │   ...   │  ...  │ ...  │   ...      │
└─────┴──────────┴────────┴─────────┴───────┴──────┴────────────┘
         │
         └──► Physical Frame Number → combined with page offset
              gives the full physical address
```

## What each column means

| Field      | Bits | Meaning |
|------------|------|---------|
| **PFN**    | 20+  | Physical frame number — where in RAM this page lives |
| **Valid**  | 1    | 1 = this virtual page is mapped; 0 = segfault on access |
| **Present**| 1    | 1 = page is in RAM; 0 = swapped to disk → page fault |
| **Dirty**  | 1    | 1 = page was written to; must be saved back to disk on eviction |
| **Accessed**| 1   | 1 = page was recently read; used by replacement policy |
| **Protect**| 2–3  | R/W/X permission bits; violation → segfault |

## Address translation using the table

```
Virtual Address
┌──────────────────┬──────────────┐
│  Virtual Page #  │  Page Offset │
│     (VPN)        │   (lower k   │
│   (upper bits)   │    bits)     │
└────────┬─────────┴──────┬───────┘
         │                │
         │ index into     │ passed through
         │ page table     │ unchanged
         ▼                │
    ┌─────────┐           │
    │   PTE   │           │
    │  PFN    │           │
    └────┬────┘           │
         │                │
         ▼                ▼
┌──────────────────┬──────────────┐
│  Physical Frame  │  Page Offset │
│    Number (PFN)  │              │
└──────────────────┴──────────────┘
         Physical Address
```

## See also
- [[Page Table Entry Anatomy]]
- [[Page Table Translation Steps]]
- [[Virtual Address Parts]]
