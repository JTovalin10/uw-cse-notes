# **RT(X)** (Read Timestamp)

### Formal Definition
$RT(X) = \max(\{TS(T) \mid T \text{ has successfully read } X\} \cup \{0\})$. It represents the highest timestamp of any transaction that has performed a read operation on data element $X$.

### Simple Explanation
**The "Last Reader" Mark.**
This keeps track of the "youngest" (most recent) person who looked at this data. 
- We use this to prevent "older" transactions from coming in later and trying to change the data *after* a younger person has already seen it (which would break the timeline).
