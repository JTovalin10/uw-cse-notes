# CSE451: Working Set of Program Behavior

The **working set** model asks a simple question: given a time frame, what is the number of distinct pages a process will touch? This is used to model the dynamic locality of a process's memory usage — how much memory it actually needs *right now* to run without excessive faulting, as opposed to the total size of its address space.

## Working Set Size

The working set size, $|WS(t, w)|$, changes with a program's locality of reference:

- During periods of poor locality (e.g., a phase transition in the program, or scanning over a large data structure), more distinct pages are referenced in a given window.
- Within that period of time, the working set size is larger, since more unique pages fall inside the window `w`.

The working set must fit entirely in memory, or else the process will experience **[[Thrashing]]**/heavy faulting: if fewer frames are resident than the working set size, the process will keep evicting pages it needs again shortly afterward, repeatedly re-faulting on the same working set.

## Related
- [[Thrashing]]
- [[Page Fault Frequency]]
- [[Operating Systems/Virtualization/Memory/Page Replacement/Page replacement|Page replacement]]
- [[Operating Systems/Virtualization/Memory/Windows/Windows Paging|Windows Paging]] — Windows' working-set-based memory model

## Formal Definition

$$
WS(t, w) = \{\text{pages } P : P \text{ was referenced in the time interval } (t - w,\ t)\}
$$

- $t$ = the current time (measured in page references).
- $w$ = the working set window, measured in page references (i.e., how far back to look).
- A page $P$ is in the working set $WS(t, w)$ if and only if it was referenced at least once in the last $w$ references before time $t$.

## Simplified Explanation

Pick a window of the last `w` memory accesses a process made. The working set is just the list of unique pages that show up anywhere in that window — pages the process has touched recently enough that it will probably touch them again soon. If that window is small, only a few pages "count" as needed; if a program is in a phase where it's jumping around touching lots of different pages, the working set balloons, and the OS needs to keep more frames resident for that process or it will thrash.

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| Working Set | Working set (standard term, coined by Denning) |
| Working set window (w) | Sampling window / observation interval |
