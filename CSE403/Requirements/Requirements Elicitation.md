# CSE 403: Requirements Elicitation

**Requirements elicitation** is the process by which developers gather, clarify, and negotiate system requirements with clients and stakeholders. It is inherently iterative and conversational: the client supplies ideas, target users, and desired behavior; the developer responds with questions, suggestions, diagrams, and feasibility assessments. This back-and-forth loop eventually converges on a stable set of requirements — a shared contract of *what* the system must do.

```mermaid
flowchart TD
    subgraph negotiation [Requirements Negotiation]
        C([Client])
        D([Developer])
        C -->|"ideas, target users, desired behavior"| D
        D -->|"questions, suggestions, diagrams, feasibility"| C
    end
    negotiation -->|converges| R[Requirements\n(What)]
    R --> DM[Data Model\n(How)]
    R --> SA[SW Architecture and Design\n(How)]
    DM <--> SA
```

Once requirements are stable, the team splits into two parallel "how" tracks: the [[CSE403/Design/Data Modelling and ER Diagrams|data model]] and the [[CSE403/Software Design and Architecture/Software Architecture Patterns|software architecture]].

## Related

- [[CSE403/Requirements/Requirements Engineering]]
- [[CSE403/Design/Data Modelling and ER Diagrams]]
- [[CSE403/Software Process/SDLC Models]]
