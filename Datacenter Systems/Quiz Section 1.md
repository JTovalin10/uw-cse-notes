## Microservice
- each microservice is an api call
- decouples each service where each has its own database
	- makes it easier to work on one service
	- provides better fault isolation
- each microservice can have its own programming language
	- rust or C/C++ for low-latency
	- frontend - typescript or javascript
- has natural higher-latency due to RPC or HTTP request for each service
- easier to limit fault in each microservice
	- harder to trace cross-network calls
## Monolith
- lower latency
- 80% less resources for the same performance
- better for small applications
## [[Remote Procedure Call (RPC)]] 
- service communicate using RPC
- RPC allows calling a function on a remote server as if it were local 
### Serialization in RPC
- **Purpose**: converts complex function arguments into a format suitable for network transfer
- Steps
	- note: serializes means binary
	- client: serializes function argument into binary format
	- Network: transmits the serialized data into the server
	- Server: Deserializes data, run function, and sends back a serialized response
- in programming languages you can pass by value or reference. In RPC, everything is pass by value type
### gRPC Protocol Buffers
What is a protocol buffer: 
```proto
service Gretter {
	rpc SayHello (HelloRequest) returns (HelloReply) {}
}

messages HelloRequest {
	string name = 1;
}

messages HelloReply {
	string name = 2;
}
```
## Containers
- containers provide an isolated env for your applications
- They are widely used in datacenters
- In labs, each microservice will be deployed in its own container
### Docker and Kubernetes
- Docker: A platform for building and running containers
	- shares same host OS
- Kubernetes: A system for automating the deployment, scaling, and managing in distributed environments
	- each Docker container becomes a pod in Kubernetes
## Golang
- this classes uses go
- Go supports lightweight concurrency: many goroutines can run at once
- Designed for high-performance networking
- implement microservices in Golang
### Google Cloud Platform (GCP)
- our labs will be impleemnted in GCP
- each group will have a VM instance
- stop the VM instance when not in use to avoid exhausting credits
- 