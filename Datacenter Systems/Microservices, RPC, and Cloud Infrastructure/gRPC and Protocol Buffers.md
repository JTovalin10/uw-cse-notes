# Microservices: gRPC and Protocol Buffers

## gRPC and Protocol Buffers (Protobuf)

Google's **gRPC** framework uses **Protocol Buffers** as its Interface Definition Language (IDL) and binary serialization wire format. 

1. **Schema Definition (`.proto`)**: Defines strict contracts for service RPC methods and message types:
   ```proto
   syntax = "proto3";

   package datacenter.greeter;

   // The greeting service definition.
   service Greeter {
     // Sends a greeting RPC request and receives a greeting reply.
     rpc SayHello (HelloRequest) returns (HelloReply) {}
   }

   // The request message containing the user's name.
   message HelloRequest {
     string name = 1;
   }

   // The response message containing the greetings.
   message HelloReply {
     string message = 1;
   }
   ```
2. **Field Tags (`= 1`, `= 2`)**: Numbers assigned to fields are **tags** used to identify fields in the compact binary wire format. Field names are not transmitted over the wire, drastically minimizing payload size.
3. **Transport via HTTP/2**: gRPC runs on top of HTTP/2, providing:
   - **Stream Multiplexing**: Concurrent bidirectionally streaming requests and responses over a single underlying TCP connection without head-of-line blocking at the application layer.
   - **Binary Framing & Header Compression**: Uses HPACK compression on metadata headers to save bandwidth.

## Formal Analysis / Protocol Specification

### Protocol Buffer Wire Encoding (Key-Value Framing)

#### Formal Definition
A serialized Protocol Buffer message is a stream of key-value pairs. Each field's key on the wire is encoded as a variable-length integer (varint) representing:

$$\text{Key} = (\text{field\_number} \ll 3) \mid \text{wire\_type}$$

Where $\text{wire\_type}$ is defined by the 3 lowest bits:

| Wire Type | ID | Meaning | Used For |
| :--- | :--- | :--- | :--- |
| `0` | `VARINT` | Variable-length integer (1–10 bytes). | `int32`, `int64`, `uint32`, `bool`, `enum` |
| `1` | `I64` | Fixed 8 bytes. | `fixed64`, `sfixed64`, `double` |
| `2` | `LEN` | Length-delimited: varint length followed by data bytes. | `string`, `bytes`, embedded messages, packed arrays |
| `5` | `I32` | Fixed 4 bytes. | `fixed32`, `sfixed32`, `float` |

For a length-delimited field (`wire_type = 2`), the byte stream layout is:

$$\text{Stream} = [\text{Key}] \parallel [\text{Length}] \parallel [\text{Bytes}_{1 \dots \text{Length}}]$$

#### Simplified Explanation
Protobuf saves network space by avoiding sending field names like `"username"`. Instead, it shifts the field number left by 3 bits and packs the data-type code into the last 3 bits. This creates a tiny 1-byte header for fields numbered 1 through 15, followed immediately by the payload.

## Related

- [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure|Microservices]] — Hub for this topic
- [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure/RPC and Pass-by-Value Semantics|RPC and Pass-by-Value Semantics]] — Remote procedure call semantics
- [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure/Docker and Kubernetes|Docker and Kubernetes]] — Containers and orchestration
