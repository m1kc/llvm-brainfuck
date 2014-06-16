llvm-brainfuck
==============

Brainfuck compiler. Takes BF code from stdin, generates LLVM IR, then prints it to stdout.

Originally written by Jeremy Roman: http://www.jeremyroman.com/2012/12/11/building-a-brainfuck-compiler-with-llvm/index.html


Build & run
-----------

Requires installed clang.

To build, just type:

    make

To run tests:

    ./run-tests.sh

To compile your own program:

    echo ",.+.+." | ./llvm-brainfuck | llvm-as | opt -instcombine | llc >test.s
    clang test.s shim.a -o test

