
module main (
    input          CLK,
    input   [15:0] Mem_Data_X,
    input   [15:0] Mem_Data_Y,
    input   [11:0] OP_Code,
    output  [15:0] X,
    output  [15:0] Y,
    output  [15:0] Z
  );

  wire [15:0] Mem_Data_X;
  wire [15:0] Mem_Data_Y;
  wire [11:0] OP_Code;
  reg [3:0] i;

  wire [15:0] X;
  wire [15:0] Y;
  wire [15:0] Z;
  

  control control(
    .clk(CLK),
    .opcode(OP_Code),
    .Mem_Dat_X(Mem_Data_X),
    .Mem_Dat_Y(Mem_Data_Y),
    .Aout(X),
    .Bout(Y),
    .Cout(Z)
  );

endmodule
