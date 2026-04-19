# CSE484: Anonymity in Data

## What is Anonymity?

**Anonymity** is the state of not being identifiable within a set of subjects.
- You cannot be anonymous by yourself — anonymity requires blending into a crowd.
- The goal is to **hide your activities among other similar activities**.
- **Unlinkability:** The inability to link an action to a specific identity.
- **Unobservability** (harder to achieve): An observer cannot even tell whether a certain action took place at all.

## Anonymity in Data Collection and Datasets

A common approach to publishing data while protecting individuals is to **remove directly identifying information** such as names, Social Security Numbers (SSNs), and addresses.

The fundamental problem is **pseudonym linkage** — even without explicit identifiers, records can often be re-identified by combining them with **auxiliary data** (e.g., public records, other datasets).

![[Screenshot 2025-12-02 at 3.54.51 PM.png]]

## How to Collect and Release Data Safely

- Releasing data always poses a privacy risk, because auxiliary data from other sources can be used for linkage attacks.
- Even if noise is added to individual records, aggregation can cancel out the noise and reveal true patterns.
- There is an inherent tension between **data utility** (the data should be useful) and **privacy** (individuals should not be re-identifiable).

## Related

- [[CSE484/Anonymity and Privacy/Anonymity in networks & messaging|Anonymity in Networks and Messaging]] — hiding identity at the network level
- [[CSE484/Usable Security/Usable Security|Usable Security]] — people's privacy behaviors in practice 