
`timescale 1ns / 1ns
module tb();
  reg       mem_data_x;
  reg       mem_data_y;
  reg       cin;
  reg       lsb_y;
  reg       left_i;
  reg       right_i;
  reg       cin2c;
  reg [3:0] op_code;
  wire      x;
  wire      z;
  wire      cout;
  wire      y;
  
  
  bitslice bitslice(
    .mem_data_x (mem_data_x),
    .mem_data_y (mem_data_y),
    .lsb_y (lsb_y),
    .left_i (left_i),
    .right_i (right_i),
    .op_code (op_code),
    .cin (cin),
    .z (z),
    .cin2c(cin2c),
    .cout (cout)
  );
  
  initial begin
    mem_data_x = 0;
    mem_data_y = 0;
    cin = 0;
    op_code = 'b0000;
    lsb_y = 0;
    right_i = 0;
    left_i = 0;
    
    #5
    mem_data_x = 'b1;
    
    #30
    mem_data_y = 'b1;
    
    #30
    op_code = 'b0001;
    mem_data_y = 'b0;
    cin2c = 1'b1;
    
    #30
    op_code = 'b1000;
    mem_data_x = 'b0;
    
    #30
    mem_data_x = 'b1;
    mem_data_y = 'b0;
    op_code = 'b0110;
    
    #30
    op_code = 'b0111;
    
    #30 
    lsb_y = 0;
    op_code = 'b0101;
    
    #20
    op_code = 'b0011;
    mem_data_x = 0;
    
    #20
    right_i = 1;
    mem_data_x = 1;
    
    #10
    left_i = 0;
    op_code = 'b0100;
    
    #10
    mem_data_x = 0;
    
    
    
    
  end
  
  initial begin
    $monitor("Time=%g, mem_data_x=%b mem_data_y=%b, right_i=%b, left_i=%b, z=%b, cout=%b, opcode=%b",
      $time,mem_data_x,mem_data_y,right_i, left_i, z,cout,op_code);
  end
  
  initial begin
    #300 $finish;
  end
  
endmodule
