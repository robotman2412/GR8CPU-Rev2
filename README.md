# please note

If you're looking for [the CPU that runs GR8NIX](https://robot.scheffers.net/project/gr8nix), this is not the repository you're looking for.
It is [this repository](https://github.com/robotman2412/thecpuproject) you're looking for

There will not be any more activity here as this project is finished, just not entirely posted online.

# GR8CPU-Rev2

My second CPU project, mmmmaaayyybe orderable as a kit!

The instruction set ROMs are in the folder "IS"<br>
The programs along with the exported files are in the folder "programs"<br>
The program i used to generate the instruction set ROMs is in the folder "ISGEN"<br>
Take a look at [creating-an-is.md](../master/ISGEN/creating-an-is.md) for a guide on how to create an instruction set.<br>
Note: I will change the structure of IS files soon -- to allow for my assembler to be used on more complex systems.

The assembler creates a folder called "data", which stores the paths.<br>
It is recommended you keep this, but not necessary.<br>
To start writing programs, download the repository and use assembler.jar to assemble your programs.<br>
I also made a guide on how to create programs in [assembler.md](../master/assembler.md)

---

General specs:<br>
GR8CPU Rev 2 is an 8-bit CPU bult out of TTL logic ICs.<br>
256 bytes are accessible by the CPU, but i have a ram chip with 128Kib installed.<br>
The ALU has most of the basic features:
- add / subtract
- shift and rotate either left or right
- carry flag (set by shift instead of add if shift mode is active)
- zero flag (only on if the final output which may already be inverted is zero)
I have no particular plan for clock speed, maybe 10KHz.<br><br>

I have a bunch of programs, which i actually use.<br>
There is also [IS.txt](../master/IS/IS.txt), with more info on the instruction set.

---

Current Status:

Logical design: Final.<br>
Instruction set: Final.<br>
Assembler: Finishing.<br>
Breadboard version: Finished, maybe not final.<br>
TTY: Design stage.

Modules:<br><br>

Note: this is the PCB as part of the kit.<br>

#001 Register V1: Package error.<br>
#002 Bus V1: Failure, wrong connectors.<br>
#003 Program counter V1: PCB Design stage, breadboard success.<br>
#004 Motherboard V2 (Former Bus): Ready to order.<br>
#005 Flag register V1: Design stage.<br>
#006 Register V2: Ready to order.<br><br>

Things to order:<br>
None :D i have everything i need to finish the project :D

---

Bill of materials so far (out of date):<br><br>

1x    Arduino nano (for programming, the one that emulates a clock for now doesn't count)<br>
1x    Alliance AS6C1098-55PCN 128K memory IC<br>
2x    SN74HC161AN binary counter IC (does not count down)<br>
17x   Blue LED 5mm<br>
17x   Red LED 5mm<br>
8x    Yellow LED 5mm<br>
1x    Green LED 5mm<br>
6x    SN74HC244N buffer driver IC<br>
3x    SN74HC273N D-type flipflop IC (basically register IC)<br>
2x    SN74HC04N hex inverter IC<br>
3x    SN74HC02N NOR gate IC<br>
43x   200 Ohm resistor (for LED driving)<br>
20x   1-10 KOhm resistor (as pulldown, 5 KOhm is recommended)<br>
3x    Normally open generic push buttons<br>
7x    4-Switch DIP switch package (one here may be substituted for a 3-switch one)<br>
1x    Generic 2-5V battery pack<br>
2x    Generic low voltage drop diodes<br>
9999x Patience (altough 10000x is recommended)<br>
      Wiring, red, green, blue, black and yellow (i went with 100m rolls for pretty cheap)<br>
