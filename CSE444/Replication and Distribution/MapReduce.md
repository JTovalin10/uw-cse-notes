# CSE444: MapReduce

**MapReduce** is largely obsolete today, but it has enormous historical impact: both **Spark** and **Snowflake** take direct inspiration from its programming model.

## The Core Concept

MapReduce is a high-level **programming model** and implementation for large-scale parallel data processing. Critically, it was **not designed to be a DBMS** — its goals are narrower:

- Simplify the task of writing parallel programs.
- Provide a simple programming model that applies to many problems.

The power of the model comes from hiding the messy details inside a **runtime library**, so the programmer only writes two functions and the system handles everything else:

- Automatic parallelization
- Load balancing
- Network and disk transfer optimization
- Handling of machine failures
- Robustness

The big idea: break the input down by key, group records by that key, and have servers work on the groups independently.

## Data Processing at Massive Scale

MapReduce targets workloads that run with **massive parallelism** inside a data center, often running for many hours. At that scale, **failure is the norm, not the exception** — a high number of servers fail per hour, so built-in **fault tolerance is vital**. This requirement is what drives many of the implementation decisions below (writing intermediate output to disk, reassigning failed tasks, and backup tasks).

## Data Storage: GFS / HDFS

A MapReduce job's input is a **file**, stored in a **Distributed File System**:

- **GFS**: [[CSE452/Case Studies/Google File System (GFS)|Google File System (GFS)]]
- **HDFS**: Hadoop File System

The distributed file system shapes how MapReduce reads data:

- A file is split into **blocks** (or **chunks**) of roughly 64 MB.
- Blocks are **replicated** and stored on random machines (this replication is what survives the constant machine failures above).
- Files are **append-only**.
- pre-emptive task execution
	- if a task takes too long to execute, then we can go ahead with the next step
		- assumes the node is still working on the task so if the computer is already hardware-slow then we can suffer from performance degregation

## MapReduce Data Model

The data model holds files, where **a file is a bag of `(key, value)` pairs** and the value can be anything. A MapReduce program transforms one bag into another:

- **Input**: a bag of `(inputKey, value)` pairs
- Some intermediate processing
- **Output**: a bag of `(outputKey, value)` pairs — which can be piped into another MapReduce program as its input

### The Map Phase

The user provides the **MAP function**.

#### Formal Definition

$$\text{map}(\text{inputKey}, \text{value}) \rightarrow \text{bag of } (\text{intermediateKey}, \text{value})$$

The system applies the map function **in parallel** to all `(inputKey, value)` pairs in the input file. Before the next phase, it **shuffles** all emitted pairs and **groups** them by their intermediate key.

#### Simplified Explanation

Each worker independently chews through its slice of the file and tags every result with a key. The system then gathers everything that shares a key into one pile.

![[Screenshots/MapReduce Example.png]]

### The Reduce Phase

The user provides the **REDUCE function**.

#### Formal Definition

$$\text{reduce}(\text{intermediateKey}, \text{bag of values}) \rightarrow \text{output}$$

The output form depends on the implementation:

- **Original MapReduce paper**: a bag of outputs (values)
- **Hadoop**: a bag of `(outputKey, value)` pairs

The system groups all pairs with the same intermediate key and passes the bag of values to REDUCE.

#### Simplified Explanation

Once every value for a key is in one pile, a single worker collapses that pile into the final answer for that key.

### Example: Word Count

A canonical example is **counting the number of occurrences of each word** in a large collection of documents. For each document:

- The **key** = document id (`did`)
- The **value** = set of words (`word`)

```cpp
// key: document name
// value: document contents
map(string key, string value) {
    for (string w : value) {
        EmitIntermediate(w, "1");
    }
}

// key: a word
// values: a list of counts
reduce(string key, Iterator values) {
    int result = 0;
    for (auto v : values) {
        result += parseInt(v);
    }
    Emit(to_string(result));
}
```

The reduce step operates on the **post-shuffle collection**. Map emits one pair per word occurrence; the shuffle groups identical words together; reduce sums each group:

```
(apple, 1)
(banana, 1)
(orange, 1)
(orange, 1)

becomes (after shuffle/group by key)

(apple, [1])
(banana, [1])
(orange, [1, 1])

which we reduce to

(apple, 1)
(banana, 1)
(orange, 2)
```

## Parallel MapReduce Details

![[Screenshots/Parallel MapReduce Details.png]]

## Jobs vs. Tasks

These two terms describe different granularities of work:

- **A MapReduce Job** is one single "query" — e.g., count the words in all documents. More complex queries may consist of **multiple jobs**.
- **A Map Task or a Reduce Task** is a group of instantiations of the map- or reduce- function that are scheduled on a single worker.

![[Screenshots/Tasks.png]]

## Workers

- A **worker** is a process that executes **one task at a time**.
- There is typically **one worker per processor**, hence 4 or 8 per node.
- The system often talks about **slots** — e.g., each server has 2 map slots and 2 reduce slots.

## Implementation

The runtime is coordinated by a single **master node**:

- The input file is partitioned further into **M splits**; each split is a contiguous piece of the input file. By default, splits correspond to blocks.
- The master assigns workers (servers) to the **M map tasks** and keeps track of their progress.
- Workers write their output to **local disk**.
- The output of each map task is partitioned into **R regions**.
- The master assigns workers to the **R reduce tasks**.
- Reduce workers read regions from the map workers' local disks.

![[Screenshots/MapReduce Phases.png]]

## Skew

Using a **PageRank** application as the example: **reduce tasks do not begin until all map tasks are finished**. Because of this barrier between phases, an uneven distribution of work (**skew**) across tasks delays the entire job — the slowest task gates progress.

![[Screenshots/Tasks Skew.png]]

## Interesting Implementation Details

### Worker Failure

- The master **pings workers periodically**.
- If a worker is down, the master **reassigns its task to another worker**. It is *not* a parallel DBMS-style restart of the whole query — only the failed task is redone.

### How Many Map and Reduce Tasks

- **Larger numbers of tasks** are better for load balancing.
- But more tasks also add **overhead**.
- Unlike a parallel DBMS, which spreads operations across all nodes, MapReduce schedules tasks onto a bounded number of slots.

### Backup Tasks

- A **straggler** is a machine that takes an unusually long time to complete one of the last tasks. Causes include:
  - A bad disk forcing frequent correctable errors (e.g., dropping from 30 MB/s to 1 MB/s).
  - The cluster scheduler having scheduled other tasks on that machine.
- Stragglers are a **main reason for slowdown**.
- **Solution**: pre-emptive **backup execution** of the last few remaining in-progress tasks — whichever copy finishes first wins.

## The State of MapReduce Systems

MapReduce has been heavily extended to address its limitations:

- Capabilities to write **DAGs** of MapReduce jobs.
- **Declarative languages** on top of MapReduce.
- The ability to read from **structured storage**.

Most companies now use **both types of engines** (MapReduce-style and DBMS-style), with increased integration, and new systems have emerged that improved on MapReduce.

## Relational Queries over MapReduce

You can express relational queries on top of MapReduce:

- A query is compiled into a **query plan**.
- Each operator maps to **one MapReduce job**.
- In this way you can write jobs that act like a DBMS.
- **However**, this approach provides **no transactions** and no full relational guarantees.

---

## Industry Standard Terms

| CSE444 Term | Industry / Standard Term |
| :--- | :--- |
| **MapReduce** | Batch processing framework / Hadoop MapReduce |
| **Master node** | JobTracker / Application Master (YARN) |
| **Worker / slot** | TaskTracker / executor slot |
| **Map / Reduce task** | Mapper / Reducer |
| **Straggler / backup task** | Straggler mitigation / speculative execution |
| **Block / chunk** | HDFS block |

---

## Related

- [[CSE452/Case Studies/Google File System (GFS)|Google File System (GFS)]] — the distributed file system that stores MapReduce input
- [[CSE444/Parallel/Intro to Parallel DBMS|Intro to Parallel DBMS]] — the parallel DBMS approach MapReduce is repeatedly contrasted against
- [[CSE444/Parallel/ParallelExecutionComponents/The Shuffle Operator|The Shuffle Operator]] — the same producer-consumer redistribution used between Map and Reduce
- [[CSE444/Parallel/Data Partitioning Schemes|Data Partitioning Schemes]] — partitioning and data skew in parallel systems
- [[CSE444/Replication and Distribution/Distributed Databases|Distributed Databases]] — shared-nothing distribution that MapReduce relies on
