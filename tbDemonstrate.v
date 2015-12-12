
`timescale 1ns / 1ns
module tbDemonstrate();
  
  reg clk = 'b0;
  reg [11:0] op_code;
  
  reg [15:0] Mem_Dat_X;
  reg [15:0] Mem_Dat_Y;
  
  wire [15:0] X;
  wire [15:0] Y;
  wire [15:0] Z;
  
  reg [2:0] i;
  
  demonstrate demonstrate(
    .CLK(clk),
    .Mem_Data_X(Mem_Dat_X),
    .Mem_Data_Y(Mem_Dat_Y),
    .X(X),
    .Y(Y),
    .Z(Z)
    );
    
  initial begin
    #2
    //Mem_Dat_X = 'd31;
    Mem_Dat_X = -'d13;
    Mem_Dat_Y = -'d9;
  end

  always
    #1 clk = !clk;

  initial begin
    $monitor("Time=%g,X=%b,Y=%b,Xout=%b Yout=%b,Zout=%b",
      $time,Mem_Dat_X,Mem_Dat_Y,X,Y,Z);
  end
  
  initial begin
    #10000 $finish;
  end

endmodule
