multiple [[Process]]es in memory at once
- to overlap I/O and computation between processes easing the task of the application programmer
memory management then requires:
1. protection: restricts which address processes can use so they dont stomp on each other
2. fast translation: memory lookups must be fast in spite of protection scheme
3. fast context switching: when switching between jobs, updating memory hardware must be quick