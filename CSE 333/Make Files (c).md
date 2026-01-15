Make files are useful when you have multiple dependencies so you can avoid writing gcc multiple times whenever you update any .c or .h file

# Target
At the top of the makefile you must define the target which will then compile the rest of the .o files. It must be a .o file and you must include the -o flag with the main.o ..., if the top argument is main.o: then it will run that command then stop
```c
target: main.o main2.o ...
	gcc -Wall -std=c17 -g -o main.o main2.o ...
```

# Multiple-Targets
If there are multiple targets which we will define as products and services we can include an all flag
```c
all: products services

products: products.o
	...

services: services.o
	...
```
This must be at the top as it will call the products and services compiler which will then call everything else

# How do you know if one target has multiple .o files?
Take for example the target BandInfo

BandInfo is going to take in BandInfo.o and therefore we know we are going to take in BandInfo.c(c)
Then assume BandInfo.c(c) contains the header
```c
#include "Graphic.h"

int main() {...}
```
and we know we have a Graphic.c(c) file. This means that BandInfo also takes in the Graphic.o file.

# .o
After you define the target you must define the .o files that will be compiles. You will here define .c and .h (.h if applicable) but the .h will not go in the gcc script
```c
main.o: main.c main.h
	gcc -Wall -std=c17 -g -c main.c
```

# clean
When we write clean in the terminal it will remove all defined files. We want to define the target file and all *.o files (and if applicable *.~) where ~ is backup files
we do not need the -f flag but it will remove any warning that will appear in the terminal
```c
clean:
	rm target *.o // this will remove the target and any .o files
	rm -rf target *.o // if you have directories this will go in the directory and remove any target or *.o
	rm target *.o *~ // this will remove all target .o and ~
```