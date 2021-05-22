# cee
Cee is a macro language for c. It can be generated from a file conatining keywords and symbols line by line. The generated c header contains the macros. The macro name conatin only small and big Es how much es a macro has is set by the position in the input file. For that process the ceefy.v is used it is written in [v](vlang.io). The commandline options are -o to set the output file and -s to print into the stdout. The first argument is the input file. Piping also works and is prefered over the file. The tmpl.cefy in this repo is used to generat the cee.h with the ceefy tool. The e.c is an example of the language.
## Bulding ceefy
Run
```sh
make build
```
.\
The script make script just runs
```sh
v -prod -o ./build/ceefy ./ceefy/
```
to build ceefy, then it creates the header with
```sh
./build/ceefy -o ./include/cee.h ./tmpl.cefy
```
and finally builds the example with the command
```sh
gcc -I./include -O3 ./example/e.c
```
.\
It can be installed by running
```sh
make install
```
NOTE: This install ceefy and the example program(e)
## Ceefy usage
Usage: ceefy [flags] [commands] ceefy [OPTIONS] <input>

ceefy your code

Flags:
  -s  --to-stdout     write to a file
  -o  --output        define the output file
  -h  --help          Prints help information.
  -v  --version       Prints version information.

Commands:
  help                Prints help information.
  version             Prints version information
