The tradeoff of ATM's fixed 53-byte cell size is wasted bandwidth:
- **Payload > 48 bytes**: Must be split across multiple cells, each carrying 5 bytes of header overhead
- **Payload < 48 bytes**: Must be padded to fill the cell, wasting the remaining space

This is the fundamental cost of the performance gains ATM gets from [[Fixed-Size Cells]].
