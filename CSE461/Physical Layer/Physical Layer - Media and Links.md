# Physical Layer: Media and Links

## Low-Level Primer: Guided vs. Unguided Transmission
At the physical layer, bits are converted into energy (electrical, optical, or radio) and transmitted through a medium. Media are categorized as **Guided** (energy is contained within a physical conductor) or **Unguided** (energy radiates through space).

---

## 1. Guided Media (Wired)

### Twisted Pair (UTP/STP)
The most ubiquitous network cable (Ethernet).
*   **Mechanism**: Two insulated copper wires twisted together. The twists cancel out electromagnetic interference (EMI) from external sources and crosstalk from adjacent pairs.
*   **Categories**: 
    *   **Cat 5e**: Up to 1 Gbps, 100m.
    *   **Cat 6a**: Up to 10 Gbps, 100m.

### Coaxial Cable
*   **Mechanism**: A central copper conductor surrounded by a thick insulating layer and a braided metal shield.
*   **Benefit**: Superior shielding compared to twisted pair; supports higher bandwidth and longer distances (e.g., Cable Internet).

### Fiber Optics
Transmits data as pulses of light through high-purity glass.
*   **Multi-mode**: Larger core; light bounces at many angles. Cheaper but subject to **Modal Dispersion** (limiting distance to ~2km).
*   **Single-mode**: Extremely thin core; light travels in a single direct path. Supports distances of 100+ km without amplification.
*   **Wavelength Division Multiplexing (WDM)**: The optical equivalent of FDM. Multiple independent data streams are sent simultaneously over a single fiber using different colors (wavelengths) of light.

---

## 2. Unguided Media (Wireless)

### Radio and Microwave
*   **Omnidirectional**: Signal radiates in all directions (e.g., Wi-Fi).
*   **Directional**: Focused "Line-of-Sight" beams (e.g., satellite links, terrestrial microwave towers).

### Wireless Challenges
*   **Signal Fading**: Strength decreases exponentially with distance ($1/r^2$).
*   **Multi-path Fading**: Signals bounce off buildings/walls and arrive at the receiver at slightly different times, causing self-interference.
*   **Interference**: Multiple senders using the same frequency band (e.g., Bluetooth and Wi-Fi on 2.4 GHz).

---

## 3. Transmission Modes (Duplexing)

| Mode | Simultaneous? | Direction | Example |
| :--- | :--- | :--- | :--- |
| **Simplex** | N/A | One-way only. | TV Broadcast, Keyboard. |
| **Half-Duplex** | No | Two-way, but must take turns. | Walkie-talkie, Wi-Fi. |
| **Full-Duplex** | **Yes** | Two-way simultaneously. | Modern Ethernet, Phone call. |

---

## 4. Hardware Interface: The Network Adapter
The **[[Network Interface Card (NIC)]]** is the physical hardware that implements the Physical and Link layers. It contains:
*   **Transceiver**: Converts digital bits from the host's bus into the physical signals required by the medium.
*   **MAC Controller**: Handles framing, error detection, and multiple access logic.
