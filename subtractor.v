`timescale 1ns / 1ns
module subtractor(
  input cin, 
  input x, 
  input y, 
  output cout,
  output z);
  
  wire intermediate;
  assign intermediate = x ^ y;
  assign z = intermediate ^ cin;
  wire g,p;
  assign g = ~x & y;
  assign p = ~intermediate & cin;
  
  assign cout = g | p;
  
endmodule
