We want to deliver frames reliably and recover discarded (lost) or corrupted frames.

While reliability can be provided at the link layer, many modern link technologies omit this function and push it up to the application layer.

## Pipe Capacity
```
delay x bandwidth
```
This represents the amount of data that could be in transit at any given time, often referred to as "keeping the pipe full."

# How We Achieve Reliability
1. **Acknowledgements (ACK)**
	1. A small control frame that a protocol sends back to its peer saying it has received an earlier frame
	2. A protocol can piggyback an ACK on a data frame it happens to be sending in the opposite direction
	3. The receipt of an ACK indicates to the sender that its original frame was delivered successfully
2. **Timeouts**
	1. If the sender does not receive an ACK after a reasonable amount of time, it retransmits the original frame

Using both of these together is called *Automatic Repeat Request* (ARQ).

## Stop-and-Wait
The simplest ARQ scheme: the sender transmits one frame and waits for an ACK before sending the next frame. If the ACK does not arrive in time, the sender times out and retransmits the original frame.
![[Pasted image 20260207012641.png]]
One subtlety: if the receiver's ACK is dropped but the receiver did successfully receive the frame, the sender will resend the same packet. To handle this, the header includes a 1-bit sequence number that alternates with each frame, allowing the receiver to detect duplicates.

The issue with stop-and-wait is the delay—we have to wait for each ACK, and it only allows one outstanding frame on the link at a time. Hence the maximum sending rate is:
```
Bits-per-Frame / Time-per-Frame
```

### Sliding Window
![[Pasted image 20260207013628.png]]

#### Sender Side
The sender assigns a sequence number to each frame and maintains three variables:
1. **SWS** (Send Window Size) — upper bound on the number of outstanding frames the sender can transmit
2. **LAR** (Last ACK Received) — the sequence number of the last acknowledgement received
3. **LFS** (Last Frame Sent) — the sequence number of the last frame sent

The sender must follow this invariant:
```
LFS - LAR <= SWS
```
When an ACK arrives, the sender moves LAR to the right, which allows it to transmit another frame. The sender associates a timer with each frame it transmits and retransmits the frame if the timer expires before an ACK is received. The sender must be willing to buffer up to SWS frames since it must be prepared to retransmit them until they are acknowledged.
![[Pasted image 20260207013610.png]]

#### Receiver Side
The receiver maintains:
1. **RWS** (Receive Window Size) — upper bound on the number of out-of-order frames the receiver is willing to accept
2. **LAF** (Largest Acceptable Frame) — the sequence number of the largest acceptable frame
3. **LFR** (Last Frame Received) — the sequence number of the last frame received

The receiver must follow this invariant:
```
LAF - LFR <= RWS
```

When a frame with sequence number `SeqNum` arrives, the receiver does:
1. If `SeqNum <= LFR` or `SeqNum > LAF` → discard the frame
2. If `LFR < SeqNum <= LAF` → the frame is within the receiver's window and is accepted
3. Let `SeqNumToAck` denote the largest sequence number not yet acknowledged such that all frames with sequence numbers less than or equal to it have been received. The receiver ACKs `SeqNumToAck`, even if higher-numbered packets have been received (this is a **cumulative** ACK)
4. Set `LFR = SeqNumToAck` and adjust `LAF = LFR + RWS`

**Problem**: when a timeout occurs, the amount of data in transit decreases because the sender cannot advance its window until the lost frame is acknowledged. This means that when packet loss occurs, the scheme is no longer keeping the pipe full. The longer it takes to notice that a packet loss has occurred, the more severe this problem becomes.

### Finite Sequence Numbers and Sliding Window
In practice, sequence numbers cannot grow infinitely large. The number of possible sequence numbers must be larger than the number of outstanding frames allowed.

This means the sending window can be no more than half as big as the number of available sequence numbers (when `RWS = SWS`):
```
SWS < (MaxSeqNum + 1) / 2
```

### Implementation of Sliding Window
```c
typedef uint8_t SwpSeqno;

typedef struct {
    SwpSeqno   SeqNum;   /* sequence number of this frame */
    SwpSeqno   AckNum;   /* ack of received frame */
    uint8_t     Flags;   /* up to 8 bits worth of flags */
} SwpHdr;

typedef struct {
    /* sender side state: */
    SwpSeqno    LAR;        /* seqno of last ACK received */
    SwpSeqno    LFS;        /* last frame sent */
    Semaphore   sendWindowNotFull;
    SwpHdr      hdr;        /* pre-initialized header */
    struct sendQ_slot {
        Event   timeout;    /* event associated with send-timeout */
        Msg     msg;
    }   sendQ[SWS];

    /* receiver side state: */
    SwpSeqno    NFE;       /* seqno of next frame expected */
    struct recvQ_slot {
        int     received;  /* is msg valid? */
        Msg     msg;
    }   recvQ[RWS];
} SwpState;

static int sendSWP(SwpState *state, Msg *frame)
{
    struct sendQ_slot *slot;
    char hbuf[HLEN];

    /* wait for send window to open */
    semWait(&state->sendWindowNotFull);
    state->hdr.SeqNum = ++state->LFS;
    slot = &state->sendQ[state->hdr.SeqNum % SWS];
    store_swp_hdr(state->hdr, hbuf);
    msgAddHdr(frame, hbuf, HLEN);
    msgSaveCopy(&slot->msg, frame);
    slot->timeout = evSchedule(swpTimeout, slot, SWP_SEND_TIMEOUT);
    return send(LINK, frame);
}

static int
deliverSWP(SwpState *state, Msg *frame)
{
    SwpHdr   hdr;
    char     *hbuf;

    hbuf = msgStripHdr(frame, HLEN);
    load_swp_hdr(&hdr, hbuf)
    if (hdr.Flags & FLAG_ACK_VALID)
    {
        /* received an acknowledgment—do SENDER side */
        if (swpInWindow(hdr.AckNum, state->LAR + 1, state->LFS))
        {
            do
            {
                struct sendQ_slot *slot;

                slot = &state->sendQ[++state->LAR % SWS];
                evCancel(slot->timeout);
                msgDestroy(&slot->msg);
                semSignal(&state->sendWindowNotFull);
            } while (state->LAR != hdr.AckNum);
        }
    }

    if (hdr.Flags & FLAG_HAS_DATA)
    {
        struct recvQ_slot *slot;

        /* received data packet—do RECEIVER side */
        slot = &state->recvQ[hdr.SeqNum % RWS];
        if (!swpInWindow(hdr.SeqNum, state->NFE, state->NFE + RWS - 1))
        {
            /* drop the message */
            return SUCCESS;
        }
        msgSaveCopy(&slot->msg, frame);
        slot->received = TRUE;
        if (hdr.SeqNum == state->NFE)
        {
            Msg m;

            while (slot->received)
            {
                deliver(HLP, &slot->msg);
                msgDestroy(&slot->msg);
                slot->received = FALSE;
                slot = &state->recvQ[++state->NFE % RWS];
            }
            /* send ACK: */
            prepare_ack(&m, state->NFE - 1);
            send(LINK, &m);
            msgDestroy(&m);
        }
    }
    return SUCCESS;
}

static bool
swpInWindow(SwpSeqno seqno, SwpSeqno min, SwpSeqno max)
{
    SwpSeqno pos, maxpos;

    pos    = seqno - min;       /* pos *should* be in range [0..MAX) */
    maxpos = max - min + 1;     /* maxpos is in range [0..MAX] */
    return pos < maxpos;
}
```

### Frame Order and Flow Control
The sliding window can serve three different roles:
1. **Reliable delivery** — reliably deliver frames across an unreliable link
2. **Preserving order** — the receiver ensures it does not pass a frame up to the next-higher-level protocol until it has already passed up all frames with a smaller sequence number
3. **Flow control** — a feedback mechanism by which the receiver is able to throttle the sender. This is done by augmenting the protocol so the receiver not only ACKs frames but also informs the sender of how many frames it has room to receive

## Concurrent Logical Channels
This approach is used in the ARPANET datalink protocol. It implies nothing about flow control, as the frames sent over a given link are not kept in any particular order.

The idea behind the protocol is to multiplex several logical channels onto a single point-to-point link and run the stop-and-wait algorithm on each channel independently.