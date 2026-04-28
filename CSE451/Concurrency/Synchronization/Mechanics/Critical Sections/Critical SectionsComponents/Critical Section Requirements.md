# Critical Section Requirements
for a solution to the critical section problem to be correct, it must satisfy these properties

## Mutual Exclusion
- at most one thread is in the critical section at any time
- see [[CSE451/Processes/Synchronization/Mutual Exclusion]]

## Progress
- if [[Thread]] T is outside the critical section, then T cannot prevent thread S from entering the critical section
- threads outside the critical section should not block others

## Bounded Waiting (No Starvation)
- if thread T is waiting on the critical section, then T will eventually enter the critical section
- assumes threads eventually leave critical sections
- prevents indefinite postponement

## Performance
- the overhead of entering and exiting the critical section is small with respect to the work being done within it
- mechanisms should not add excessive latency

## Related
- [[Critical Sections]]
- [[CSE451/Processes/Synchronization/Mutual Exclusion]]
