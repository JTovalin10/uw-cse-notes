# Consider
- what is different between a normal interaction and the exploit
- What parts are relevant to that interaction
	- add logging/debugging
- develop theories about what is happening
- test your theories
# Goals
- Identify what the exploit accomplishes
- Identify the major steps the exploit takes
- Find the specific code components (if any) that are responsible
	- AKA: The vulnerability
	- consider that an exploit might leverage missing features
- Find "nearby" bugs
	- if you find the most-responsible line of code, is it still vulnerable?
# Terminology
- Zero Days or o-day
	- bugs that are made known at the same time as the vendor is told
- CVE Number
	- Common Vilnerabilities and Exposures
- CWE
	- Common Weakness Enumeration
	- Standard list of bug types
- CVSS
	- Common Vulnerability Scoring System
	- very limited utility as scored barely correlate with impact
- 