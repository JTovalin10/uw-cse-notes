# Database Design: Database Applications

## Interacting with the Database

There are multiple ways of interacting with a database:
- Ad-hoc SQL queries at a terminal or web UI
- Pre-configured queries, possibly in an analyst UI
- Special-purpose application

## Database Applications

A **database application** is an application written in a general-purpose programming language that includes calls to the DBMS.
- Uses general-purpose tools and programming languages
- Is an application, not a database
	- can do more than just read/write to a database
	- e.g., verifies a user exists by querying the database, then charges their credit card and sends tracking info to UPS

## Related
- [[Multi-tier Architercture]] — how database applications are deployed across tiers
- [[Password Handling]] — securely handling user credentials in database applications
