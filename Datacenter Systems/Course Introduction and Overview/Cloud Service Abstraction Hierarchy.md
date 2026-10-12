# Course Introduction and Overview: Cloud Service Abstraction Hierarchy

## Cloud Service Abstraction Hierarchy

Cloud providers structure compute and storage into layered abstractions:

| Abstraction Layer | Core Capability | Provider Responsibility | Customer Responsibility | Production Examples |
| :--- | :--- | :--- | :--- | :--- |
| **IaaS** (Infrastructure as a Service) | Raw compute instances, virtual private clouds (VPCs), and block/object storage. | Physical hardware, virtualization hypervisor, datacenter facilities. | Guest OS, runtime, application code, data, networking rules. | AWS EC2 / S3, GCP Compute Engine, Azure VMs |
| **PaaS** (Platform as a Service) | Managed application runtime, managed databases, pub/sub event buses. | OS management, automatic scaling, patching, runtime maintenance. | Application logic, schemas, configurations. | Google App Engine, AWS Elastic Beanstalk, Firebase |
| **FaaS** (Function as a Service / Serverless) | Ephemeral, event-triggered function execution. Decomposes apps into fine-grained tasks. | Complete container lifecycle, cold starts, elastic micro-billing per millisecond. | Pure stateless function logic. | AWS Lambda, Google Cloud Functions, Cloudflare Workers |
| **SaaS** (Software as a Service) | End-user applications accessible via web and mobile APIs. | Entire software stack, high availability, disaster recovery, security. | User configuration, access management. | Google Workspace, Microsoft 365, Salesforce |

## Related

- [[Datacenter Systems/Course Introduction and Overview|Course Introduction and Overview]] — Hub for this topic
- [[Datacenter Systems/Course Introduction and Overview/Datacenter Challenges and Software Delivery|Datacenter Challenges and Software Delivery]] — Motivation, engineering challenges, and the evolution of software delivery
- [[Datacenter Systems/Course Introduction and Overview/Cloud Operator Pyramid of Concerns|Cloud Operator Pyramid of Concerns]] — Google's pyramid of operator concerns
