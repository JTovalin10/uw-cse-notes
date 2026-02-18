take for example
```c
{
Links.h
...
}

{
Graphic.h
Class Graphic {...}
}

{
Graphic.cc
#include "Links.h"
#include "Graphic.h"
...
}

{
Song.cc
#includes "Links.h"
int main(...) {...}
}

{
BandInfo.cc
#include "Graphic.h"
int main(...) {...}
}
```
Lets define the targets that will be compiled as Song and BandInfo. As we have multiple targets we will then define an all
```
    Song  BandInfo 
	   \   /
		all
```

We know that targets depend on their .o files. 
**Note**: if a .o files .cc includes a class then the target will also depend on their .o file (look at bandinfo.cc and Graphic.cc)
```
Song.o     BandInfo.o        Graphic.o
	\           \            /
    Song          BandInfo 
	   \          /
		    all
```
Finally, we must link the .o to the .c(or cc) and .h files

As song.cc includes Links.h that means Song.i also depends on Links.h

Likewise, Graphics.cc includes Links.h and Graphic.h so Graphic.o will depend on Graphic.cc, Links.h, and Graphic.h, then BandInfo.cc will depend on Graphic.h (and nothing else in this instance as Graphic.h doesnt rely on anything)
```
Song.cc.    Links.h.   Graphic.cc.  Graphic.h.      BandInfo.h
	 \     /         \      |     /     \           / 
		Song.o          BandInfo.o        Graphic.o
			\                  \            /
		    Song                 BandInfo 
			   \                /
				 \            /
				   \        /
				     \     /
				       all
```

[[Make Files (c)]][[Makefiles (c++)]]