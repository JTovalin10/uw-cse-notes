# CSE444: Timestamps

Timestamp-based concurrency control assumes that conflicts between transactions are rare. Instead of locking elements in advance, the DBMS uses timestamps to ensure that the execution of transactions is equivalent to a serial schedule ordered by those timestamps.

---

## 1. The Core Concept
Each transaction receives a **unique timestamp** $TS(T)$ when it begins.
- **System Clock**: Can be used, but tricky to keep synchronized in distributed systems.
- **Unique Counter**: A logical counter incremented by the scheduler.

The system's goal is to force transactions to behave as if they executed serially in the exact order of their timestamps.

![[CSE444/Screenshots/Timestamp Multiple Transactions example.png]]

---

## 2. Timestamp Metadata Fields

Every data element $X$ carries three metadata fields that the scheduler inspects on every read or write request.

**RT(X) — Read Timestamp**

### Formal Definition
$RT(X) = \max(\{TS(T) \mid T \text{ has successfully read } X\} \cup \{0\})$. The highest timestamp of any transaction that has read $X$.

### Simplified Explanation
The "last reader" mark. Tracks the most recent (youngest) transaction that looked at this data. Used to prevent an older transaction from writing a value after a younger transaction has already read it — that would retroactively change data the younger transaction already acted on.

---

**WT(X) — Write Timestamp**

### Formal Definition
$WT(X) = \max(\{TS(T) \mid T \text{ has successfully written } X\} \cup \{0\})$. The highest timestamp of any transaction that has written $X$.

### Simplified Explanation
The "last writer" mark. Tracks the most recent transaction that changed this data. Used to detect when an older transaction tries to read or write a value that a younger transaction has already overwritten.

---

**C(X) — Commit Bit**

### Formal Definition
$C(X) \in \{true, false\}$. A status bit representing whether the transaction $T$ such that $TS(T) = WT(X)$ has committed. $C(X) = true$ means the most recent write to $X$ is durable.

### Simplified Explanation
The "is it safe?" flag. Before reading $X$, a transaction checks $C(X)$. If $false$, the data is dirty (uncommitted) and the transaction must wait rather than risk reading data that may be rolled back.

---

## 3. Conflict Scenarios (The Problems)
Before looking at the rules, we must understand the "timeline paradoxes" the scheduler is trying to prevent when transactions interleave.

### Read Too Late
**Condition**: $T$ wants to read $X$, but $WT(X) > TS(T)$.
![[CSE444/Screenshots/Read Too Late.png]]

**Why it matters**:
- **Serialization Violation**: In a serial schedule, $T$ (the older transaction) should have executed *before* the transaction that wrote the new value. If $T$ reads the new value, it is essentially "reading from the future."
*   **Physical Unrealizability**: The version of $X$ that $T$ was *supposed* to see has already been overwritten. $T$ must be aborted and restarted with a newer timestamp so it can logically exist *after* the current writer.

### Write Too Late
**Condition**: $T$ wants to write $X$, but $RT(X) > TS(T)$.
![[CSE444/Screenshots/Write Too Late.png]]

**Why it matters**:
*   **Invalidating Future Reads**: Some transaction $U$ (where $TS(U) > TS(T)$) has already read the current value of $X$ and made decisions based on it. If we allow $T$ to write $X$ now, we are retroactively changing the data that $U$ already saw.
*   **Timeline Paradox**: In a serial order, $T$ should have finished its write *before* $U$ ever started its read. By writing "late," $T$ is trying to insert a change into a past that has already been witnessed. To maintain integrity, $T$ must rollback.

---

## 4. The 4 Rules of Timestamp Scheduling
To prevent the paradoxes above, the scheduler examines $RT(X)$, $WT(X)$, and the commit bit $C(X)$ on every request.

From Garcia-Molina et al. 18.8.4, the scheduler must handle four types of requests:

#### Rule 1: Request to Read $X$ ( $r_T(X)$ )
- **Textbook Definition**:
	- If $TS(T) < WT(X)$, then **Rollback** $T$.
	- If $TS(T) \geq WT(X)$ and $C(X) = false$, then **Delay** $T$ until $C(X) = true$ or the transaction that wrote $X$ aborts.
	- If $TS(T) \geq WT(X)$ and $C(X) = true$, then **Grant** the read. Update $RT(X) = \max(TS(T), RT(X))$.
- **Simplified**: 
	- *Too late?* Die. (Someone from the future already changed it).
	- *Dirty data?* Wait. (The person who wrote this isn't finished yet).
	- *Safe?* Read it and leave your "last read" mark.

#### Rule 2: Request to Write $X$ ( $w_T(X)$ )
- **Textbook Definition**:
	- If $TS(T) < RT(X)$, then **Rollback** $T$.
	- If $TS(T) < WT(X)$ and $C(X) = false$, then **Delay** $T$ until $C(X) = true$ or the transaction that wrote $X$ aborts. Once the wait ends, **re-evaluate $T$'s request from the top** with the now-updated state of $WT(X)$ and $C(X)$:
		- *Writer committed* ($C(X)$ became $true$): the condition is now $TS(T) < WT(X)$ and $C(X) = true$ → **Ignore** (Thomas Write Rule — a future transaction already committed its write, so $T$'s write is obsolete).
		- *Writer aborted*: Rule 4 restored $WT(X)$ to its previous value. Re-evaluating, $T$ now likely satisfies $TS(T) \geq RT(X)$ and $TS(T) \geq WT(X)$ → **Grant**.
	- If $TS(T) < WT(X)$ and $C(X) = true$, then **Ignore** the write (Thomas Write Rule).
	- If $TS(T) \geq RT(X)$ and $TS(T) \geq WT(X)$, then **Grant** the write. Set $WT(X) = TS(T)$ and set $C(X) = false$.
- **Simplified**:
	- *Someone from the future read the old value?* Die. (You'd break their timeline).
	- *Someone from the future is writing, but not done?* Wait to see if they succeed.
	- *Someone from the future already wrote and finished?* Do nothing. Your write is obsolete.
	- *Safe?* Write it, leave your "last write" mark, and set the flag to "dirty" ($C=false$).

#### Rule 3: Request to Commit $T$
- **Textbook Definition**:
	- For every database element $X$ written by $T$, set $C(X) = true$.
	- Allow any transactions waiting on $X$ (due to $C(X) = false$ in Rules 1 or 2) to proceed.
- **Simplified**: 
	- Mark all your work as "Finished/Safe." Wake up anyone who was waiting in line to read or write your data.

#### Rule 4: Request to Abort $T$
- **Textbook Definition**:
	- For every database element $X$ written by $T$: restore the previous value of $X$, restore $WT(X)$ to its value before $T$'s write, and set $C(X) = true$.
	- Allow any transactions delayed on $X$ (waiting for $C(X) = true$ per Rules 1 or 2) to proceed.
- **Simplified**: 
	- Undo your physical write to $X$, roll back $WT(X)$ to its previous value, and flip $C(X) = true$ — this unblocks any transaction that was delayed waiting on your dirty write, so they can re-evaluate with the restored, clean data.

### Thomas' Write Rule (The Exception)
If $T$ wants to write $X$ and $WT(X) > TS(T)$, we **don't** necessarily have to rollback (unless $RT(X) > TS(T)$). We can just ignore the write because, in a serial timeline, $T$ would have written its value and then the "future" transaction would have immediately overwritten it. 
- **Result**: This ensures the schedule remains **[[CSE444/Transactions/Serializability/View Serializability|view-serializable]]** even though it is not conflict-serializable.

### Properties of Timestamp Scheduling
- [[CSE444/Transactions/Serializability/View Serializability|View-serializable]].
- Avoids [[CSE444/Definitions/Cascading Abort|cascading aborts]] (guarantees a [[CSE444/Transactions/Serializability/Schedules#Schedule Properties|recoverable schedule]]) thanks to the $C(X)$ bit.
- Does **NOT** handle phantoms (requires [[CSE444/Transactions/Phantom Problem|predicate locks]]).

---

## 5. Multiversion Timestamp (MVCC)
To avoid the high volume of rollbacks caused by the "Read Too Late" problem, the DBMS can keep multiple versions of a data element $X$.

### Version Notation & Metadata
In MVCC, a data element $X$ is stored as a list of versions: $X_{t_1}, X_{t_2}, \dots, X_{t_n}$.
- **What is $t$?**: The subscript $t$ represents the **Write Timestamp ($WT$)** of that specific version. It is equal to the timestamp of the transaction that created it. Essentially, $t$ is the version's "birthdate."
- **$WT(X_t)$**: This value is **immutable**. Once version $X_t$ is created, its write timestamp is forever $t$.
- **$RT(X_t)$**: Each version maintains its own "visitor log." It tracks the timestamp of the youngest (highest TS) transaction that has read **this specific version**.

### Rule 1: Request to Read $X$ ( $r_T(X)$ )
- **Textbook Definition**:
	1. Find the version $X_t$ that has the highest write timestamp $t$ such that $t \leq TS(T)$.
	2. If $C(X_t) = false$, then **Delay** $T$ until $C(X_t) = true$ or the creator aborts.
	3. If $C(X_t) = true$, then **Grant** the read. Update $RT(X_t) = \max(TS(T), RT(X_t))$.
- **The "Version Selection" Logic**:
	- You are looking for the **most recent version of the past**.
	- If your $TS=10$ and the versions available are $X_5$, $X_{12}$, and $X_{15}$, you read **$X_5$**.
	- **Why ignore the "future"?**: In a serial schedule, $T$ (at time 10) cannot see changes made by transactions that (logically) haven't happened yet ($12$ and $15$). By reading $X_5$, $T$ gets a **consistent snapshot** of the database as it existed at the moment $T$ was born.
- **Simplified**:
	- *Which one do I read?* Look at the birthdates ($t$) and pick the newest one that isn't younger than you. 
	- *What about WT and RT?*: You don't change the $WT$ (it's fixed). You only update the $RT$ of the *specific version* you touched. This tells the system: "Someone from time $TS(T)$ has now witnessed the value of $X_t$."

### Rule 2: Request to Write $X$ ( $w_T(X)$ )
- **Textbook Definition**:
	1. Find the version $X_t$ that has the highest write timestamp $t$ such that $t \leq TS(T)$. (This is the version $T$ *would* have read).
	2. If $TS(T) < RT(X_t)$, then **Rollback** $T$. 
	3. If $TS(T) = t$, then **Overwrite** the existing version $X_t$ (you already created it).
	4. Else (i.e., $TS(T) > RT(X_t)$), **Create** a new version $X_{TS(T)}$. Set its $WT = TS(T)$, $RT = TS(T)$, and $C = false$.
- **The "Timeline Paradox" (Why Writes Still Fail)**:
	- Even though we have multiple versions, $T$ can still die if it tries to write "too late."
	- **Scenario**: $T$ has $TS=10$. The latest version from its perspective is $X_5$. However, some transaction $U$ with $TS=20$ has already read $X_5$ ($RT(X_5) = 20$).
	- If $T$ is allowed to write $X_{10}$ now, then $U$ (at time 20) **should have read $X_{10}$** instead of $X_5$.
	- Because $U$ already "witnessed" the past and saw $X_5$, we cannot go back in time and insert $X_{10}$ into $U$'s history. $T$ has missed its window and must be aborted.
- **Simplified**:
	- *Did someone from the future already look at the version I'm supposed to follow?* If so, you're too late to change the course of history. Die.
	- *Safe?* Don't touch the old versions. Just add your new version $X_{TS(T)}$ to the end of the list.

---

## 6. Walkthrough Examples

### Basic Timestamp Scheduling (Single Version)
Suppose we have $X$ with $RT(X)=0, WT(X)=0, C(X)=true$.

| Time | Transaction | Request | Action | Reason |
| :--- | :--- | :--- | :--- | :--- |
| 1 | $T_1$ ($TS=10$) | $r(X)$ | **Grant** | $10 \geq WT(X)$. $RT(X) \to 10$. |
| 2 | $T_2$ ($TS=20$) | $r(X)$ | **Grant** | $20 \geq WT(X)$. $RT(X) \to 20$. |
| 3 | $T_2$ ($TS=20$) | $w(X)$ | **Grant** | $20 \geq RT(X)$. $WT(X) \to 20, C(X) \to false$. |
| 4 | $T_1$ ($TS=10$) | $w(X)$ | **Rollback** | $10 < RT(X)$ (20). Writing would invalidate $T_2$'s read. |

### MVCC Example
Suppose we have version $X_0$ with $RT=0, WT=0, C=true$.

| Time | Transaction | Request | Action | Reason |
| :--- | :--- | :--- | :--- | :--- |
| 1 | $T_1$ ($TS=10$) | $r(X)$ | **Grant** | Reads $X_0$. $RT(X_0) \to 10$. |
| 2 | $T_2$ ($TS=20$) | $w(X)$ | **Grant** | Creates $X_{20}$. $RT(X_{20})=20, WT(X_{20})=20, C(X_{20})=false$. |
| 3 | $T_3$ ($TS=25$) | $r(X)$ | **Delay** | Highest $WT \leq 25$ is $X_{20}$, but $C(X_{20})=false$. |
| 4 | $T_1$ ($TS=10$) | $r(X)$ | **Grant** | Highest $WT \leq 10$ is $X_0$. $C(X_0)=true$. Still works! |
| 5 | $T_2$ | Commit | **Grant** | $C(X_{20}) \to true$. Wake up $T_3$. |
| 6 | $T_3$ | $r(X)$ | **Grant** | Now reads $X_{20}$. $RT(X_{20}) \to 25$. |

### Garbage Collection
- **Textbook Definition**: The system can safely delete $X_t$ if a later version $X_{t1}$ exists (where $t1 > t$) and there are no active transactions $T$ in the system where $t \leq TS(T) < t1$.
- **Simplified**: You can throw away an old version once a newer version exists AND there is nobody left alive who is old enough to need the old one.

![[CSE444/Screenshots/Second Example w Multiversion.png]]

## Related
- [[CSE444/Transactions/Pessimistic Components/Pessimistic Scheduler|Pessimistic Scheduler]]
- [[CSE444/Transactions/Isolation Levels|Isolation Levels]]
- [[CSE444/Transactions/Serializability/Conflict Serializability|Conflict Serializability]]
- [[CSE444/Transactions/Optimistic Components/Validation|Validation]]
- [[CSE444/Transactions/Optimistic Components/Snapshot Isolation|Snapshot Isolation]]
