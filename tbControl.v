
`timescale 1ns / 1ns
module tbControl();
  
  reg clk = 'b0;
  reg [11:0] op_code;
  
  reg [15:0] Mem_Dat_X;
  reg [15:0] Mem_Dat_Y;
  
  wire [15:0] Aout;
  wire [15:0] Bout;
  wire [15:0] Cout;
  
  reg [2:0] i;
  
  control control(
    .clk(clk),
    .opcode(op_code),
    .Mem_Dat_X(Mem_Dat_X),
    .Mem_Dat_Y(Mem_Dat_Y),
    .Aout(Aout),
    .Bout(Bout),
    .Cout(Cout)
    );
    
  initial begin

    
    //Does multiplication for two positive 5 bit numbers
    
    #70
    //Mem_Dat_X = 'd5;
    //Mem_Dat_Y = 'd14;
    Mem_Dat_X = -'d8;
    Mem_Dat_Y = -'d15;
    op_code = 'b000000001011;  // Load X->B
    
    #70
    op_code = 'b000000001100;  // Load Y->C
    
    #70
    op_code = 'b001000000101;  // B & LSB C -> Ao


    for(i = 'd0; i < 'd5; i = i+'d1) begin
      #70
      op_code = 'b001000010011;  // B << 1 -> Bo
      
      #70
      op_code = 'b000000101010;  // C >> 1 -> Co
      
      if(Cout[15] == 'b1 && i == 'd4) begin

        #70
        $display("Before 2's: %b",Bout);
        op_code = 'b100001001011;  // Bo -> B

        #50
        op_code = 'b001000011000;  // 2's complement B -> Bo
        #80
        $display("2's: %b",Bout);
      end
      #70
      $display("A: %b",Aout);
      op_code = 'b100000001001;  // Ao -> A
      
      #70
      op_code = 'b100001001011;  // Bo -> B
      
     // #70
     // op_code = 'b010010001100;  // Co -> C
      
      #70
      $display("LSB Co: %b", Cout);
      op_code = 'b001110000101;  // B & LSB Co -> Ao

      #200
      $display("C: %b",Aout);
      op_code = 'b010000101100; // Ao -> C
      
      #70
      op_code = 'b000000000000;  // A + C -> Ao

      #70
      $display("Ao: %b, Bo: %b, Co: %b",Aout,Bout,Cout);
      op_code = 'b010010001100;  // Co -> C
    end

  end
  
  initial begin
    $monitor("Time=%g,X=%b,Y=%b,A=%b B=%b,C=%b,opcode=%b",
      $time,Mem_Dat_X,Mem_Dat_Y,Aout,Bout,Cout,op_code);
  end
  
  initial begin
    #4000 $finish;
  end
  
  initial begin
    Mem_Dat_X = 'd0;
    Mem_Dat_Y = 'd0;
    op_code = 'b1001;
  end
  
  always
    #1 clk = !clk;
  
endmodule
