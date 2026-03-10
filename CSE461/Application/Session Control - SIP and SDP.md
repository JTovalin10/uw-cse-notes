# Session Control: SIP and SDP

Session control manages the logic of establishing, maintaining, and tearing down communication channels for **[[Multimedia Applications]]**.

---

## [[SDP]]: Session Description Protocol
A text-based (**ASCII**) protocol used to describe media parameters. It is typically encapsulated in **SIP** payloads.
*   **Key Fields**:
    *   `c=`: Connection information (IP address, Multicast group).
    *   `m=`: Media description (Type, Port, Transport, Codec).
    *   `t=`: Timing information.

[Image: Session directory tool displaying information extracted from SDP messages]

---

## [[SIP]]: Session Initiation Protocol
An application-layer protocol (**Port 5060**) modeled after HTTP for initiating real-time sessions.

### Architecture
*   **User Agent (UA)**: The endpoint (IP phone or software).
*   **Proxy Server**: Routes requests to locate users.
*   **Registrar**: Binds a logical URI (e.g., `sip:user@domain`) to a physical IP address.

### Core Messages
*   `INVITE`: Initiates a session.
*   `200 OK`: Session accepted.
*   `ACK`: Final handshake; allows media to flow **directly** between peers.
*   `BYE`: Terminates the session.

![[Pasted image 202603061.07.59 PM.png]]
*Figure: Message flow for a basic SIP session*

---

## [[H.323]]
An alternative ITU-T standard for multimedia over packet networks.
*   **Gatekeeper**: Performs address translation and **Admission Control**.
*   **Gateway**: Bridges H.323 to the traditional phone network (PSTN).

[Image: Devices in an H.323 network including Terminals and Gatekeepers]
