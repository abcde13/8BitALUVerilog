
`timescale 1ns / 1ns
module tbDatapath();
  
  reg clk = 'b0;
  reg [3:0] op_code;
  
  
  reg aregread;
  reg cregread;
  
  reg aregwrite;
  reg bregwrite;
  reg cregwrite;
  
  reg aoutregread;
  reg boutregread;
  reg coutregread;
  
  /*reg aoutregwrite;
  reg boutregwrite;
  reg coutregwrite;*/
  reg [1:0] outregwrite;
  
  reg [15:0] Mem_Dat_X;
  reg [15:0] Mem_Dat_Y;
  
  wire [15:0] Aout;
  wire [15:0] Bout;
  wire [15:0] Cout;
  
  wire [15:0] Areg;
  wire [15:0] Breg;
  wire [15:0] Creg;
  
  datapath datapath(
    .clk(clk),
    .op_code_alu(op_code),
    .aregread(aregread),
    .cregread(cregread),
    .aregwrite(aregwrite),
    .bregwrite(bregwrite),
    .cregwrite(cregwrite),
    .aoutregread(aoutregread),
    .boutregread(boutregread),
    .coutregread(coutregread),
    //.aoutregwrite(aoutregwrite),
    //.boutregwrite(boutregwrite),
    //.coutregwrite(coutregwrite),
    .outregwrite(outregwrite),
    .Mem_Dat_X(Mem_Dat_X),
    .Mem_Dat_Y(Mem_Dat_Y),
    .Aout(Aout),
    .Bout(Bout),
    .Cout(Cout),
    .Areg(Areg),
    .Breg(Breg),
    .Creg(Creg)
    );
  
  initial begin
    aregread = 'b0;
    cregread = 'b0;
    aregwrite = 'b0;
    bregwrite = 'b0;
    cregwrite = 'b0;
    aoutregread = 'b0;
    boutregread = 'b0;
    coutregread = 'b0;
    //aoutregwrite = 'b0;
    //boutregwrite = 'b0;
    //coutregwrite = 'b0;
    outregwrite = 'b00;
    Mem_Dat_X = 'd0;
    Mem_Dat_Y = 'd0;
    op_code = 'b0000;
    
    #20
    
    Mem_Dat_X = 'd5;
    Mem_Dat_Y = 'd1;
    aregwrite = 'b1;
    cregwrite = 'b1;
    
    #50
    
    aregwrite = 'b0;
    cregwrite = 'b0;
    aregread = 'b1;
    outregwrite = 'b01;
    cregread = 'b1;
    
    #50
    op_code = 'b0111;
    Mem_Dat_X = 'd5;
    Mem_Dat_Y = 'd2;
    aregwrite = 'b1;
    outregwrite = 'b00;
    cregwrite = 'b1;
    aregread = 'b0;
    cregread = 'b0;
    
    #50
    aregwrite = 'b0;
    cregwrite = 'b0;
    aregread = 'b1;
    outregwrite = 'b10;
    cregread = 'b1;
    
    #50
    op_code = 'b0011;
    Mem_Dat_X = 'd5;
    Mem_Dat_Y = 'd14;
    bregwrite = 'b1;
    outregwrite = 'b00;
    cregwrite = 'b0;
    aregread = 'b0;
    cregread = 'b0;
    
    #50
    
    bregwrite = 'b0;
    outregwrite = 'b10;
    
    #50
    op_code = 'b1010; 
    cregwrite = 'b1;
    outregwrite = 'b00;
    aregread = 'b0;
    cregread = 'b0;
    
    #50
    cregread = 'b1;
    outregwrite = 'b11;
    cregwrite = 'b0;


    
  end
  
  initial begin
    $monitor("Time=%g,Areg=%b,Breg=%b,Creg=%b,A=%b B=%b,C=%b,opcode=%b",
      $time,Areg,Breg,Creg,Aout,Bout,Cout,op_code);
  end
  
  initial begin
    #1000 $finish;
  end
  
  always 
    #1 clk = !clk;
  
endmodule