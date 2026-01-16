the current status of the process
- new
- ready: waiting to be assigned to a CPU
	- could run, but another process has the CPU
- running: executing on a CPU
	- its the process that currently controls the CPU
- waiting: (aka blocked) waiting for an event, or a message from (or the completion of) another process
	- cannot make progress until the event happens
- terminated
As a process executes it moves from state to state
![[Pasted image 20260116004012.png]]

[[States of a user process]]
