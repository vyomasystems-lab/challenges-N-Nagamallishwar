//Structural model:
//Shift register
//mux
module mux(out,s0,s1,i0,i1,i2,i3);
    input s1,s0,i0,i1,i2,i3;
    output reg out;
  
  always @ (*)
    begin 
      case({s0,s1})
        2'b00: out=i0;
        2'b00: out=i0;
        2'b00: out=i0;
        2'b00: out=i0;
      endcase
    end
endmodule

//Dflipflop
module dff(q,din,clk,clear);
  input din,clk,clear;
  output reg q;
  always @ (posedge clk)
      begin 
        if(clear ==1)
          q<=1'b0;
        else
          q<=din;
      end
endmodule

module USR(out,in,s,clk,reset,sir,sil);
  input [3:0] in;
  input [1:0] s;
  input clk;
  input reset,sil,sir;
  output [3:0] out;
  wire [3:0]w;
  
  
  mux m0(w[0],s[1],s[0],in[0],sil,out[1],out[0]);
  mux m1(w[1],s[1],s[0],in[1],out[0],out[2],out[1]);
  mux m2(w[2],s[1],s[0],in[2],out[1],out[3],out[2]);
  mux m3(w[3],s[1],s[0],in[3],out[2],sir,out[3]);
  
  dff d0(out[0],w[0],clk,reset);
  dff d1(out[1],w[1],clk,reset);
  dff d2(out[2],w[2],clk,reset);
  dff d3(out[3],w[3],clk,reset);
endmodule  


//Behavioral:

module usr_shift(input clk, input rst, input[1:0]s,input [3:0]din,input sin, output reg [3:0]q);
  always @ (posedge clk, posedge rst)
    begin
      if (rst)
        q<=4'b0000;
      else if (s==2'b01) //Shift Right
        q<={sin,q[2:0]};
      else if (s==2'b10) //Shift Left
        q<={q[3:1],sin};
      else if (s==2'b11)
        q<=din;
    end
endmodule

