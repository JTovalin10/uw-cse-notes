# Microservices: gRPC Call Trace

## Concrete Walkthrough & Execution Trace

### Tracing a Complete gRPC Call from Client to Server

```
Scenario: Client invokes Greeter.SayHello(name="Alice")

1. Client Call Initialization:
   - Application calls client_stub.SayHello(ctx, &HelloRequest{Name: "Alice"}).

2. Protobuf Serialization:
   - Stub invokes generated marshaler.
   - Field tag 1, Wire Type 2 (Length-delimited):
       Header byte: (field_number << 3) | wire_type = (1 << 3) | 2 = 0x0A
       Length byte: 0x05 (length of "Alice")
       Payload:     0x41 0x6C 0x69 0x63 0x65 ("Alice")
   - Output binary buffer: [0x0A, 0x05, 0x41, 0x6C, 0x69, 0x63, 0x65] (7 bytes total).

3. HTTP/2 Framing & Transmission:
   - Client gRPC runtime prepends 5-byte gRPC frame header:
       [0x00] (Compression flag: uncompressed)
       [0x00, 0x00, 0x00, 0x07] (Length: 7 bytes)
   - Wraps into an HTTP/2 DATA frame on active HTTP/2 stream #3.
   - Pushes TCP segments through Linux kernel socket out physical NIC.

4. Server Ingestion & Deserialization:
   - Server Linux kernel receives TCP packet; epoll notifies Go netpoller.
   - Server gRPC runtime parses HTTP/2 stream #3 and extracts the 7-byte Protobuf payload.
   - Generated unmarshaler parses tag 0x0A, allocates a Go struct:
       req := &HelloRequest{Name: "Alice"}

5. Application Execution:
   - Server dispatches a new Goroutine to invoke the user-implemented method:
       func (s *Server) SayHello(ctx, req) (*HelloReply, error) {
           return &HelloReply{Message: "Hello " + req.Name}, nil
       }

6. Return Path:
   - Response serialized to Protobuf bytes: [0x0A, 0x0B, "Hello Alice"].
   - Framed into HTTP/2 DATA frame and transmitted back across TCP socket.
   - Client stub unmarshals bytes and returns &HelloReply{Message: "Hello Alice"} to caller.
```

## Industry Standard Terms

| Course Term | Industry / Production Term |
| :--- | :--- |
| **Stub / Skeleton** | Client Proxy / Server Dispatcher |

## Related

- [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure|Microservices]] — Hub for this topic
- [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure/Go and GCP Lab Infrastructure|Go and GCP Lab Infrastructure]] — Go systems programming and GCP lab setup
- [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure/Failure Modes|Failure Modes]] — Schema drift, cascading timeouts, OOMKilled, and credit exhaustion
