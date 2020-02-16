# The assembler

My assembler is unlike other assemblers.<br>
I want it to be actually easy to use.

Most assemblers are very cryptic, with instructions like "ASL", "PHA" and "LDX".<br>
What they mean?<br>
Well shift A left, push A to the stack and load to X!<br>
This is ridiculous!

So, i did something pretty simple.<br>
I made the instructions easy to read.<br>
Apply this to the example: "SHIFT A LEFT", "PUSH A" and "LOAD VALUE TO X".<br>
Much easier to read!

My instruction set is made in such a fashion and is therefore alot easier to program.<br>
A line read by my assembler is formatted as such:
- "@ OPERATION VALUE" is something the assembler must do, like importing files.
- "LABEL INSTRUCTION" label may be replaced with tabs or spaces, a label is used by the assembler as a constant.
- "LABEL = EXPRESSION" set a label based on a math-based expression, which may include labels defined earlier
- "* = EXPRESSION" set where the program starts or continues, optional but may not include labels.
- Anything after a ';' is a comment, and ignored.
- "This is text" 'So is this', and 'A' and "B" are examples of characters.
- "Add a double qoute here -> \" <- " 'Or a backslash -> \\ <- '
- characters act as single word (often byte) values, text can only be used in DATA statements.
- DATA, BYTE and BYTES are data statements, you can put stuff in here and you can label them, too!
- RESERVE 5 reserves 5 words, and just change the number to anything you want for a different length.

Assembler tasks:
- @include "path to file"  -  directly takes the contents and replaces the include statement with the file, multiple files per statement is not allowed.
- @no_padding  -  only at beginning of file, causes the initial zeros to be removed if the program does not start at address 0.
There's probably more coming, but not for now.

instructions are case-insensitive, but labels are not.
Take a look at [IS.txt](../master/IS/IS.txt) for the instruction set and format in assembly for GR8CPU.
Take a look at one of the many sample .asm files like [fibas.asm](../master/programs/fibas.asm) for an example on assembly.
