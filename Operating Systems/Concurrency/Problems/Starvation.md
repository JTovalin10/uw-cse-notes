# CSE451: Starvation

**Starvation** is when a thread or process is indefinitely prevented from making progress because it never gets access to a resource it needs (CPU time, a lock, etc.), even though the system is not **[[Operating Systems/Concurrency/Problems/Deadlocks|Deadlocked]]**.

## Starvation vs. Deadlock

The key distinction is that in a **[[Operating Systems/Concurrency/Problems/Deadlocks|Deadlock]]**, no thread in the affected set can make progress — the system is permanently stuck in a circular wait. In starvation, the *system as a whole* continues to make progress (other threads are running and finishing work), but one particular thread is repeatedly passed over and never gets its turn. The scheduler or lock implementation keeps favoring other threads, so the starved thread waits indefinitely even though the resource it needs does eventually become free — just never for it.

This commonly arises from unfair scheduling policies or unfair lock implementations: if a **[[Operating Systems/Concurrency/Synchronization/Mechanics/Locks/Locks|Lock]]** or **[[Operating Systems/Concurrency/Synchronization/Mechanics/Critical Sections/Critical SectionsComponents/Semaphores|Semaphore]]** repeatedly grants access to newly-arriving threads ahead of ones that have been waiting longer, a waiting thread can be starved even though the lock is being actively used and released by others.

## Related

- [[Operating Systems/Concurrency/Problems/Deadlocks|Deadlocks]] — related failure mode where no thread can progress
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Locks/Locks|Locks]] — lock fairness affects starvation risk
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Critical Sections/Critical SectionsComponents/Semaphores|Semaphores]] — semaphore wake-up ordering affects starvation risk

## Industry Standard Terms

| CSE451 Term | Industry / Standard Term |
| :--- | :--- |
| **Starvation** | Indefinite postponement / resource starvation |
| **Unfair scheduling** | Non-FIFO / priority-based scheduling starvation |
