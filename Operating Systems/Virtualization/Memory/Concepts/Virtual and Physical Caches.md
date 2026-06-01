# CSE451: Virtual and Physical Caches

Caches can be indexed and tagged using either virtual addresses or physical addresses, leading to different design tradeoffs.

## The Two Dimensions
...
| Design | Index  | Tag      | Speed | Correctness |
|--------|--------|----------|-------|-------------|
| VIVT   | Virtual | Virtual | Fast  | Requires flush on context switch |
| PIPT   | Physical | Physical | Slower | Always correct |
| VIPT   | Virtual | Physical | Fast  | Correct if index ⊆ page offset |

# Related
- [[Cache Organization|Cache Organization (351)]]
- [[Hardware & Software Interface/Memory Management/Virtual Memory|Virtual Memory (351)]]
- [[Memory management|OS Memory Management (451)]]
