# Where is Page Table stored
The page table is stored in memory (RAM)
This creates a performance problem. To fetch one piece of data, the CPU actually has to do two memory lookups:
1. one lookup to read the page table (to find where the data is)
2. one lookup to read the actual data

## Solution
To fix this slowness, the CPU uses a fast hardware cache called TLB or [[Translation Lookaside Buffer (TLB)]] which remembers recent translations
