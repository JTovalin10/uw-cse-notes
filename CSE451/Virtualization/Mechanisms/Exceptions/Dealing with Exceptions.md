# CSE451: Dealing with Exceptions

When an [[CSE451/Virtualization/Mechanisms/Exceptions/Exception]] occurs, the OS can choose from several responses:

- **Fix the exception** — make an illegal memory address legal (e.g., allocate a page on demand)
- **Alert the program** — send a signal to the program (e.g., divide by zero sends SIGFPE)
- **Terminate the program** — kill the offending process (e.g., segfault with no handler)
- **Other responses** — depends on OS and exception type

## Related
- [[CSE451/Virtualization/Mechanisms/Exceptions/Exception]] — what triggers this response
- [[CSE451/Virtualization/Mechanisms/Traps/Traps|Traps]] — related class of kernel-entry events
- [[Page Fault]] — a common exception the OS can fix by bringing in a page
