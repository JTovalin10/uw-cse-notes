Given a time frame, what is the number of pages you will touch

#define working set: set of pages a process currently needs, used to model the dynamic locality of its memory usage
more formally
$$
WS(t, w) = \{\text{pages P : tP was references in the time interval (t, t-w)}\}
$$
- t = time
- w = working set window (measured in page refs)
- a page is in the working set (WS) only if it was referenced in the last w references
## Working set size
the working set size = $|WS(t, w)|$ changes with program locality
- during periods of poor locality, more pages are referenced
- within that period of time, the working set size is larger
The working set must be in memory or else we will experience [[Thrashing]]/heavy faulting