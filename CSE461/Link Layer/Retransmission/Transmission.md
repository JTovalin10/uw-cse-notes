Continuous Sending (no ACK wait)
```
Total = Handshake + Transmission Time + Propagation
      = (Handshake RTTs × RTT) + (File Size / Bandwidth) + (RTT / 2)
```
Stop and wait (wait for ACK after each packet)
```
Total = Handshake + First (n-1) packets + Last packet
      = (Handshake RTTs × RTT) + (n-1)(Transmit + RTT) + (Transmit + RTT/2)
```
- n = number of packets = File Size / Packet Size
- Transmit = Packet Size / Bandwidth
Note for propagation: Speed of light must be in meters

Width of a bit
```
Bit Width = 1 bit / Bandwidth
```