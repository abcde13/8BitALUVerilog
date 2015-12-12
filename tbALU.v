
`timescale 1ns / 1ns
module tbALU();
  reg [15:0] X;
  reg [15:0] Y;
  reg [3:0] op_code;
  
  wire [15:0] Z;
  
  ALU alu (
    .X(X),
    .Y(Y),
    .op_code(op_code),
    .Z(Z)
  );
  
  initial begin
    #40
    X = 'd5;
    Y = 'd2;
    op_code = 'b0000;
    
    #120
    X = 'b0000000110000100;
    Y = 'b0000000101111010;
    op_code = 'b0000; // add
    
    #120
    X = 'b0010100111111100;
    
    #120
    Y = 'b0000000000000001;
    
    #120
    X = 'b0111111111111111;
    Y = 'b0000000000000001;

    #170
    op_code = 'b0001; // subtract

    
    #90
    op_code = 'b1000; // 2's complement
    
    #90
    X = 'b0110100111111101;
    Y = 'b0100000000011101;
    op_code = 'b0110; // bitwise and
    
    #10
    op_code = 'b0101; // lsb and
  
    #90
    Y = 'b1000000000000011;
    op_code = 'b0111; // bitwise or
    
    #90
    X = 'b1100000111111001;
    op_code = 'b0100; // right shift X
    
    #90
    op_code = 'b0011; // left shift X
    
    #10
    op_code = 'b1010; // right shift Y
    
    #10
    op_code = 'b0010; // clear
    
  end
  
  initial begin
    $monitor("Time=%g, X=%b Y=%b,Z=%b,opcode=%b",
      $time,X,Y,Z,op_code);
  end
  
  initial begin
    #1000 $finish;
  end
  
endmodule
