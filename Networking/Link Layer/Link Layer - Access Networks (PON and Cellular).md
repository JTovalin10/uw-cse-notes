# Link Layer: Access Networks (PON and Cellular)

## Low-Level Primer: The "Last Mile" Problem
**Access Networks** are the physical and logical links that connect individual subscribers (homes, businesses, mobile devices) to the core network of an Internet Service Provider (ISP). This segment is often the most heterogeneous part of the Internet, utilizing a wide range of technologies to bridge the gap between high-speed core fiber and end-user hardware.

---

## 1. Passive Optical Network (PON)

PON is the dominant architecture for **Fiber-to-the-Home (FTTH)**. It is a "passive" system because it uses unpowered optical splitters to divide a single fiber from the ISP among multiple subscribers.

### Infrastructure Components
*   **OLT (Optical Line Terminal)**: Located in the ISP's central office. It manages all subscribers on the tree.
*   **ONU (Optical Network Unit)**: Located at the subscriber's premises (the "modem").
*   **Passive Splitter**: A simple glass prism that splits the optical signal (e.g., 1 fiber to 32 or 64 subscribers).

### Transmission Mechanics
*   **Downstream (OLT $\to$ ONU)**: A continuous **Broadcast**. Every ONU receives every packet.
    *   **Filtering**: ONUs only pass frames addressed to their specific ID to the user.
    *   **Security**: Because it is a shared broadcast medium, downstream data is **Encrypted** at the link layer to ensure privacy.
*   **Upstream (ONU $\to$ OLT)**: **Time-Division Multiplexed (TDM)**.
    *   **The Grant Mechanism**: Since ONUs cannot hear each other (due to the splitter), they cannot use CSMA. Instead, the OLT issues **Grants**—precise time slots specifying exactly when an ONU is allowed to transmit. This eliminates collisions entirely.

---

## 2. Cellular Radio Access Network (RAN)

Cellular networks (LTE, 5G) manage access over wide areas using licensed radio spectrum.

### Infrastructure Components
*   **UE (User Equipment)**: The mobile handset or IoT device.
*   **BBU (Broadband Base Unit)**: The digital processing "brain" at the cell tower.
*   **RRH (Remote Radio Head)**: The antennas that convert digital bits to radio waves.
*   **EPC (Evolved Packet Core)**: The central ISP logic that manages UE identity, billing, and routing to the Internet.

### Key Mechanics
*   **Spectrum Scarcity**: Because radio spectrum is licensed and expensive, cellular protocols are strictly **Centralized**. The base station dictates all timing and frequency assignments.
*   **Handoff**: The process of moving a UE from one BBU to another as the user roams. This requires tight coordination between the source and target BBUs to ensure zero packet loss (typically managed by the EPC).
*   **Multiplexing**: Uses **OFDMA** (Orthogonal Frequency-Division Multiple Access) to assign specific "sub-carriers" and time slots to different users simultaneously.

[Image: Diagram showing UE, RRH/BBU towers, and the connection to the Core Network (EPC)]
