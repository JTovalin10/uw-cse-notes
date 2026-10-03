## Couroutines
### Definition
- **functions that you can pause and resume**
	- 2 books you are reading
	- mark the book when you transition to the other book
	- open the other book and then bookmark and resume where you were in the other book
	- requires some bookkeeping to remember
	- NOTE: we cannot switch away from Active unless active cooperated `yields`
		- this is where cooperative comes in
		- not an interruption-based model of concurrency--cannot stop in the middle, it has to `yield`. The active coroutine **has** to `yield`. Which compares to OS timer-based interrupt
- cooperative routines
- an abstraction for expressing concurrent operations
- Today, only one worker or core that has to do everything
- logical way to program that respectes dependencies. Good for parallelism
### API
```c
// called from within a coroutine to suspend execution
yield()

// creates a new coroutine
spawn()

// waits for a coroutine to finish
join()
```

### Examples
```rust
fn my_routine() {
	for i in 0..5 {
		print("!")
	}
}

fn main1() {
	h = spawn(my_routine) // handle (address) for coroutine, we are not calling the functin to be executed at this moment (spawn may yield initally)
	yield() // main yields
	join(h) // waits for coroutine to finish
}
```
```rust
fn my_routine() {
	for i in 0..5 {
		print("!")
		yield()
	}
}

// Answer: any permutation of ?!
// general concpet yeild: the behavior is defined y the speciifc coroutine library
// so in HW1, yield() does have to yield but for code examples no
fn main2() {
	h = spawn(my_routine) // handle (address) for coroutine, we are not calling the functin to be executed at this moment (may happen though)
	for i in 0..5 {
		print("?")
		yield()
	}
	join(h) // waits for coroutine to finish
}
```
### Many flavors of coroutines
- everything is defined by the implementation
	- does yield return data
	- can regular functions yield
	- do yields specifiy a desitnation routine
	- Does spawning a routine have to switch to it, or not? could it?
	- does yield have a switch to a new routine
### Some truths hold constants
- a coroutine will run, uninterrupted, until it gets blocked or voluntarily yields
	- example of blocking: join(h)
	- we assue our code voluntarily yields often
- what if a coroutine never calls yield
	- can loop forever
	- can yield when it finishes execution
### For homework 1
- spawn: can swtich to a new coroutine, but it doesnt have to
- yield: must switch to a diferent coroutine, if pssoible
	- if returns whether or not it successfuly switched
- join
	- wait for coroutine to finish execution
	- the coroutine that calls it gets blocked
## Channels
- a crucial part of couroutines to do useful things
- synchroinize data transfer between coroutines
	- `send` and `recv`
```rust
fn my_routine(c) {
	x = recv(c) // recv from channel, gets blocked as you are waiting for a value
	print(x)
}

fn main() {
	h, c = spawn(my_routine) // c = channel
	send(c, 5) // sends 5 to the channel, unblocks the requesting co_routine. If there are no recv, it will block
	join(h) // blocks main until h is done. Does it also yield at the same time?
}
```
```rust
// when main exits, numbers is blocked forever as there is only one consumer of it.
fn numbers(c) {
	x = 0; y = 1;
	loop {
		sum = x + y
		send(c, sum) // blocks if there is no recv. can move on when soomething recieves it
		x = y
		y = sum
	}
}

fn main() {
	h, c = spawn(numbers) // c = channel
	for i in 0..5 {
		x = recv(c)
		print(x)
	}
	// if there is a join, main will just block as numbers has a infinite loop
	// if there is a send, it will just block as there is no recv
}
```
#### Many flavors of channels
- are send/recv buffered
	- can you send into a buffer (to be matched with a reciever later), or do you need a matching reciever immediately to finish the transaction
		- HW is non-buffered channels
	- buffer has a reserved space, it writes to the buffer and consumes later
- what type of data do they send
	- In HW1, it will be`void*`
	- channels can be typed
- what type of data is safe to send
	- double-freed data is not
### Communication without channels is unsafe
```rust
my_global = 1
fn my_routine(c) {
	my_global = 2
}

// 22
// 12
// eventually consistent but we want temporal relationship to be consistent
fn main() {
	h, c = spawn(my_routine)
	print(my_global)
	join(h)
}
```
Channels create casual consistency
```rust
my_global = 1
fn my_routine(c) {
	my_global = 2
	send(c, null)
	...
}

// 2
fn main() {
	h, c = spawn(my_routine)
	_ = recv(c) // blocks and yields control to my_routine. changes my_global to 2
	print(my_global) // will always be 2
	join(h)
}
```

when blocks occur, does that switch to the other co_routine? what if theyre both blocked? does that pop off the most recent blocked coroutine and try again?

- say we want to create 100 courotunes, but we want only main() to run untilw e are ready to release all the coroutines
	- create one big channel and pass it to all coroutines
		- creates barrier to sync across many coroutines
		- eventually consume them all
	- you can make arbitary channels via create_channels
	- how can we do this in O(1) space