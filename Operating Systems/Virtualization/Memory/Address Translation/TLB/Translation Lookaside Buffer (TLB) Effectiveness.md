# Why is TLB so effective
- TLB is tiny (32-128 entries)
- works because of locality
	- spatial
		- if you access a[0] you are likely to access a[1]. since they are on the same page the TLB already has the translation ready
	- temporal
		- if you access a variable now, you will likely access it again soon (loop). the translation is still in TLB cache
