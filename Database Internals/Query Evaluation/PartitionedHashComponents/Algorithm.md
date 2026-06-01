# Partitioned Hash Join: The Algorithm

The algorithm consists of three main steps to partition and then join the data.

### Step 1: Hash S into M-1 buckets & Send to Disk
- **Goal**: Split relation $S$ into $k = M-1$ smaller files on disk.
- **The Process (Internal Shuffle)**:
    1.  **Load**: Read one page of $S$ from disk into the **1-page Input Buffer**.
    2.  **Scan & Hash**: The CPU iterates through every tuple in that Input Buffer and calculates $h_1(join\_key)$.
    3.  **Internal Copy**: Based on the hash (e.g., result is `3`), the CPU **copies** the tuple from the Input Buffer to **Output Buffer #3** in RAM.
    4.  **Flush**: When an Output Buffer hits the **Disk Page Size** (e.g., 8KB), its contents are written to a **new partition file** on disk (e.g., $S_3.dat$) and the buffer is reset to empty.
    5.  **Repeat**: Once the Input Buffer is fully scanned, load the next page of $S$ until finished.

### Step 2: Hash R into M-1 buckets & Send to Disk
- **Goal**: Split relation $R$ using the **exact same process and hash function ($h_1$)**.
- **Result**: Because we use the same $h_1$, matching tuples from $R$ and $S$ end up in the same numbered bucket (e.g., $R_3$ and $S_3$).

### Step 3: Join Buckets (Build & Match)
- **Memory Layout**: $M-2$ pages for the **Build Table**, 1 page for **Input (Probe)**, 1 page for **Output (Result)**.
- **The Process (The Bucket Loop)**:
    For each bucket pair $i$:
    1.  **Build**: **Read one partition of $R$ and create a hash table in memory using a different hash function ($h_2$)**. This partition ($R_i$) is **pinned** in the $M-2$ build pages until matching with $S_i$ is complete.
    2.  **Probe (Stream)**: Read the matching partition $S_i$ into the **1-page Input Buffer** one page at a time.
    3.  **Match**: Probe the **pinned** $R_i$ hash table with tuples from the current page of $S_i$. Matches are moved to the **1-page Output Buffer**.
    4.  **Flush**: When the Output Buffer becomes full (reaches the Disk Page Size), it is **flushed (written) to disk** and reset.
    5.  **Next Page**: Overwrite the input buffer with the next page of $S_i$ until $S_i$ is finished.
    6.  **Clear**: Clear RAM (unpin $R_i$) and move to the next bucket pair.
