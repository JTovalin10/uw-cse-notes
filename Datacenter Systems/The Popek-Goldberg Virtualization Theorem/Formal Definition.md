# The Popek-Goldberg Virtualization Theorem: Formal Definition

## Formal Analysis / Protocol Specification

### Formal Definition

Let $\mathcal{I}$ represent the set of all instructions in a physical processor architecture. The set is partitioned into disjoint sets of sensitive instructions ($\mathcal{I}_{\text{sensitive}}$) and innocuous instructions ($\mathcal{I}_{\text{innocuous}}$):

$$\mathcal{I} = \mathcal{I}_{\text{sensitive}} \cup \mathcal{I}_{\text{innocuous}}, \quad \text{where } \mathcal{I}_{\text{sensitive}} = \mathcal{I}_{\text{control}} \cup \mathcal{I}_{\text{behavior}}$$

Let $\mathcal{I}_{\text{privileged}}$ represent the set of instructions that hardware-trap when executed in User Mode ($M = u$).

#### Theorem 1 (Popek-Goldberg Virtualization Theorem)
For any conventional third-generation computer architecture, a Virtual Machine Monitor (VMM) may be constructed via direct execution if and only if the set of sensitive instructions is a strict subset of the set of privileged instructions:

$$\mathcal{I}_{\text{sensitive}} \subseteq \mathcal{I}_{\text{privileged}}$$

#### Theorem 2 (Popek-Goldberg Hybrid Virtual Machine Theorem)
A Hybrid Virtual Machine (HVM) may be constructed for any conventional third-generation computer in which the set of user-sensitive instructions (instructions sensitive in Supervisor Mode but innocuous in User Mode) is a subset of the set of privileged instructions:

$$\mathcal{I}_{\text{user-sensitive}} \subseteq \mathcal{I}_{\text{privileged}}$$

### Simplified Explanation

For a computer processor to support pure, high-performance virtualization, **every single instruction that can alter hardware resource controls or expose physical CPU status must automatically trigger a hardware alert (trap) when run in user mode**. If the CPU allows even one sensitive instruction to execute in user mode without trapping (or if it silently ignores the command), a hypervisor cannot maintain absolute control over the physical hardware, breaking virtualization.

## Industry Standard Terms

| Course Term | Industry / Standard Term |
| :--- | :--- |
| **Sensitive Instruction** | VM-Exit Triggering Instruction |

## Related

- [[Datacenter Systems/The Popek-Goldberg Virtualization Theorem|The Popek-Goldberg Virtualization Theorem]] — Hub for this topic
- [[Datacenter Systems/The Popek-Goldberg Virtualization Theorem/Virtual IO Emulation and Virtio|Virtual IO Emulation and Virtio]] — Full I/O emulation versus paravirtualized virtio
- [[Datacenter Systems/The Popek-Goldberg Virtualization Theorem/VT-x and EPT Extensions|VT-x and EPT Extensions]] — Hardware-assisted extensions
