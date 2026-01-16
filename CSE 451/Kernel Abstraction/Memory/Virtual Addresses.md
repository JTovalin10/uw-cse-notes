# What is virtual addresses
- translation done in hardware, using a table
- table set up by os kernel
- memory is broken into pages (typically 4KB chunks)
![[Screenshot 2026-01-07 at 12.41.04 PM.png]]

# How this fixes [[Base and Bounds]]
1. [[No More Fragmentation]]
2. [[Easy Sharing]]
3. [[Dynamic Growth]]
4. [[Demand Paging]]
5. [[Page Protection]]

# Downsides
See [[Virtual Address Downsides]]

# Coding Example

```c
int main() {
int x = 1;
int* y = &x // this returns the virtual address
}
```
