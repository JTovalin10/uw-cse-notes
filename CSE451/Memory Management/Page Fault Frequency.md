PFF is a variable-space algorithm that uses a more ad hoc approach where it attempts to equalize the fault rate among all processes and to have a tolerable system-wide fault rate

1. monitor the fault rate for each process
2. if fault rate is above a given threshold, give it more memory
	1. so that it faults less
3. if the fault rate is below threshold, take away memory
	1. should fault more, allowing someone to fault less