# Assembly
Demonstrating some `x86_64` assembly codes on Linux.

### Assembler and syntax
- AT&T syntax has been used. The other syntax is Intel syntax.
- GNU assembler has been used to assemble the codes. You'll find it as `as` command on your Linux machine.
- Command `ld` has been used to link the codes.

### Use of `dumpx`
- This is a bash script that executes from source and dumps the output on the screen as `hex`.
- This is usefull for displaying numeric outputs.
- This is coz on Linux, numbers must be converted into strings before displaying.
- Linux supports displaying only characters.
- But I'm still incapable doing such conversions in assembly. So, `dumpx` is the workaround.

### Use of `run`
- This script assembles and executes the program. Object file is deleted after linking is done. Only the executable is saved.

### NOTES
- If unmodified, `dumpx` and `run` must be executed in their parent directory.
- So, this is what you do: `./dumx src/code.asm` or `./run src/code.asm`
