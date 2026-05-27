# CSE444: Snapshot Isolation

Snapshot Isolation (SI) is a multiversion concurrency control (MVCC) algorithm that provides each transaction with a consistent "frozen" view of the database. It is the industry standard for high-concurrency systems because it allows readers to execute without ever being blocked by writers.

---

## 1. The Core Concept: A Frozen View of the Past
The fundamental rule of SI is that a transaction $T$ always sees the database exactly as it looked at the moment $T$ began. 
- **Isolation**: $T$ is isolated from any changes committed by other transactions after its start time.
- **No Blocking**: Because $T$ reads a "snapshot" of the past, it never has to wait for locks. If someone is currently writing to a record, $T$ simply reads the old version.
- **First-Committer-Wins**: While reads are free, writes are restricted. If two transactions try to update the same record, the first one to commit succeeds, and the other is forced to abort.

---

## 2. The Transaction Lifecycle (Mechanism & Timeline)

SI performs its checks non-sequentially throughout the transaction life cycle.

### Phase 1: The Start (Timestamping)
When transaction $T$ starts, it is assigned a unique Start Timestamp ($TS_{start}(T)$).
- This timestamp defines the **scope of visibility**. $T$ only sees data committed *before* this moment.

### Phase 2: Execution (Ongoing Reads & Drafting)
During its execution, $T$ interleaves reading data and preparing changes:
- **The Read Rule**: Whenever $T$ reads $X$, the DBMS finds the **most recent committed version** of $X$ that existed at $TS_{start}(T)$.
- **Drafting Writes**: When $T$ writes to $X$, it records the change in its **private buffer**. No physical changes are made to the database yet.
- *Note*: If $T$ reads a value it just wrote, it sees its own private draft, not the snapshot value.

### Phase 3: The Commit (The Final Gate)
The actual **First-Committer-Wins** check happens only when $T$ attempts to finish:
- **The Conflict Check**: The DBMS looks at the history of the database from $TS_{start}(T)$ to "Now." 
- **Validation**: If any other transaction $U$ committed a change to $X$ during this window, $T$ is **aborted**. 
- **Finality**: If no conflicts are found, $T$ is assigned a finish timestamp and its buffered changes are made permanent.

### Summary of Sequence
| Phase | Action | Purpose |
| :--- | :--- | :--- |
| **Start** | Set $TS_{start}$ | Define the "past" we are looking at. |
| **Execution** | Apply Read Rule | Get a consistent view of data (Never blocks). |
| **Execution** | Buffer Writes | Prepare changes in a private "draft." |
| **Commit** | **Conflict Check** | **The Final Gate**: Prevent lost updates. |

---

## 3. Walkthrough: Phase 2 in Action
Imagine a bank account $A$ with an initial balance of **$100**.

| Time | Transaction $T_1$ ($TS=10$) | Transaction $T_2$ ($TS=20$) | DBMS State (Disk) |
| :--- | :--- | :--- | :--- |
| **t1** | **Read(A)**: Sees **$100** (from snapshot) | | $A = 100$ |
| **t2** | | **Read(A)**: Sees **$100** (from snapshot) | $A = 100$ |
| **t3** | **Write(A, $150)**: Saves to **Private Buffer** | | $A = 100$ |
| **t4** | | **Read(A)**: Still sees **$100**! | $A = 100$ |
| **t5** | **Read(A)**: Sees **$150** (from own buffer) | | $A = 100$ |

---

## 4. Physical Implementation: Multi-Version Storage
To support these snapshots without making full copies of the database, modern systems (like PostgreSQL) use a **Multi-Version (MVCC)** row layout.

### Physical Row Layout (The Tuple)
An `UPDATE` is physically an `INSERT` of a new version. Every row (tuple) on disk has a header:
- **`xmin`**: The ID of the transaction that **created** this version.
- **`xmax`**: The ID of the transaction that **deleted or updated** this version (initially blank).
- **`ctid`**: A physical pointer to the **next version** of this row (forming a **Version Chain**).

### The Visibility Algorithm
When a transaction $T$ reads a page, it applies this logic to every tuple:
```text
IF xmin is NOT COMMITTED:
    Tuple is INVISIBLE (unless T created it itself)
ELSIF xmin committed AFTER T started:
    Tuple is INVISIBLE (it belongs to T's "future")
ELSE (xmin committed before T started):
    IF xmax is blank (not deleted):
        Tuple is VISIBLE
    ELSIF xmax committed AFTER T started:
        Tuple is VISIBLE (it was deleted in T's "future")
    ELSE:
        Tuple is INVISIBLE (it was deleted before T started)
```

---

## 5. Maintenance: Version Chains and Garbage Collection

### The Index Problem (Write Amplification)
Normally, every index on a table must point to the physical location of the row. If an update creates a new version in a new location, all indexes must be updated.
- **HOT Optimization (Heap-Only Tuples)**: If the update stays on the same page, the index continues pointing to the old version, which then has a physical pointer to the new one.

### The Vacuum Process
Because old versions are never overwritten, the database accumulates "dead tuples" (versions no longer visible to any transaction).
- **The Vacuum**: A background process that reclaims this space.
- **Transaction ID Wraparound**: If transaction IDs (32-bit) wrap around to 0, old data might suddenly appear to be in the "future" and disappear. The Vacuum "freezes" old rows to prevent this.

---

## 6. Outcomes: Properties and Anomalies

| Property | Description |
| :--- | :--- |
| **No [[CSE444/Definitions/Dirty Read\|Dirty Reads]]** | Transactions only read committed data from their snapshot. |
| **No Inconsistent Reads** | Multiple reads of the same element within $T$ always return the same value. |
| **No [[CSE444/Definitions/Lost Update\|Lost Updates]]** | The First-Committer-Wins rule prevents one transaction from overwriting another's update. |
| **No Delayed Reads** | Reads never wait for locks. |
| **Write Skew** | SI is **not serializable** because it allows [[CSE444/Definitions/Write Skew\|Write Skew]]. |

### The "Write Skew" Anomaly
Write Skew occurs when two transactions read overlapping data sets but update disjoint sets, violating a cross-record constraint.
- *Example*: Two doctors on call both try to resign at the same time. Both see that the *other* is still on call (in their snapshot) and commit. Result: Zero doctors on call.

---

## 7. Real-World Applications

| System | Primary Mechanism | Storage Method | Key Use Case |
| :--- | :--- | :--- | :--- |
| **PostgreSQL** | MVCC (SI/SSI) | In-table (Heap) | General purpose concurrency. |
| **Oracle** | MVCC (SI) | Undo Segments | Consistent reads for long reports. |
| **Git** | Snapshots | Content-Addressing | Branching and merging code. |
| **Google Docs** | OT + MVCC | Timestamped Logs | Real-time collaboration + History. |

---

## Related
- [[CSE444/Transactions/Optimistic Components/Timestamps|Timestamps]]
- [[CSE444/Transactions/Optimistic Components/Validation|Validation]]
- [[CSE444/Transactions/Isolation Levels|Isolation Levels]]
