# CSE451: Operating System Control of Hardware

**OS control** refers to an architecture where the OS mediates all access to hardware resources.

## Advantages
- Cleanup and security — the OS can recover from application failures
- Creates a standard API so it is easier to write applications

## Disadvantages
- More overhead — every hardware access goes through the OS middleman

## Related
- [[Application Control]] — the alternative: direct hardware access
- [[Hardware Modes]] — the parent concept comparing these two approaches
- [[System Call]] — the mechanism user code uses to request OS-mediated hardware access
