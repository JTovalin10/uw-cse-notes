# CSE344: Multi-Tier Architecture

Multi-tier architecture describes how a [[Database Applications|database application]] is physically deployed across machines — from everything-on-one-machine to fully separated application and database servers.

## Two Types of Workloads
![[Two Types of Workloads.png]]

The two workload categories that drive architecture choice:
- **OLTP** (**Online Transaction Processing**) — many short, concurrent read/write transactions (e.g., banking, e-commerce)
- **OLAP** (**Online Analytical Processing**) — long analytical queries over large historical data (e.g., data science, reporting)

## Single Client

**Single-client** means the application and data are on the same machine (e.g., SQLite, Postgres).
- Mostly **OLAP** applications — small-scale data science
- OLTP is also possible

## Client-Server

A **two-tier architecture** has a server running a resource shared among multiple (sometimes concurrent) users.
- The server runs the DBMS and manages the shared data
- Clients connect over the network to issue queries
- Concurrency is handled by the DBMS (see [[ACID Properties]] and [[Interleaving and Concurrency Control]])

## Related
- [[Database Applications]] — what a database application is
- [[Password Handling]] — securing user credentials as data crosses tiers
- [[ACID Properties]] — the guarantees the DBMS offers to concurrent clients
