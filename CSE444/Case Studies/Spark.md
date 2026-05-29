## Introduction
- Shared-nothing, no-sql, big processing data system
- open source system from Berkeley
- Paper: Resilient Distributed Systems: A fault-tolerant abstraction for in-memory cluster computing
### Motivation
- goal: better use distributed memory in a cluster
- observation
	- Modern data analytics involves iterations
	- users also want to do interactive data mining
	- in both cases, want to keep intermediate data in memory and reuse it
		- MapReduce doesn't consider disk and memory
	- **MapReduce does not support this scenario well**
		- **requiring writing data to disk between jobs**
		- 
### Approach
- resilient distributed dataset
- RDD properties
	- parallel data structure
	- can be persisted in memory
	- fault-tolerant
		- create copies across computers
		- coordinator node knows which server has the copy and can recompute them
	- users can manipulate RDDs with rich set of operators
#### RDD Materialization
- users control persistence and partitoning (user defined in the interface)
	- x.persist()
	- x.collect()
- takes more time as we are comuting results that we will read later
	- we can eat the cost as its already in memory
- sits in memory the entire time
	- does map reduce steps but doesnt do intermediate disk-writes which makes it a lot faster
	- however, this means we restart the entire process if we fail mid transaction
- persistence
	- should we materialize this RDD in memory
- partitoning
	- users can specify key for partitoning an RDD
#### RDD Details
- An RDD is a partitoned conllection of records
	- think of it like a checkpoint
	- RDD's are typed: RDD(int) is an RDD of integers
- An RDD is read only
	- this means no updates to indvidual records
	- this is to contrast with in-memoru key-value stores
- to craeate an DD
	- execute a determinisitc operation on another RDD
	- or on data in stable storage
## Spark Programming Interface
- RDDs implemented in new spark system
- spark exposes RDDs through a language-intergraded API similar to DryadLINQ but in Scala
- Later Spark was extended with SQL
- Spark can degrade to MapReduce

### Querying/Processing RDDs
- programmer first defines RDDs through transformations on data in stable storage
	- Map
	- filter
	- ...
- Then, can use RDDs in actions
	- action returns a value to app or exports to storage
	- count (counts elements in dataset)
	- collect (returns elements themselves)
	- save (output to stable storage)
- large set of pre-defined transformations
- small set of pred-efined actions
- programming inerface included iterations
```scala
val points = spark.textFile(...).map(parsePoint).persist()

vaar w = // random init vector
for (i <- i to ITERATIONS) {
// sets up the map and then reduces
val gradient = points.map{p => ...}.reduce((a, b) => a + b)
w -= gradient
}
```
### Spark Runtime
![[Spark Runtime.png]]
### Query Execution Details
- lazy evalutation
	- RDDs are not evalutated until an action is called
- in memory caching
	- Spark workers are long-lived processes
	- RDDs can be materialized in memory in workers
	- base data is not cached in memory
## Key Challenge
- how to provide fault-tolerance efficiently
### Fault Tolerant Through Lineage
Represent RDD with 5 pieces of information
- a set of partitions
- a set of dependencies on parent partitions
	- distinguoshes between narrow (one-to-one)
	- and wide dependencies (one-to-many)
- function to compute dataset based on parent
- metadata about parttioning scheme and ata plcaement
- RDD = distributed relation + lineage
## Execution
![[More Details on Spark Execution.png]]
## Where to go from here
- read about the latest Hadoop developments
	- YARN
- read more about Spark
- Learn about GraphLab/Turi
- Learn about Impala, Flink, Myria, etc
- many other big data systems and tools
- also good to know latest cloud offering: Google, Microsoft, and Amazon