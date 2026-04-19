# CSE451: Application Control of Hardware

**Application control** refers to an architecture where applications directly access hardware without OS mediation.

## Advantages
- No OS middleman (little to no latency)
- Applications can potentially implement hardware access faster

## Disadvantages
- Malicious code is easier to write — attackers get full access since the kernel cannot protect the hardware
- No cleanup mechanism if code fails; programmers must handle this themselves

## Related
- [[OS Control]] — the alternative: OS mediates all hardware access
- [[Hardware Modes]] — the parent concept comparing these two approaches
- [[User Mode]] — the modern compromise: applications run in user mode with OS mediation
