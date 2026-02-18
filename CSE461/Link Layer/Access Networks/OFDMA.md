**[[Orthogonal Frequency-Division Multiple Access (OFDMA)]]** is the media access mechanism for [[Long-Term Evolution (LTE)|LTE]].

## How It Works

- Multiplexes data over a set of **12 orthogonal subcarrier frequencies**
- Each subcarrier is modulated **independently**
- "Multiple Access" means data can be sent for **multiple users simultaneously**
	- Each user gets a different subcarrier frequency
	- Each user transmits for a different duration of time
- Subbands are narrow (e.g., **15 kHz**)
- Coding is designed to minimize interference between adjacent bands

## The Radio Spectrum as a 2D Resource

OFDMA naturally leads to viewing the radio spectrum as a **two-dimensional grid**:
- **One axis** → frequency (subcarrier slots)
- **Other axis** → time

[![../_images/Slide4.png](https://book.systemsapproach.org/_images/Slide4.png)](https://book.systemsapproach.org/_images/Slide4.png)

*The available radio spectrum represented as a 2-D grid of schedulable Resource Elements.*

## Resource Element (RE)

The **minimal schedulable unit**:
- **Width**: 15 kHz band around one subcarrier frequency
- **Height**: time to transmit one OFDMA symbol
- Bits per symbol depends on modulation rate:

| Modulation | Bits per Symbol |
|---|---|
| 16-QAM | 4 bits |
| 64-QAM | 6 bits |

## Physical Resource Block (PRB)

The **scheduling granularity** — a block of:
- **7 symbols** (time) x **12 subcarriers** (frequency) = **84 Resource Elements**
- The scheduler allocates PRBs to different UEs

## Scheduling Feedback

- **Transmission Time Interval (TTI)** = **1 ms**
	- The time frame in which the BBU receives feedback from UEs
- **Channel Quality Indicator (CQI)** — feedback from UEs reporting:
	- Observed **signal-to-noise ratio**
	- Impacts the UE's ability to recover data bits
- The base station uses CQI to **adapt spectrum allocation** to the UEs it serves
