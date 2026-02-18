## IP Service Model
The service model is the host-to-host service we want to provide for an internetwork. We want to make it undemanding enough that just about any network technology that might turn up in an internetwork would be able to provide the necessary service.

### Parts of the Service Model
Sometimes called **best effort** as IP makes every effort to deliver [[Datagram]]s but makes no guarantees.
1. **Addressing scheme** - provides a way to identify all hosts in the internetwork
2. **[[Datagram]]s model of data delivery**

### Datagram Delivery
This is fundamental to the Internet Protocol.

We use datagrams despite the best-effort policy because this is the simplest service we can ask for. In the best case, if the network is reliable then we always deliver; if the network is unreliable then we don't put any extra effort into it.

**"Run over anything"** is IP's most important characteristic.

See also: [[IP Packet Format]], [[IP Fragmentation and Reassembly]]
