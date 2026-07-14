# CSE451: Mechanism

**Mechanism** describes *how* you achieve your goal — the low-level procedure or implementation that carries out a task. A mechanism is the concrete machinery (a data structure, an algorithm, a hardware feature) that actually performs an operation, independent of the reasoning for why that operation should happen a particular way.

Contrast with [[Policy]], which defines *what* goal you are trying to achieve. A well-designed operating system separates mechanism from policy so that the same underlying machinery can be reused to satisfy different goals — for example, the mechanism of a [[Base and Bounds|Base and Bounds]] register can enforce many different memory protection policies without the hardware itself changing.

## Formal Definition
$$\text{Mechanism} : \text{Implementation of "how"} \quad \neq \quad \text{Policy} : \text{Decision of "what"}$$

## Simplified Explanation
Mechanism is the tool; policy is the decision about when and how to use the tool. A lock (mechanism) can enforce many different rules about who is allowed in a room (policy) without the lock itself needing to change.

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| Mechanism | Implementation / enforcement layer |
| Policy | Configuration / decision logic |

## Related
- [[Policy]] — the goal or rule that mechanism enforces
- [[Operating System Roles]] — the OS uses mechanisms to implement referee, illusionist, and glue roles
- [[Base and Bounds]] — a concrete mechanism that can enforce multiple different protection policies