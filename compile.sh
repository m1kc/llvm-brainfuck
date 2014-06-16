cat | ./llvm-brainfuck | llvm-as | opt -instcombine | llc >out.s
echo "Assembly -> out.s"
clang out.s shim.a -o out
echo "Executable -> out"
