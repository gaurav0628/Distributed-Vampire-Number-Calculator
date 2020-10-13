# Distributed-Vampire-Number-Calculator

Problem Definition : 

An interesting kind of number in mathematics is vampire number (Links to an external site.). A vampire number is a composite (Links to an external site.) natural number (Links to an external site.) with an even number of digits, that can be factored into two natural numbers each with half as many digits as the original number and not both with trailing zeroes, where the two factors contain precisely all the digits of the original number, in any order, counting multiplicity.  A classic example is: 1260= 21 x 60.

A vampire number can have multiple distinct pairs of fangs. A vampire numbers with 2 pairs of fangs is: 125460 = 204 × 615 = 246 × 510.

The goal of this first project is to use Elixir and the actor model to build a good solution to this problem that runs well on multi-core machines.

Results : 

The program automatically detects the numbers of cores on host machine or network and delegates the work according to that number to achieve a maximum parallelism. We were able to achieve a parallelism of 4 with the program running on a single macbook with following configuration :
![alt text](https://drive.google.com/file/d/1TQRQTw1r7KSJiMp0xg4v1o5yT259LOgN/view?usp=sharing)

Running Time : (for mix run proj1.exs 100000 200000)
real 0m0.601s
user 0m2.341s
sys 0m0.141s
Ratio of CPU time to Running time is : (user+sys)/real = 4.129
![alt text](https://drive.google.com/file/d/1uonMpCMEEDs9Zvuz0Xm1aGmC8b75m7f1/view?usp=sharing)

How to run :

1. Pull the code to your local machine. Ensure that the machine has Elixir installed and is working fine.
2. Go to the root directory of pulled code, and open terminal.
3. Run the following command on terminal :
    mix run proj1.exs num1 num2
   where num1 and num2 are placeholders for 2 numbers between which you want to find the Vampire Number fangs.
4. Output will be displayed on the terminal in form of tuples. Example output shown below 
      105210 210 501
   where 105210 is a vampire number with fangs 210 and 501.
