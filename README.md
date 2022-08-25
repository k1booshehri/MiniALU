# MiniALU (CAD course final project)
## project description:
The function of this ALU is as follows: it receives 43 bits as instructions, and these 40 bits will be as follows:
</br>
The first 3 bits mean the first operator. The second 3 bits mean the third operator. The third 3 bits mean the third operator. Make sure the numbers are integers. (positive or negative) and also the operators will be as follows: 
</br>
000 means addition, 001 means subtraction, 010 means multiplication, 011 means subtraction, 100 means power, 101 means logarithm, 110 means square root, for example, if the input command is equal to 0000101000001100000011000000100000100 Let the ALU be obtained because it displays: (4^2(*)12+6) 
</br>
Note that any code that is only used for simulation is not acceptable.
</br>
In this section, we intend to add 8 registers to the built one. For this purpose, the input commands of the system will have changes. The changes are as follows: 
</br>
the number of input commands will be 50 bits, the order and size of operator bits will not change.
For each 8-bit number that was designed in the previous part, he added a bit on the left side of it, which actually reads the next 8 bits as a number if the left bit is 0, and if that bit is 1, the content of the registry with Bayes . equal to the value of the next 8 bits. In the last 3 bits of the command, the index is a register and stores the result obtained by the ALU in that register.
</br>
We are going to add facilities to these few controls for our ALU to execute a program including a line of code. To achieve this goal, instead of 1 input line, we must give a program to the processor. This program will be as follows:
</br>
First, we give the program the number of lines of code to the processor. Then we give the same number of command lines to the processor. The system must execute the commands line by line and change the value of the registers accordingly. Note that in order to do this part, you need to do the first point part.
