# Bandwidth and Latency
distance = length over the wire over which data will travel
size = size of packet
bandwidth = bandwidth at which the packet is transmitted
NOTE: if packet only contains one bit and its a single link, then trasmit and queue dont matter
```
latency = propagation + transmit + queue
proagation = distance/speed of light
transmit = size / bandwidth
```
network performance is measured with bandwidfth and latency,

bandwidth is measured in Hz (width of frequency band)

latency is measured in terms of time. 

round-trip time(RTT): measures how long it takes to send a message from one end of a network to the other and back
# Delay x Bandwidth Product
to find the volume of the network pipe we can measure it with delay x bandwidth product, which gives us the max number of bits that could be in transit through the pipe at any given instance
Ex:
one way latency of 50ms and a bandwidth of 45 Mbps
$$
50 \times 10^{-3} \times 45 \times 10^6 \text{bits/sec}
$$
this is important to know when making high-performance networks as it corresponds to how many bits the sender must ransmit before the fitst bit arrives at the reciever

# High-speed networks
```
throughput = transfersize / transfertime

transfertime = RTT + 1/bandwidth x transfersize\
```