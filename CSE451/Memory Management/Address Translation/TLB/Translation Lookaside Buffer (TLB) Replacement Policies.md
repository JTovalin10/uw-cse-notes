# TLB Replacement Policies
When the TLB is full and a new entry must be installed, a victim entry must be chosen:

| policy | how it works | tradeoff |
|--------|-------------|----------|
| LRU | evict the least recently used entry | better hit rate, more complex hardware |
| random | evict a random entry | simpler hardware, surprisingly effective in practice |
