#define working set: ste of pages process currently needs which is used to model the dynamic locality of its memory usage
more formally
$$
WS(t, w) = \{\text{pages P : tP was references in the time interval (t, t-w)}\}
$$
- t = time
- w = working set window (measured in page refs)
- a page is in the working set (WS) only if it was refrenced in the last w refrences
## Working set size
the working size = $|WS(t, w)|$ changes with program locality
- during periods of porr localtiy, more pages are referenced
- within that period of time, the working set size is larger
The working set must be in memory or else we will experience [[Thrashing]]/heavy faulting