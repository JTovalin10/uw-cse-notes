# CSE451: Policy

**Policy** describes *what* you are trying to achieve — the goal or rule that guides system decisions. A policy is the high-level decision about which outcome is desired (e.g., "the shortest job should run next," or "no process may read another process's memory"), leaving the actual enforcement of that decision to a [[Mechanism]].

Contrast with [[Mechanism]], which defines *how* that goal is carried out. Keeping policy separate from mechanism lets the OS swap out one scheduling policy for another (e.g., First-Come-First-Served versus Shortest Job First in [[Scheduling]]) while reusing the same underlying context-switching mechanism.

## Formal Definition
$$\text{Policy} : \text{Decision of "what"} \quad \neq \quad \text{Mechanism} : \text{Implementation of "how"}$$

## Simplified Explanation
Policy is the rule you want enforced; mechanism is the machinery that enforces it. Changing the scheduling policy (e.g., switching from round-robin to priority scheduling) shouldn't require rewriting the context-switch code — only the decision logic that picks the next process changes.

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| Policy | Configuration / decision logic / scheduling algorithm |
| Mechanism | Implementation / enforcement layer |

## Related
- [[Mechanism]] — the implementation that enforces policy
- [[Scheduling]] — scheduling algorithms are policies for CPU time allocation
- [[Operating System Roles]] — policies govern how the OS acts as referee, illusionist, and glue