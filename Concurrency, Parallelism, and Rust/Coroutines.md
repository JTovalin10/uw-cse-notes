## What is it
- cooperative routine: the routine will give us space for other routines to run on the processor
- `yields()` to give up the processor
- `current_routine` will start when it left off
- `spawn()` creates a new child
## Functions
- Spawn: creates a new coroutine and adds it to a global ready queue. May optioally switch to it
	- can or cannot switch to the new routine
	- consider case where it cna switch to the newly created routine or adds it to the queue
- yield(): 
	- suspends the current routine and switches to another coroutine in the global ready queue. If there are none, immediately return false
- concurrency is the expression of parallel
	- the coroutines are concurrent
- context switches dont require any OS involvement
	- compiler assembly
	- coroutine is just a bundle of data in the user-space stack
- Coroutines are non-preemptable
	- we assume the coroutines are cooperable
	- either executes immediately or when `yield()` is called
## Coroutines
- coroutines are represented with `struct Routine`
```c
struct Routine {
	void* saved_stack_pointer;
	uint64_t private_stack[STACK_ENTIRES];
	Routine* next_in_queue;
	
	// more
};
```
There is a global `ready_q` that will allow us to `enqueue` and `dequeue` Routines off the `ready_q`

```c
void routine_switch(Routine* next) {
	// save all registers
	
	// switch pointers
	
	// jump to new co-routine
	pop callee-saved register // goes into a different context
	ret
}
```

## Channels
- coroutines can send `SendableData` to each other through a `Channel*`
- `SendableData` is a typedef for `void*`
- There is no limit on how many coroutines can use a single shared `Channel*`
- Circular Array
- `send()` blocks until another coroutine consumes its message with `recieve()`
	- the other side must acknowledge when we send, the coroutine will be blocked until that happens
- `new_channel()` creates a new `Channel*`
- `Spawn()`: creates a new Channel* and passes it to the new coroutine
	- when a coroutine returns, its return value should be **forever** repeatedly sent over its channel
	- for simplicity, no need to free any memory
	- ways to do this
		- create a flag for the channel that tells us if the coroutine has returned
		- while loop that broadcast return value 
```c
SendableData func(Channel* ch) {
int64_t val = (int64_t) recieve(ch);// receive the 6 sent by main()
assert(val == 6);
return (SendableData) 7 // send forever on this coroutine forever;
}

int main() {
coroutine_init();

Channel* ch = spawn(func);
send(ch, (SendableData) 6); // blocks until someone on thsi channel recieves this 6

int64_t val = (int64_t) recieve(ch) // endless streams of 7s.
// needs a way to recieve the data if the channel is closed so it doesnt block
assert(val == 7)
val = (int64_t) recieve(ch); // set up stub that returns to something
assert(val == 7);
}
```
### Channels: blocking
spawn(func): switch, uncontrolled
yield(): doesnt, controlled, no guarantee what is run
send(c, data): **can** switch--whatever you call is not guaranteed to be ran next, but it will be scheduled. guarantees that the coroutine you called is run.
receive(c): can switch: if the value is already avaliable then it grabs it immeditaly. Otherwise, switches

sending and recieving creates DAG, ensure there is no cycle. 