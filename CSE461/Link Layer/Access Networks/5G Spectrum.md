The transition from 4G to 5G introduces additional degrees of freedom in how the radio spectrum is scheduled, making it possible to adapt to a more diverse set of devices and applications.

## Flexible Waveforms

- 4G specified **only one** waveform
- 5G defines a **family of waveforms**, each optimized for a different radio band

> A **waveform** is the frequency, amplitude, and phase-shift independent property (shape) of a signal. A sine wave is an example waveform.

## Frequency Bands

### Low Band (below 1 GHz)
- Max bandwidth: **50 MHz**
- Focus: **range** — mobile broadband and massive IoT
- Subcarrier spacings: 15 kHz, 30 kHz
- Scheduling intervals: 0.5 ms, 0.25 ms

### Mid Band (1 GHz – 6 GHz)
- Max bandwidth: **100 MHz**
- Focus: **wider bandwidths** — mobile broadband and mission-critical apps
- Subcarrier spacings: 15 kHz, 30 kHz, 60 kHz
- Scheduling intervals: 0.5 ms, 0.25 ms, 0.125 ms

### mmWave (above 24 GHz)
- Max bandwidth: **400 MHz**
- Focus: **super wide bandwidths** — short, line-of-sight coverage
- Subcarrier spacings: 60 kHz, 120 kHz
- Scheduling intervals: 0.125 ms

## Scheduling Flexibility

- The scheduler can allocate [[Orthogonal Frequency-Division Multiple Access (OFDMA)|OFDMA]] resource blocks to users **and** dynamically adjust the **size** of those blocks
- It does this by changing the **waveform** used in the band it schedules

## Scheduling Algorithm

Whether 4G or 5G, the scheduler has two simultaneous goals:
1. **Maximize utilization** of the available frequency band
2. **Ensure every [[User Equipment (UE)|UE]]** receives its required level of service

This algorithm is **not specified by 3GPP** — it is the proprietary intellectual property of the [[Broadband Base Unit (BBU)|BBU]] vendors.
