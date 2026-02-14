# How it Works: The TLB and Page Tables
To perform translations quickly, the MMU relies on two main structures:

Page Tables: These are data structures stored in RAM that map virtual pages to physical frames. However, looking up addresses in RAM is slow.

[[Translation Lookaside Buffer]]: This is a small, ultra-fast hardware cache located inside the MMU. It stores the most recent address translations.

TLB Hit: The MMU finds the translation in the TLB (very fast).

TLB Miss: The MMU has to look up the translation in the slower Page Tables in RAM.
