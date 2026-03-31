# Database Design: Multi-Tier Architecture

## Two Types of Workloads
![[Two Types of Workloads.png]]

## Single Client

**Single-client** means the application and data are on the same machine (e.g., SQLite, Postgres).
- Mostly **OLAP** (**Online Analytical Processing**) applications — small-scale data science
- OLTP is also possible

## Client-Server

A **two-tier architecture** has a server running a resource shared among multiple (sometimes concurrent) users.

## Related
- [[Database Applications]] — what a database application is
