
`timescale 1ns / 1ns
module tbMain();
  
  reg CLK = 'b0;
  reg [11:0] OP_Code;
  
  reg [15:0] Mem_Data_X;
  reg [15:0] Mem_Data_Y;
  
  wire [15:0] X;
  wire [15:0] Y;
  wire [15:0] Z;
  
  reg [2:0] i;
  
  control control(
    .clk(CLK),
    .opcode(OP_Code),
    .Mem_Dat_X(Mem_Data_X),
    .Mem_Dat_Y(Mem_Data_Y),
    .Aout(X),
    .Bout(Y),
    .Cout(Z)
    );
    
  initial begin

    
    //Does multiplication for two 5 bit numbers
    
    #70
    //Mem_Data_X = 'd5;
    //Mem_Data_Y = 'd14;
    Mem_Data_X = -'d8;
    Mem_Data_Y = -'d15;
    OP_Code = 'b000000001011;  // Load X->B
    
    #70
    OP_Code = 'b000000001100;  // Load Y->C
    
    #70
    OP_Code = 'b001000000101;  // B & LSB C -> Ao


    for(i = 'd0; i < 'd5; i = i+'d1) begin
      #70
      OP_Code = 'b001000010011;  // B << 1 -> Bo
      
      #70
      OP_Code = 'b000000101010;  // C >> 1 -> Co
      
      if(Z[15] == 'b1 && i == 'd4) begin

        #70
        OP_Code = 'b100001001011;  // Bo -> B

        #50
        OP_Code = 'b001000011000;  // 2's complement B -> Bo
      end

      #70
      OP_Code = 'b100000001001;  // Ao -> A
      
      #70
      OP_Code = 'b100001001011;  // Bo -> B
      
     // #70
     // OP_Code = 'b010010001100;  // Co -> C
      
      #70
      OP_Code = 'b001110000101;  // B & LSB Co -> Ao

      #200
      OP_Code = 'b010000101100; // Ao -> C
      
      #70
      OP_Code = 'b000000000000;  // A + C -> Ao

      #70
      OP_Code = 'b010010001100;  // Co -> C

    end

      $display("A: %b, Bo: %b, Co: %b",X,Y,Z);

  end
  
  initial begin
    $monitor("Time=%g,X=%b,Y=%b,A=%b B=%b,C=%b,opcode=%b",
      $time,Mem_Data_X,Mem_Data_Y,X,Y,Z,OP_Code);
  end
  
  initial begin
    #4000 $finish;
  end
  
  initial begin
    Mem_Data_X = 'd0;
    Mem_Data_Y = 'd0;
    OP_Code = 'b1001;
  end
  
  always
    #1 CLK = !CLK;
  
endmodule
