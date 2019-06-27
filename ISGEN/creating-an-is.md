# How to use my tools to make your own instruction set

ISGEN currently is a processing applet and needs processing to run.<br>
I will make it an independant program leter.

How to use it:

First, you need the control signal file, a file which describes the control signals in the CPU and their functions.<br>
The first string on each line is the name of the control signal, ended by a space after it.<br>
Take a line extract as an example:
```
AIO ALU: invert out / shift right
```
In this example "AIO" is the control signal name and the description is on the same line.<br>
It is recommended you keep it simple so you can understand it.

Next, line numbers matter.<br>
Line 1 is for bit 1 of the instruction set ROM.<br>
If a line matches "-", it is ignored.<br>
This feature is here because you might not use every bit in the ROM.<br>
See [CTRL.txt](../master/IS/CTRL.txt) for an example on how i did it.

Now, we must make the assembly guide.<br>
The assembly guide describes the operations for the instructions and also the format for the assembler.<br>
Lines starting with "@" are currently ignored, but i later want to add functionality to this.<br>
The format of a line is as such:
```
INST NAME "TOKEN(s)" CONTROLS
```
INST is the value of the instruction, in hexadecimal.<br>
NAME is the name of the instruction, currently unused.<br>
TOKEN(s) are the tokens of the format.<br>
CONTROLS are the control signals for an instruction.

CONTROLS is first split by ';' to split stages of an instruction.<br>
And inbetween that, it is split by ':' to split the names of the control signals.<br>
Take an example of an instruction:
```
01 LDR "LOAD %A%" ILD:ISA:CIN;ILD:RIA:STR
```
In this example, 01 is the instruction, LDR is the unused name and "LOAD %A%" is the format.<br>
If we look at the control signals in this example, we see that it has 2 stages:

On the first stage:
- ILD is on to load the byte after the instruction byte on to the bus.
- ISA is on to set the address which to load from next stage, this is set from the bus.
- CIN is on to increment the program counter, to make sure no data is executed by accident.

Since ILD outputs to the bus and ISA takes an input from it, we load the address from memory and set the address, making it a pointer.<br>
Synchronised with this, the program counter increments, but it does not affect the address loading routine.

On the second stage:
- ILD is on again to load a byte, but now from the previously loaded address.
- RIA is on to set the A register from the bus.
- STR is on to indicate the end of the instruction.

Similarly to the first stage, ILD loads the value to the bus and RIA uses it and stores it in the A register.<br>
AFTER this, STR causes the control unit to move on to the next instruction by resetting the stage.

Take another look at the example.<br>
Notice the "%A%"?<br>
It means an address is expected.<br>
Similarly, "%V%" means a value is expected.<br>
The assembler handles addresses and values.<br>
These must be in the correct order because otherwise the data won't be added in the correct order either.<br>
Later on, i want the next token to be used to terminate the expression, but this is not yet supported.<br>
This means that for now, the next token must be ',' to not corrupt expressions.

If you have any questions, please open an error.<br>
I don't currently have a good e-mail or number to give you.
