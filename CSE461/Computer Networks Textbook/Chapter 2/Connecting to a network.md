The issue: how do we connect nodes into a network? Can be wired or wireless, covering small or wide areas.

Five problems to solve for communication:
1. **Encoding** — encode bits so they can be understood by receiving nodes (e.g. sender transmits int32_t but receiver interprets uint32_t)
2. **Framing** — package bits into complete messages ([[Frame]]s) that can be delivered to end nodes
3. **Error detection** — frames can be corrupted during transmission; must detect and take action
4. **Reliable delivery** — recover from lost or corrupted frames
5. **Media access control** — mediate access when multiple hosts share a link
