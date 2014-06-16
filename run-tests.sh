number=0

run_test(){
	let number=${number}+1
	echo "--- Test #${number}. This test $2."
	echo "--- Compiling..."
	echo "$1" | ./llvm-brainfuck | llvm-as | opt -instcombine | llc >test.s
	clang test.s shim.a -o test
	echo "--- Running..."
	./test
	echo -e "\n--- Done, return code $?.\n"
	rm -f test test.s
}


run_test \
	"+++" \
	"just checks if the compiler works"

run_test \
	",.+.+." \
	"takes a letter, then prints it back, then prints two following ones"

run_test \
	">>>++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++." \
	"prints 'H'"

run_test \
	",.,.,.,.,." \
	"five letters back"

run_test \
	"+++++[>,.<-]" \
	"five letters back too, but using cycles"

run_test \
	"++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++." \
	"prints 'hello, world'"

#run_test \
#	"-,+[-[>>++++[>++++++++<-]<+<-[>+>+>-[>>>]<[[>+<-]>>+>]<<<<<-]]>>>[-]+>--[-[<->+++[-]]]<[++++++++++++<[>-[>+>>]>[+[<+>-]>+>>]<<<<<-]>>[<+>-]>[-[-<<[-]>>]<<[<<->>-]>>]<<[<<+>>-]]<[-]<.[-]<-,+]" \
#	"performs ROT13 transformation. Use Ctrl+C to exit"
