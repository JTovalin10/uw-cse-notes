- coroutines -> thrads
	- interrupts
- single core -> multicore
	- atomics
	- spinlocks
- interrupt-safe spinlocks (ISLs)
- we are implemtnign yields
- why an ISL, not a mutex
	- a mutex owuld need itself
		- waiting for a mutex means switching to another threads, like `yield` does: through the ready qyeyem the very thing this lock protects
	- the ISl is the sync primitive's primitive
	- in normal code, we never want a spin lock
		- we rather block so the CPu can do other things until the lock is ours
		- burns cycles and hogs the memory bus
- interrupt safe spinlocks are the key
	- allow us to implement all sort of sync proimtivies
	- inside the kernel they are a common mechanism to make ciritcal section on a multithreaded, multicore machine (code can also be lock-free)

## Making a thread-safe channel
- each channel needs its own lock
```c
struct Channel {
	TaskQueue blocked_senders;
	TaskQueue blocked_receivers;
	InterruptSpinLock isl;
};

long unsafe_recieve(Channel* ch) {
	if (empty(&ch->blocked_senders)) {
		block_on(&ch->blocked_recievers);
		return current->value; // a sender left it here
	}
	Task* s = pop(&ch->block_senders);
	long v = s ->value; // the value s is sending
	wake(s); // back on reedy queue
	return v;
}

// Constant bug in concurrency: time of check to time of use (TOCTOU) bug
// before we enter the blocked, a sender can attempt to send and then finds no receiver so it enters the block and then both are blocked
// assume you get interrupted right after releasing the lock and before entering the code you are attempting to run inside the critical section
long unsafe2_recieve(Channel* ch) {
	ch->isl.lock();
	if (empty(&ch->blocked_senders)) {
		ch->isl.unlock();
		block_on(&ch->blocked_recievers);
		return current->value; // a sender left it here
	}
	Task* s = pop(&ch->block_senders);
	long v = s ->value; // the value s is sending
	wake(s); // back on reedy queue
	ch->isl.lock();
	return v;
}

// figure out dangerous section
// always release lock, better to do it at end with one exit point
long safe_recieve?(Channel* ch) {
	ch->isl.lock();
	long val;
	if (empty(&ch->blocked_senders)) {
		block_on(&ch->blocked_recievers);
		val = current->value; // a sender left it here
	} else {
		Task* s = pop(&ch->block_senders);
		val = s ->value; // the value s is sending
		wake(s); // back on reedy queue
	}
	ch->isl.unlock();
	return val;
}
```
- never block while holding ch->isl (and with interrupts off)
- every other task that calls `send` or `recieve` on this channel now spins forever: nobody will ever unlock it
### How to make Channels thread-safe
- we need to be able to block and unlock a lock at the same
```c
void classic_yield() {
	isl.lock();
	ready_queue.push(current);
	next = ready_queue.pop();
	switch(next, current);
	isl.unlock();
}

// unlock lock only after this task's registers are saved
// isl is the schedulers: it protectes the ready queue (2-6). lock is the clalers (ch->isl): it protects the channel
// in switch2, we call unlock(lock) that is passed in
void classic_yield2(ISL* lock) {
	isl.lock();
	ready_queue.push(current);
	next = ready_queue.pop();
	switch(next, current, lock);
	isl.unlock();
}

// we are o blocked_recievers before anyone can take ch->isl
long receive(Channel* ch) {
ch->isl.lock();
	long val;
	if (empty(&ch->blocked_senders)) {
		// allows us to release the lock atomically
		block_on2(&ch->blocked_recievers, &ch->isl);
		val = current->value; // a sender left it here
	} else {
		Task* s = pop(&ch->block_senders);
		val = s ->value; // the value s is sending
		wake(s); // back on reedy queue
	}
	ch->isl.unlock();
}
```
- basically, always hold the lock when attempting to enter the queue but we must support releasing the lock during the context switch
- if we need to block a thread, ut it on our waitier queue instead of ready quuee, and yield and unlock the channels lock
- blocking lock (mutex)
	- lock: if it is free, take ut. if it is taken, block
		- a queue of blocked threads
	- unlock: if there are blocked threads, unblock it
```cpp
struct Mutex {
	TaskQueue blocked;
	bool taken;
};
```

## Mutex
```c
struct Mutex {
	TaskQueue blocked;
	bool taken;
	ISL isl; // new: protects taken and blocked
};

void correct_unlock(Mutex* m) {
	m->isl.lock();
	m->taken = false;
	if (!empty(&m->blocked)) wake(pop(&m->blocked));
	m->isl.unlock();
}

void buggy_lock(Mutex* m) {
	m->isl.lock();
	// the issue is that we are not using a while as another threads can still take the lock even when we remove the blocked but we arent guaranteed to be scheduled immeditely
	if (m->taken) block_on2(&m->blocked, &m->isl);
	m->taken = true;
	m->isl.unlock();
}

void correct_lock(Mutex* m) {
	m->isl.lock();
	while (m->taken) {
		block_on2(&m->blocked, &m->isl);
		m->isl.lock();
	}
	m->taken = true;
	m->isl.unlock();
}
```

## another possible impl
- direct hand-off
	- unlock: if a thread is blocked, wake it as the new owner: tkaen stays true
	- lock: a woken thread already owns the mutex, so it returns at once: no reechcek, and it does not touch taken
- we need a while loop as another thread cna take the utex before the woekn thread runs
- with direct hand-off nobdy can, but then every wake-up must come from unlock (no spurious wakee-up)