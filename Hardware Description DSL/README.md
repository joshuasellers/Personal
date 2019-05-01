# Final Project

###### Description:
For this project, I created a Domain-Specific Language (DSL) the describes low-level hardware.  I see it having use in classrooms as a learning tool.  I got the inspiration from my own computer systems class; I remebered having trouble understanding the concepts (the seemed a lot more abstract than coding).  I though by having a physical tool that simulated the systems, students could better understand hardware.

This project is essentially only limited by the hardware in existence.  I created the functions for the most common features, but you could keep adding more things in order to cover all possible facets of hardware creation.

### Installing

To install the project, make sure you have Haskell downloaded on your device.  I used GHCI on my machine.  Then, just download the Haskell files.

### Overall Usability

This code can theoretically be used at multiples levels.  Right now, I have the most basic harware encoded, and these functions could be used to build the more compliacted pieces, but you can create most aspects of hardware with it.  If I have time, I will make more pieces since there is still a bit of Haskell knowledge needed to make new items (which goes against the idea of a DSL).



### The Code
There are four files:
- Data: the most basic parts like Bits, Bytes and Registers
- Hardware: items like gates, switches and other more complicated structures
- Test: I created a test file for the extremely complicated parts (like a register file)
- ExampleHardware: used to show how a user could create their own hardware
This is the code for a decoder:
```
n_to_2n_decoder :: [Bit] -> [Bit]
n_to_2n_decoder [] = error "n_to_2n_decoder invalid input"
n_to_2n_decoder bs = o
        where o = decoder_helper bs negs
              xs = unfoldr (\ b -> if (b == (length bs)) then Nothing else Just (b,b+1)) 0
              negs = powersort xs

n_to_2n_decoder_enable :: Bit -> [Bit] -> [Bit]
n_to_2n_decoder_enable _ [] = error "n_to_2n_decoder invalid input"
n_to_2n_decoder_enable e bs = o
        where o = map (\ x -> if ((bitVal e)==0) then e else x) (decoder_helper bs negs)
              xs = unfoldr (\ b -> if (b == (length bs)) then Nothing else Just (b,b+1)) 0
              negs = powersort xs

decoder_helper :: [Bit] -> [[Int]] -> [Bit]
decoder_helper [] _ = error "decoder_helper invalid input"
decoder_helper _ [] = []
decoder_helper bs (n:negs) = neg bs n : decoder_helper bs negs
    where neg [] _ = error "neg invalid input"
          neg bits [] = and_gate bits
          neg bits (i:ns) = neg (replaceNth i (not_gate (bits!!i)) bits) ns
```
Those functions, as well as others, are used to create functional representations of the hardware.
### Example Code
For the example file, I made a Arithmetic Logic Unit (ALU).  This seemed like a good example for a couple reasons.  First, while I could have made it one of the functions, I contains most of the items I had already hardcoded so it would be a prime example of what a user could do with the DSL.  Second, the structure itself, unlike something like a register file, is fairly simple; it would not require a lot of extra Haskell code to complete and would be a good example of the DSL.
### Next Steps
As I said before, my only limitation is when I get tired of making hardware.  A class could use any level of my code, but I could make all hardware possible as single functions.  There are still some basic items I would like to make.  I still need to add in delays and time-related items like Flip-Flops.  That would probably be simple to code, but would require a great deal of thought to come up with an elegant solution.  Overall, this has helped me understand hardware better and I hope it can be used to help other students as well.
