- One simple way to reduce [[Page Load Time (PLT)]]
	- browser runs multiple HTTP isntances in parallel
	- server is unchanged; already handled concurrent requests for many clients
- how does this help
	- single HTTP wasn't using network much
	- so parallel connection aren't slowed much
	- pulls in completion time of last fetch
	