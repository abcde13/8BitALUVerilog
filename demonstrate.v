
module demonstrate (
    input          CLK,
    input   [15:0] Mem_Data_X,
    input   [15:0] Mem_Data_Y,
    output  [15:0] X,
    output  [15:0] Y,
    output  [15:0] Z
  );

  wire [15:0] Mem_Data_X;
  wire [15:0] Mem_Data_Y;
  reg [11:0] OP_Code;
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

  always @ (Mem_Data_X or Mem_Data_Y) begin
    add();
    #10;
    two_complement();
    #10;
    right_shift();
    #10;
    multiply();
  end

  task multiply;
    begin
      
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

        #70
        OP_Code = 'b010000101100; // Ao -> C
        
        #70
        OP_Code = 'b000000000000;  // A + C -> Ao

        #70
        OP_Code = 'b010010001100;  // Co -> C
      end
  
      $display("X * Y = %b",X);
    end

  endtask

  task add;
    begin
      OP_Code = 'b000000001011;  // Load X->B
      
      #10
      OP_Code = 'b000000001100;  // Load Y->C
      
      #28
      OP_Code = 'b001000000000;  // B + C -> Ao
      #100
      $display("X + Y = %b ",X);
    end

  endtask
      
  task two_complement;
    begin
      OP_Code = 'b000000001011;  // Load X->B
      
      #10
      OP_Code = 'b001000001000;  // 2's complement B -> Ao
      
      #100
      $display("2's complement of X = %b",X);
    end

  endtask

  task right_shift;
    begin
      OP_Code = 'b000000001011;  // Load X->B
      #10
      OP_Code = 'b001000000100;  // B >> 1 -> Ao
      #70
      OP_Code = 'b100000001011;  // Ao -> B
      #70
      OP_Code = 'b001000000100;  // B >> 1 -> Ao
      #70
      $display("X >> 2 = %b",X);
    end
  endtask


endmodule




