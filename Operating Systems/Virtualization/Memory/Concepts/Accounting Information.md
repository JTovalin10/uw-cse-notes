# CSE451: Accounting Information

**Accounting Information** is the set of usage statistics the OS tracks for each process, used for scheduling decisions, billing, and enforcing resource limits.

## What Gets Tracked

- **Amount of CPU time used**: How much processor time the process has consumed, which scheduling policies can use to decide priority or preemption.
- **Time limits**: A maximum amount of CPU time (or wall-clock time) the process is permitted to run before the OS intervenes (e.g., terminates it).
- **Account numbers**: An identifier tying the process's resource usage back to a user or billing account, relevant in multi-user or shared systems where usage must be attributed and possibly charged.
- Other similar bookkeeping the OS may track depending on the system's needs.

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| Accounting Information | Process accounting / resource usage statistics |
| Time limits | CPU quota / rlimit (POSIX) |

## Related
- [[Operating Systems/Virtualization/Memory/Concepts/Memory Management Information|Memory Management Information]]
- [[Operating Systems/Virtualization/Processes/Process|Process]]
