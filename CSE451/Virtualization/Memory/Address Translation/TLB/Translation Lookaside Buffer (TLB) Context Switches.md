# TLB and Context Switches
**Problem**: after a [[Context Switch]], TLB entries still belong to the old process and cannot be used by the new one.

| approach | how it works | tradeoff |
|----------|-------------|----------|
| flush the TLB | clear all entries on every switch | simple, but next process starts cold with all misses |
| use ASIDs | tag each entry with a process ID so entries from multiple processes coexist | no flush needed, much better performance |
