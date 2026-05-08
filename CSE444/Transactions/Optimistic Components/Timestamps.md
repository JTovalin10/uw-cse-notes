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

## 2. Conflict Scenarios (The Problems)
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

## 3. The 4 Rules of Timestamp Scheduling
To prevent the paradoxes above, the scheduler examines [[CSE444/Definitions/RT(X)|RT(X)]], [[CSE444/Definitions/WT(X)|WT(X)]], and the commit bit [[CSE444/Definitions/C(X)|C(X)]] on every request. 

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
	- If $TS(T) < WT(X)$ and $C(X) = false$, then **Delay** $T$ until $C(X) = true$ or the transaction that wrote $X$ aborts.
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
	- For every database element $X$ written by $T$, restore the previous value of $X$, and restore the previous value of $WT(X)$. 
	- Allow any transactions waiting on $X$ to proceed.
- **Simplified**: 
	- Undo your changes, erase your "last write" mark, and wake up the people waiting so they can try again with the old data.

### Thomas' Write Rule (The Exception)
If $T$ wants to write $X$ and $WT(X) > TS(T)$, we **don't** necessarily have to rollback (unless $RT(X) > TS(T)$). We can just ignore the write because, in a serial timeline, $T$ would have written its value and then the "future" transaction would have immediately overwritten it. 
- **Result**: This ensures the schedule remains **[[CSE444/Transactions/Serializability/View Serializability|view-serializable]]** even though it is not conflict-serializable.

### Properties of Timestamp Scheduling
- [[CSE444/Transactions/Serializability/View Serializability|View-serializable]].
- Avoids [[CSE444/Definitions/Cascading Abort|cascading aborts]] (guarantees a [[CSE444/Transactions/Serializability/Schedules#Schedule Properties|recoverable schedule]]) thanks to the $C(X)$ bit.
- Does **NOT** handle phantoms (requires [[CSE444/Transactions/Phantom Problem|predicate locks]]).

---

## 4. Multiversion Timestamp (MVCC)
To avoid the high volume of rollbacks caused by the "Read Too Late" problem, the DBMS can keep multiple versions of a data element $X$: $X_t, X_{t-1}, X_{t-2}, \dots$ where $TS(X_t) > TS(X_{t-1}) > TS(X_{t-2})$.

- **Recoverability**: MVCC alone does not solve [[CSE444/Definitions/Cascading Abort|cascading aborts]]; it still requires the commit bit $C(X)$ logic to ensure that a transaction only reads committed data.
- **Improved Concurrency**: It allows transactions to read a value even if a "newer" transaction has already overwritten it, by providing the "older" version that the transaction should logically see.

### How it Changes the Rules
With multiple versions available, the scheduler must now track $RT(X_t)$ and $WT(X_t)$ for *every single version* of $X$, along with its commit bit $C(X_t)$. 

#### Rule 1: Request to Read $X$ ( $r_T(X)$ )
- **Textbook Definition**:
	- Find the version $X_t$ that has the highest write timestamp $t$ such that $t \leq TS(T)$.
	- If $C(X_t) = false$, then **Delay** $T$ until $C(X_t) = true$ or the creator aborts.
	- If $C(X_t) = true$, then **Grant** the read. Update $RT(X_t) = \max(TS(T), RT(X_t))$.
	- *Notice*: There is no "Rollback" condition here!
- **Simplified**:
	- *Which one do I read?* Look through history and find the newest version that is still "older" than you. **If a newer version exists (written by a "future" transaction), you simply ignore it and keep reading the old version as if the new one never happened.**
	- *Dirty data?* **Just wait.** (The person who wrote this specific version isn't finished yet. You don't have to rollback and restart, you just pause and wait for them to commit or abort).
	- *Safe?* Read it and leave your "last read" mark on *that specific version*. You **never die** from reading too late anymore!

#### Rule 2: Request to Write $X$ ( $w_T(X)$ )
- **Textbook Definition**:
	- Find the version $X_t$ that has the highest write timestamp $t$ such that $t \leq TS(T)$.
	- If $TS(T) < RT(X_t)$, then **Rollback** $T$. 
	- If $TS(T) = t$, then **Overwrite** the existing version $X_t$ (you already created it).
	- Else (i.e., $TS(T) \geq RT(X_t)$), **Create** a new version $X_{TS(T)}$. Set its $WT = TS(T)$, $RT = TS(T)$, and $C = false$.
- **Simplified**:
	- *Did someone from the future already read the version I'm about to replace?* Die. (Because they read the old version thinking it was the latest, inserting a new version right before their timeline would invalidate what they already saw).
	- *Safe?* Instead of overwriting the old data, just **create a brand new version** stamped with your time. 

---

## 5. Walkthrough Examples

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
