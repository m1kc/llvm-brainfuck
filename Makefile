PROGRAM := llvm-brainfuck
OBJECTS := main.o

CXX := clang++
CXXFLAGS := $(shell llvm-config --cppflags) -Wall -Werror -pedantic
LDFLAGS := $(shell llvm-config --ldflags --libs core)

all: $(PROGRAM) $(SHIM)

$(PROGRAM): $(OBJECTS)
	$(CXX) -o $@ $^ $(LDFLAGS)

clean:
	rm -f $(PROGRAM) $(OBJECTS)

.PHONY: clean all
