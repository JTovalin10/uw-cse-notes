# **WT(X)** (Write Timestamp)

### Formal Definition
$WT(X) = \max(\{TS(T) \mid T \text{ has successfully written } X\} \cup \{0\})$. It represents the highest timestamp of any transaction that has performed a write operation on data element $X$.

### Simple Explanation
**The "Last Writer" Mark.**
This keeps track of the "youngest" (most recent) person who changed this data.
- If you try to read or write data, the system checks this to see if someone "from the future" has already changed it. If they have, you are "too late" and usually have to restart.
