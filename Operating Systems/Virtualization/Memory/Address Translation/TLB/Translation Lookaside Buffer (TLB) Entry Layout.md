# TLB Entry Layout
Each line in the TLB holds one cached address translation:

```
 ┌────────┬─────────────────┬───────┬───────┬──────────────┬─────────────────┐
 │  ASID  │       VPN       │ valid │ dirty │  prot bits   │       PFN       │
 └────────┴─────────────────┴───────┴───────┴──────────────┴─────────────────┘
    who       virtual page     is       was    r / w / x      physical frame
   owns it     to look up     this    written   permissions     to map to
                              valid?    to?
```

## field breakdown

| field | size | purpose |
|-------|------|---------|
| ASID | ~8 bits | identifies which process owns this entry — allows multiple processes to coexist without flushing |
| VPN | ~20 bits (varies) | the virtual page number being translated — used as the lookup key |
| valid | 1 bit | `1` = this entry holds a real translation, `0` = ignore it |
| dirty | 1 bit | `1` = page has been written to and must be written back before eviction |
| prot bits | 3 bits | read / write / execute permissions for this page |
| PFN | ~20 bits (varies) | the physical frame number — the result of the translation |

## how a lookup works
```
virtual address:
 ┌─────────────────┬──────────────┐
 │       VPN       │    offset    │
 └─────────────────┴──────────────┘
         │                │
         │ matched         │ passed through
         ▼                ▼
 ┌─────────────────┬──────────────┐
 │       PFN       │    offset    │  ← physical address
 └─────────────────┴──────────────┘
```

the offset bits are never translated — they pass straight through, since the page boundary is the same in both virtual and physical space
