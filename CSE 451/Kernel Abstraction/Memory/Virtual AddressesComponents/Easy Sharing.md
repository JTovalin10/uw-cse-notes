# Easy Sharing
```
Process A's page 5 → Frame 100 (shared library code)
Process B's page 3 → Frame 100 (same shared library)
```

Multiple virtual addresses → same physical frame

This allows processes to share common code/libraries, which was impossible with [[Base and Bounds]].
