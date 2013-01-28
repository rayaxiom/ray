FILE = manipulator
CC=g++
CFLAGS=-c -Wall
LDFLAGS=
SOURCES=$(FILE).cpp
OBJECTS=$(SOURCES:.cpp=.o)
EXECUTABLE=$(FILE)

all: $(SOURCES) $(EXECUTABLE)
	
$(EXECUTABLE): $(OBJECTS) 
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

.cpp.o:
	$(CC) $(CFLAGS) $< -o $@

cleanall :
	rm $(EXECUTABLE) $(OBJECTS)

clean :
	rm $(OBJECTS) 

run :
	./$(FILE)

mrun :
	make FILE=$(FILE) && make run FILE=$(FILE)

# Below is my old makefile.

# Makefile for this: c++ .\ex4-3.cpp -o .\ex4-3.exe .\median.cpp
# Second make file, with some variables
# Ho'kay.

# I am a comment, and I want to say that the variable CC will be
# the compiler to use.
#CC=g++
# Hey!, I am comment number 2. I want to say that CFLAGS will be the
# options I'll pass to the compiler.
#CFLAGS=-c -Wall

#all: ex4-3.exe

#ex4-3.exe : ex4-3.cpp median.o Student_info_related.o
#	$(CC) ex4-3.cpp -o $@ median.o Student_info_related.o

#median.o : median.cpp
#	$(CC) $(CFLAGS) median.cpp
	
#Student_info_related.o : Student_info_related.cpp
#	$(CC) $(CFLAGS) Student_info_related.cpp

#cleanall :
#	del ex4-3.exe *.o

#clean :
#	del *.o
