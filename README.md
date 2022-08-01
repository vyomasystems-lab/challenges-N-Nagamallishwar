# ** Verification for CTB**

The verification environment is setup using Vyoma's UpTickPro provided for the hackathon.

The following is the Gitpod screenshot
![image](https://user-images.githubusercontent.com/71274647/182189638-ee930d32-e061-4e21-adb9-e06a51af8b28.png)

##**Verification Environment**

The CoCoTb based Python test is developed as explained. The test drives inputs to the Design Under Test (mux , sequential detector ,bit manipulator and universal shift register ) which takes in  inputs  and gives  output 

##**Test Scenario**
###### Design1_level1
Test Inputs: sel 5'b01101
Expected Output: inp13
Observed Output in the DUT inp12

###### Design1_level2
Here in the SEQ1 case has a bug. 

###### Design2_level1
Test Inputs: a=7 b=5
Expected Output: sum=12
Observed Output in the DUT dut.sum=2


##**Design Bug**
Based on the above test input and analysing the design, we see the following
###### Design1_level1
```
 begin
    case(sel)
      5'b00000: out = inp0;  
      5'b00001: out = inp1;  
      5'b00010: out = inp2;  
      5'b00011: out = inp3;  
      5'b00100: out = inp4;  
      5'b00101: out = inp5;  
      5'b00110: out = inp6;  
      5'b00111: out = inp7;  
      5'b01000: out = inp8;  
      5'b01001: out = inp9;  
      5'b01010: out = inp10;
      5'b01011: out = inp11;
      5'b01101: out = inp12;      ==========> bug
      5'b01101: out = inp13;
      5'b01110: out = inp14;
      5'b01111: out = inp15;
      5'b10000: out = inp16;
      5'b10001: out = inp17;
      5'b10010: out = inp18;
      5'b10011: out = inp19;
      5'b10100: out = inp20;
      5'b10101: out = inp21;
      5'b10110: out = inp22;
      5'b10111: out = inp23;
      5'b11000: out = inp24;
      5'b11001: out = inp25;
      5'b11010: out = inp26;
      5'b11011: out = inp27;
      5'b11100: out = inp28;
      5'b11101: out = inp29;
      default: out = 0;
    endcase
```
###### Design1_level2
```
 always @(inp_bit or current_state)
  begin
    case(current_state)
      IDLE:
      begin
        if(inp_bit == 1)
          next_state = SEQ_1;
        else
          next_state = IDLE;
      end
      SEQ_1:
      begin
        if(inp_bit == 1)
          next_state = IDLE;   ======>bug
        else
          next_state = SEQ_10; ======>bug
      end
      SEQ_10:
      begin
        if(inp_bit == 1)
          next_state = SEQ_101;
        else
          next_state = IDLE;
      end
      SEQ_101:
      begin
        if(inp_bit == 1)
          next_state = SEQ_1011;
        else
          next_state = IDLE;
      end
      SEQ_1011:
      begin
        next_state = IDLE;
      end
    endcase
```
###### Design2_level1
```

```

##**Design Fix**
The fixed designs are unbuggied_mux.v
                      unbuggied_seq_det.v
                      unbuggied_mkbitmanip.v
 The verilog code and testbench for Design of level 3 is in design3_level1                     

##**Verification Stratergy**
Basically the verilog codes are thoroughly analysed and the test cases are written insuch way that it covers all cases of inputs and the outputs for that particular inputs are compared with the expected values.


##**Is the verification complete**
As said in Verification Stratergy that we test all cases thus by this we conclude that the verification is complete.
