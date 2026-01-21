# Baseline Wander
while sync is the main timing issue, long strings of 0s or 1s also cause **baseline wandering** in electrical systems
- if a signal is "AC coupled" (common in Ethernet to avoid ground loops), it relies on an average voltage of zero
- sending a long string of 0s (which might be -5V) drags the average voltage down
- eventually, the receiver can no longer distinguish between a "0" and a "1" because the electrical baseline has shifted

# Related
- [[../Simple Rate Model|Simple Rate Model]]
- [[Clock Drift]]
