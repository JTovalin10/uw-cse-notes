PON is the most common way to deliver fiber-based broadband to homes and businesses.

## Structure

- **Point-to-multipoint** tree design
- A single point in the [[Internet Service Provider (ISP)|ISP]] network can reach up to **1024 homes** (2^10)
- **Splitters** are passive — they forward optical signals without actively storing or forwarding frames

## Key Devices

- **[[Optical Line Terminal (OLT)]]** — where framing happens, located at the source
- **[[Optical Network Unit (ONU)]]** — the endpoint at each home/business

![[Pasted image 20260209162633.png]]

## Downstream Traffic

- Starts at the OLT
- Signal propagates down **every link** in the PON
- Every frame reaches **every ONU**
- Each ONU checks a unique identifier in the frame:
	- **Matches** → keep the frame
	- **Doesn't match** → drop the frame
- **Encryption** prevents ONUs from eavesdropping on neighbors' traffic

## Upstream Traffic

- **Time-division multiplexed** on a separate optical wavelength
- Each ONU periodically gets a turn to transmit
- Synchronized clocks (like SONET) are not practical because:
	- ONUs are spread over a wide area (kilometers)
	- Each ONU is at a different distance from the OLT
- Instead, the OLT sends **grants** to individual ONUs
	- Each grant gives the ONU a specific time interval to transmit
	- The OLT can grant different ONUs **different shares of time**
	- This effectively implements **different levels of service**

## Bandwidth Evolution

| Standard | Bandwidth |
|---|---|
| **G-PON** (Gigabit-PON) | 2.25 Gbps — most widely deployed today |
| **XGS-PON** (10 Gigabit-PON) | 10 Gbps — just starting to be deployed |
