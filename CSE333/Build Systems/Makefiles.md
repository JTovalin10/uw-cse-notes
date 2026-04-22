# CSE333: Makefiles

**[[Makefiles]]** are essential tools for automating the compilation process, especially in projects with multiple dependencies. They help avoid repetitive typing of compiler commands whenever a source or header file is updated.

## Makefile Basics

### Targets and Dependencies
At the top of a Makefile, you define a **target**, which is usually the final executable or an object file. The target depends on other files (dependencies).

```makefile
target: main.o main2.o
	gcc -Wall -std=c17 -g -o target main.o main2.o
```
*Note: The indentation must be a tab character.*

### Object Files (.o)
After defining the main target, you define how to build the individual object files from source files.
```makefile
main.o: main.c main.h
	gcc -Wall -std=c17 -g -c main.c
```
The `.h` files are listed as dependencies but are not included in the `gcc -c` command.

## Language Specifics

### C vs C++
The primary difference between Makefiles for C and C++ is the compiler and the standard flag used.

- **C**: uses `gcc`
  ```makefile
  gcc -Wall -g -std=c17 -c main.c
  ```
- **C++**: uses `g++`
  ```makefile
  g++ -Wall -g -std=c++17 -c main.cc
  ```

## Advanced Features

### Multiple Targets
If a project has multiple executables (e.g., `products` and `services`), use an `all` target at the top.
```makefile
all: products services

products: products.o
	gcc -o products products.o

services: services.o
	gcc -o services services.o
```

### Clean
The `clean` target removes generated files to allow for a fresh build.
```makefile
clean:
	rm target *.o
	rm -rf target *.o  # Use -rf for directories
	rm target *.o *~   # Removes backup files ending in ~
```

## Dependency Diagrams

Understanding dependencies is crucial for complex projects. Targets depend on `.o` files, which in turn depend on `.c`/`.cc` and `.h` files.

Example hierarchy:
```
    Song  BandInfo 
	   \   /
		all
```

If a `.cc` file includes a header that defines a class, it introduces a dependency:
```
Song.cc    Links.h    Graphic.cc  Graphic.h      BandInfo.cc
     \     /         \      |     /     \           / 
      Song.o          Graphic.o        BandInfo.o
         \               |               /
          Song        Graphic        BandInfo 
            \            |            /
                       all
```

## Related
- [[CSE333/Build Systems/Makefile Dependency Diagrams]]
- [[CSE333/C Preprocessor/C Preprocessor]]
- [[CSE333/C Preprocessor/Client Headers]]
