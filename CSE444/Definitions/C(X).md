# **C(X)** (The Commit Bit)

### Formal Definition
$C(X) \in \{true, false\}$. It is a status bit associated with data element $X$ representing the commit status of the transaction $T$ such that $TS(T) = WT(X)$. If $C(X) = true$, the transaction that performed the most recent write to $X$ has successfully committed.

### Simple Explanation
**The "Is it Safe?" Flag.**
When you read a piece of data, you need to know if the person who wrote it is "finished" (committed). 
- If $C(X)$ is **true**, the data is permanent and safe to read.
- If $C(X)$ is **false**, the data is "dirty" and you might have to wait or risk an abort if that person cancels their changes.
