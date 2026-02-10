Cellular technology relies on base stations connected to a wired network.

## Key Terminology

- **Broadband Base Unit (BBU)** — the base station.
- **User Equipment (UE)** — the mobile device that connects to a BBU.
- **Evolved Packet Core (EPC)** — hosted in a Central Office, anchors the set of BBUs.
- **Radio Access Network (RAN)** — the wireless network served by the EPC.

![[Pasted image 20260209162822.png]]

## Cells

The geographic area served by a BBU's antenna is called a **cell**.
- A BBU could serve a single cell or use multiple directional antennas to serve multiple cells.
- Cells don't have crisp boundaries and they **overlap**.
- Where cells overlap, a UE could potentially communicate with multiple BBUs, but at any time the UE is in communication with and under the control of **just one BBU**.

## LTE vs. WiFi: Media Access Strategy

The main innovation of LTE's air interface is how it allocates the available radio spectrum to UEs.

| | **WiFi** | **LTE** |
|---|---|---|
| **Strategy** | Contention-based | Reservation-based |
| **Assumption** | Lightly loaded network | High utilization |
| **Approach** | Optimistically transmit when idle, back off on contention | Explicitly assign different users to different shares of the spectrum |

See [[OFDMA]] for the details of LTE's media access mechanism, and [[5G Spectrum]] for how 5G extends this.
