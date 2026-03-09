# Real-Time Transport Protocol (RTP)

**Real-Time Transport Protocol (RTP)** is a specialized transport-layer protocol designed for the delivery of **Isochronous** (real-time) data, such as audio and video. It provides end-to-end delivery services including payload type identification, sequence numbering, and timestamping to facilitate jitter removal and media synchronization.

## Low-Level Primer: The RTP Stack
*   **Transport over Transport**: RTP typically runs over **[[User Datagram Protocol (UDP)]]**. It "outsources" basic demultiplexing (port mapping) to UDP while providing the timing and sequencing logic that UDP lacks.
*   **Port Pairings**: RTP and its companion control protocol (**RTCP**) use consecutive UDP ports.
    *   **Even Port**: RTP Data.
    *   **Odd Port (RTP + 1)**: RTCP Control.
*   **Application-Level Framing (ALF)**: An architectural principle where the application understands its own data boundaries (e.g., video frames) and maps them directly to transport units to optimize error recovery.

[Image: Protocol stack showing RTP running over UDP/IP]

---

## RTP Header Format
The fixed RTP header is **12 bytes** long, followed by optional source identifiers.

| Field | Size | Purpose |
| :--- | :--- | :--- |
| **Version (V)** | 2 Bits | Current version is **2**. |
| **Padding (P)** | 1 Bit | If set, the last byte of the payload contains a count of padding bytes to ignore. |
| **Extension (X)** | 1 Bit | If set, a variable-length extension header follows the fixed header. |
| **CSRC Count (CC)** | 4 Bits | Number of **Contributing Source** identifiers following the fixed header. |
| **Marker (M)** | 1 Bit | Profile-specific; used for frame boundaries or start of "talkspurts." |
| **Payload Type (PT)** | 7 Bits | Identifies the media format (e.g., G.711, H.261). |
| **Sequence Number** | 16 Bits | Increments by 1 for each packet; used to detect loss and reorder packets. |
| **Timestamp** | 32 Bits | Reflects the sampling instant of the first byte in the packet. Used for playback timing. |
| **SSRC** | 32 Bits | **Synchronization Source**; uniquely identifies the source of the stream. |
| **CSRC** | 0–60 Bytes | **Contributing Sources**; IDs of sources that were mixed into this stream. |

[Image: RTP header format diagram showing bit-level field alignment]

### Timing and Synchronization
*   **Clock Granularity**: The units of the **Timestamp** field are not fixed (e.g., seconds). They are defined by the **Media Profile**. An 8-kHz audio stream might "tick" every 125 μs.
*   **Jitter Removal**: The receiver uses timestamps to place incoming packets into a **Playout Buffer**, ensuring they are played back at the correct temporal intervals regardless of network delay variance.

---

## RTCP: Real-Time Control Protocol

**RTCP** provides a control channel for the RTP session. It scales its transmission frequency to ensure control traffic consumes no more than **5%** of the total session bandwidth.

### Core Functions
1.  **QoS Feedback**: Reports on packet loss, jitter, and round-trip delay.
2.  **Intermedia Synchronization**: Synchronizing different streams (e.g., audio and video) from the same sender.
3.  **Identification**: Mapping the transient **SSRC** to a persistent **Canonical Name (CNAME)**.

### RTCP Packet Types

| Type | Name | Purpose |
| :--- | :--- | :--- |
| **SR** | **Sender Report** | Active senders report transmission stats (packet/byte counts) and absolute wall-clock time. |
| **RR** | **Receiver Report** | Non-senders report reception stats (loss fraction, cumulative loss, highest sequence number, jitter). |
| **SDES** | **Source Description** | Carries the **CNAME** (e.g., `user@host`) and other metadata (email, phone). |
| **BYE** | **Goodbye** | Signals the end of a participant's involvement in the session. |
| **APP** | **Application-Defined** | Custom experimental or application-specific control data. |

### The Lip-Sync Problem (Intermedia Sync)
Audio and video streams from the same source often have different clock granularities and random initial offsets.
*   **Solution**: The **RTCP Sender Report** contains a mapping between the **RTP Timestamp** (clock-relative) and the **NTP Timestamp** (wall-clock absolute time). This allows the receiver to align the timelines of both streams for perfect "lip-sync."

## Key Terminology
*   **Mixer**: A node that decodes multiple RTP streams, combines them into one (e.g., mixing audio), and resynchronizes the timing. It lists itself as the **SSRC** and the original sources as **CSRCs**.
*   **Translator**: A node that forwards RTP packets without changing their SSRC (e.g., a firewall gateway or a transcoder that changes the payload format).
*   **Talkspurt**: A continuous burst of audio data followed by silence. Receivers use silence periods to adjust the playout buffer size without audible distortion.

## Related Topics
*   **[[User Datagram Protocol (UDP)]]**: The standard substrate for RTP.
*   **[[Quality of Service (QoS)]]**: Critical for ensuring RTP packets meet their tight latency bounds.
*   **[[Multimedia Applications]]**: The primary users of RTP (SIP, H.323).
