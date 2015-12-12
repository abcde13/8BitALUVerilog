
`timescale 1ns / 1ns
module adder(
  input cin, 
  input x, 
  input y, 
  output cout,
  output z);
  
  wire intermediate;
  assign intermediate = x ^ y;
  assign z = intermediate ^ cin;
  wire g,p;
  assign g = x & y;
  assign p = intermediate;
  
  assign cout = g | (p & cin);
  
endmodule