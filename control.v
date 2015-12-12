
module control(
    clk,
    opcode,
    Mem_Dat_X,
    Mem_Dat_Y,
    Aout,
    Bout,
    Cout,
  );
  
  input         clk;
  input  [15:0] Mem_Dat_X;
  input  [15:0] Mem_Dat_Y;
  input   [11:0] opcode;
  
  output [15:0] Aout;
  output [15:0] Bout;
  output [15:0] Cout;
  
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
  
  
  
  wire [15:0] Aout;
  wire [15:0] Bout;
  
  reg evaluate = 'b0;
  reg  [6:0] counter = 'b0;
  
  
  
  /* 
  *   IMPORTANT
  *
  *   OPCODE BREAKDOWN
  *
  *   Passed to the control block is a 12 bit opcode. There are 8 prefix bits and 4 ALU bits.
  *   The meaning of each are as follows
  *
  *   M1  M2  M3  M4  M5  M5  RegOut RegOut ALU ALU ALU ALU
  *
  *   M1 through M5 are the selector bits for each of the 5 MUX's (M5 has two bits for 3 inputs)
  *
  *   RegOut indicates which register (A,B,C) to write to (2 bits are needed for 3 outputs)
  *
  *   ALU indicates the 4 bit opcode for the ALU
  *
  *   If the last four bits are an actual operation in the ALU, then the following decoding is used:
  *
  *   1) Observe M3 to choose which register, A or B, to read from.
  *   2) Observe M4 to choose to either read from reg C or from output registers.
  *   3) If M4 is reading from feedback, observe M5 to see which output register to read from.
  *
  *   If the last four bits are a datapth operation (Load into A/B/C) then the following decoding is used:
  *
  *   1) Observe opcode. If it is Load A/B, observe M1 to either read X or read from feedback.
  *   2) If M1 indicates to observe from feedback, observe M5 to see which output register to read from.
  *   3) If opcode indicates to Load C, observe M2 to either read Y or read from feedback.
  *   4) If M2 indicates to observe from feedback, observe M5 to see which output register to read from.
  *
  */
  
  datapath datapath(
    .clk(clk),
    .op_code_alu(opcode[3:0]),
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
    .Cout(Cout)
    );
    
  
  //assign Aout[0] = aregwrite;
  //assign Bout[0] = evaluate;
  //assign Cout = counter; 
  initial begin
    aregwrite <= 'b0;
    bregwrite <= 'b0;
    cregwrite <= 'b0;
    /*aoutregwrite <= 'b0;
    boutregwrite <= 'b0;
    coutregwrite <= 'b0;*/
    outregwrite <= 'b00;
    aregread <= 'b0;
    cregread <= 'b0;
    aoutregread <= 'b0;
    boutregread <= 'b0;
    coutregread <= 'b0;
  end
    
  
  always @ (posedge clk) begin
    aregwrite <= 'b0;
    bregwrite <= 'b0;
    cregwrite <= 'b0;
    /*aoutregwrite <= 'b0;
    boutregwrite <= 'b0;
    coutregwrite <= 'b0;*/
    outregwrite <= 'b00;
    aregread <= 'b0;
    cregread <= 'b0;
    aoutregread <= 'b0;
    boutregread <= 'b0;
    coutregread <= 'b0;
    
    case(opcode[3:0])
    'b1001,'b1011, 'b1100: begin
      if(opcode[3:0] == 'b1001) begin
        aregwrite <= 'b1;
        bregwrite <= 'b0;
        cregwrite <= 'b0;
      end
      else if(opcode[3:0] == 'b1011) begin
        aregwrite <= 'b0;
        bregwrite <= 'b1;
        cregwrite <= 'b0;
      end
      else if(opcode[3:0] == 'b1100) begin
        aregwrite <= 'b0;
        bregwrite <= 'b0;
        cregwrite <= 'b1;
      end
      if((opcode[3:0] == 'b1100 && opcode[10] =='b0) ||
          (opcode[3:0] != 'b1100 && opcode[11] =='b0)) begin
        aoutregread <= 'b0;
        boutregread <= 'b0;
        coutregread <= 'b0;
      end
      else begin
        if(opcode[7:6] == 'b00) begin
          aoutregread <= 'b1;
          boutregread <= 'b0;
          coutregread <= 'b0;
        end
        else if(opcode[7:6] == 'b01) begin
          aoutregread <= 'b0;
          boutregread <= 'b1;
          coutregread <= 'b0;
        end
        else begin
          aoutregread <= 'b0;
          boutregread <= 'b0;
          coutregread <= 'b1;
        end
      end
    end
    default: begin
      
      if(opcode[9] == 'b0)
        aregread <= 'b1;
      else
        aregread <= 'b0;
        
      if(opcode[8] == 'b0) begin
        cregread <= 'b1;
        aoutregread <= 'b0;
        boutregread <= 'b0;
        coutregread <= 'b0;
      end
      else begin
        if(opcode[7:6] == 'b00) begin
          aoutregread <= 'b1;
          boutregread <= 'b0;
          coutregread <= 'b0;
        end
        else if(opcode[7:6] == 'b01) begin
          aoutregread <= 'b0;
          boutregread <= 'b1;
          coutregread <= 'b0;
        end
        else if(opcode[7:6] == 'b10) begin
          aoutregread <= 'b0;
          boutregread <= 'b0;
          coutregread <= 'b1;
        end
        else begin
          aoutregread <= 'b0;
          boutregread <= 'b0;
          coutregread <= 'b0;
        end
      end
      
      if(opcode[5:4] == 'b00) begin
        /*aoutregwrite <= 'b1;
        boutregwrite <= 'b0;
        coutregwrite <= 'b0;*/
        outregwrite = 'b01;
  //      $display("00 o: %b",outregwrite);
        //$display("a:%b,b:%b,c:%b",aoutregwrite,boutregwrite,coutregwrite);
      end
      else if(opcode[5:4] == 'b01) begin
        /*aoutregwrite <= 'b0;
        boutregwrite <= 'b1;
        coutregwrite <= 'b0;*/
        outregwrite = 'b10;
 //       $display("00 o: %b",outregwrite);
        //$display("a:%b,b:%b,c:%b",aoutregwrite,boutregwrite,coutregwrite);
      end
      else if(opcode[5:4] == 'b10) begin
        /*aoutregwrite <= 'b0;
        boutregwrite <= 'b0;
        coutregwrite <= 'b1;*/
        outregwrite='b11;
//        $display("00 o: %b",outregwrite);
        //$display("a:%b,b:%b,c:%b",aoutregwrite,boutregwrite,coutregwrite);
      end
      else begin
        /*aoutregwrite <= 'b0;
        boutregwrite <= 'b0;
        coutregwrite <= 'b0;*/
        outregwrite = 'b00;
      end
    end
    endcase
  end
  
        
      
  
endmodule

