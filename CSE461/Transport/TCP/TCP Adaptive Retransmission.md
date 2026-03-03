# TCP Adaptive Retransmission

TCP retransmits segments when an ACK is not received within a timeout. The timeout must adapt to varying [[Round-Trip Time (RTT)|RTT]] across connections and over time.

## Original algorithm

- `SampleRTT` = time from send to ACK
- `EstimatedRTT = α × EstimatedRTT + (1 - α) × SampleRTT` (α ≈ 0.8–0.9)
- `TimeOut = 2 × EstimatedRTT`

## Karn/Partridge (1987)

**Problem:** On retransmission, can't tell if ACK is for first or second transmission → wrong SampleRTT.

![Associating ACK with original vs retransmission](https://book.systemsapproach.org/_images/f05-10-9780123850591.png)

**Fix:**
- Don't sample RTT for retransmitted segments
- On retransmit, use exponential backoff for timeout (double each time)
- Congestion likely cause of loss → don't react too aggressively

## Jacobson/Karels (1988)

**Problem:** Original ignores variance; fixed 2× multiplier is too conservative or too aggressive.

**Fix:** Track both mean and deviation:
- `Difference = SampleRTT - EstimatedRTT`
- `EstimatedRTT += δ × Difference`
- `Deviation += δ × (|Difference| - Deviation)`
- `TimeOut = μ × EstimatedRTT + φ × Deviation` (μ=1, φ=4)

- Small variance → TimeOut ≈ EstimatedRTT
- Large variance → Deviation term dominates

## Implementation

- Scaled integer arithmetic (no floating point) — e.g., δ = 1/8, use shifts
- Clock granularity matters; coarse clocks hurt accuracy
- RFC 6298 specifies details
- Timeout doesn't tell sender which *later* segments were received → SACK extension helps

## Related

- [[Transmission Control Protocol (TCP)]]
- [[Round-Trip Time (RTT)]]
- [[Sliding Window]]
- [[Binary Exponential Backoff (BEB)]]
