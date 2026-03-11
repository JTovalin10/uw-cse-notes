# QoS and Admission Control: DiffServ and RSVP

To maintain the quality of **[[Multimedia Applications]]**, the network must provide specific **Quality of Service (QoS)** guarantees.

---

## Admission Control Strategies
The process of rejecting new calls if the network has insufficient bandwidth.

*   **Off-Path Admission Control**: Managed by a central entity like a **SIP Proxy**. It "guesses" path conditions based on topology.
*   **On-Path Admission Control**: Managed by routers along the actual data path using protocols like **RSVP**.

*Figure: Admission control using a session control protocol*

---

## [[RSVP]]: Resource Reservation Protocol
A receiver-driven protocol used to reserve bandwidth across a network path.
*   **PATH Message**: Sent from sender to receiver to identify the path.
*   **RESV Message**: Sent from receiver back to sender to request the reservation at each router hop.

---

## SIP-RSVP Interleaving
A coordination mechanism used to ensure resources are guaranteed before a phone starts ringing (**Ghost Ring** prevention).

1.  Negotiate codecs via **SIP**.
2.  Reserve bandwidth via **RSVP**.
3.  Proceed with the call only after **RESV** success.

*Figure: Coordination of SIP signalling and RSVP resource reservation*

---

## Traffic Differentiation
*   **Best Effort**: Standard Internet delivery with no guarantees.
*   **[[DiffServ]]**: Uses 6 bits in the IP header (**DSCP**) to mark packets for priority queuing.
