# Writing Multithreaded Code: Deep Dive

## Deep Dive

### Hardware Memory Models: x86-64 TSO vs. Weakly-Ordered ARM
Hardware platforms implement different memory consistency guarantees at the silicon level:
- **x86-64 Total Store Order (TSO)**: x86 hardware provides relatively strong ordering guarantees. It guarantees that:
  - Loads are not reordered with other loads (No Load-Load reordering).
  - Stores are not reordered with other stores (No Store-Store reordering).
  - Stores are not reordered with older loads (No Load-Store reordering).
  - **However, stores can be reordered with younger loads to different addresses (Store-Load reordering)** due to hardware store buffers.
  - As a result, Peterson's algorithm or Dekkers's algorithm fails on x86-64 unless an explicit `MFENCE` instruction is inserted between the flag store and the turn load.
- **Weakly-Ordered Architectures (ARM64, RISC-V, POWER)**: These architectures allow almost all combinations of memory access reordering to maximize silicon energy efficiency and speculative pipeline depth. Loads and stores can be committed out of order unless paired with acquire-release barriers (`LDAR`/`STLR` on ARM64) or data memory barriers (`DMB`).
- **Language Standards (C11, C++11, Rust)**: Modern languages abstract physical hardware differences by defining an abstract memory model based on the **Happens-Before** relationship. A program free of data races under sequentially consistent or acquire-release atomic semantics is guaranteed to behave predictably across all CPU architectures.

## Related

- [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code|Writing Multithreaded Code]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Edge Cases and Failure Modes|Edge Cases and Failure Modes]] — Deadlock, double-locking, stragglers, and flag signaling (beyond lecture)
