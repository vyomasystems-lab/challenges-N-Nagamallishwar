// Testbench

module USR_tb;
  reg [3:0] in;
  reg [1:0] s;
  reg  clk;
  reg reset,sil,sir;
  wire [3:0] out;
  
//instatiation
  USR shitreg(out,in,s,clk,reset,sir,sil);
  initial 
     begin
          clk=1'b0;
       forever #10 clk=~clk;
     end
  initial 
     begin
       reset = 0;
         #50 s=2'b00;in=4'b0000;sil=0;sir=1;
       #100 reset=1;s=2'b00;in=4'b0011;sil=1;sir=0;
       #150         s=2'b01;in=4'b0110;sil=1;sir=1;
       #200         s=2'b10;in=4'b1100;sil=0;sir=1;
       #250         s=2'b11;in=4'b1111;sil=1;sir=0;
     end
      
  initial
     begin  
       $monitor("At time=%t,s=%b,out=%b,in=%b,reset=%d,clk=%d,sir=%d,sil=%d",
               $time,out,in,s,clk,reset,sir,sil);
       $dumpfile("USR.vcd");
       $dumpvars(0,USR_tb);
       
       #500 $finish;
     end  
endmodule 
       
