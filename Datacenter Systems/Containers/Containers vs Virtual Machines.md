# Containers: Containers vs Virtual Machines

Containers and [[Datacenter Systems/Virtual Machines|Virtual Machines]] draw the isolation boundary at different layers, so they trade off performance, security, and cost differently.

## Performance

### Creation and Teardown
Containers are created and destroyed faster.
- **Container start**: Process creation, provided the file system is loaded.
- **VM start**: Load an entire OS and file system image.

### Finer-Grained Resource Sharing
- A container is lighter weight because switching the CPU between containers is just a **process context switch**.
- Switching the CPU between VMs is a **virtual machine switch**, which involves a lot more state: the TLB load, registers, and more.
- Lightweight is also better for software engineering, since it is cheap to start, test, and discard environments.

## Security

### Attack Surface
- The hardware/software interface a VM exposes is a lot more difficult to attack than the syscall interface a container exposes.
- The syscall interface is complex and runs in kernel mode. The instruction-level interface is simpler and its effects are smaller.
- The Linux API is therefore more vulnerable to attack than the virtual machine API.
- With paravirtualization, the interface between guest and hypervisor grows and the attack surface becomes larger.

### Keeping the OS Up to Date
- With containers, the OS can be kept up to date centrally: the OS is shared, and the administrator decides which one. This can be good or bad: security patches apply everywhere, but there may be compatibility issues.
- With VMs, the guest OS may not need to be kept up to date, because the hypervisor boundary still protects the host (the guest owner decides).
- Most security vulnerabilities come from insider attacks or phishing rather than from the isolation boundary itself.

## Cost

| Aspect | Virtual Machines | Containers |
| :--- | :--- | :--- |
| Memory footprint | A copy of Linux per application | Shared kernel |
| Startup / resource sharing | More expensive | Cheap |
| Overhead | Hardware support reduces it | Substantial Linux kernel changes were needed |
| Isolation | Strong | Kernel vulnerabilities allow apps to steal data from each other through shared kernel resources |
| Performance isolation | Easier | More difficult |
| Migration / checkpoint-restore | Trivial | Difficult |
| Kernel requirement | Each VM brings its own | All processes must run on some type of kernel |

Notes on the container costs:
- **Shared kernel resources** are the root of the security cost (see the cache attack in [[Datacenter Systems/Containers/Cgroups|Cgroups]]).
- **Performance isolation** is harder because containers compete inside one kernel, rather than being partitioned by hardware-enforced VM boundaries.
- **Process migration and checkpoint/restore** are difficult because a container's state is entangled with the shared kernel, whereas a VM's full state is a self-contained image.

## Industry Standard Terms

| Course Term | Industry / Standard Term |
| :--- | :--- |
| Container vs VM isolation | Process isolation vs hardware isolation |
| Process migration, checkpoint/restore | CRIU (Checkpoint/Restore In Userspace) |
| Attack surface | Syscall surface (mitigated by seccomp filters, gVisor, Kata Containers) |

## Related

- [[Datacenter Systems/Containers|Containers]] — Hub
- [[Datacenter Systems/Containers/OS-Level Virtualization|OS-Level Virtualization]]
- [[Datacenter Systems/Containers/Serverless Functions and Enclaves|Serverless Functions and Enclaves]] — Where industry is heading
- [[Datacenter Systems/Virtual Machines|Virtual Machines]]
- [[Datacenter Systems/Execution Environments and Virtualization|Execution Environments and Virtualization]]
