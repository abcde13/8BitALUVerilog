`timescale 1ns / 1ns

module datapath(clk,ack,op_code_alu,
                aregread,cregread,
                aregwrite,bregwrite,cregwrite,
                aoutregread,boutregread,coutregread,
                outregwrite,//aoutregwrite,boutregwrite,coutregwrite,
                Mem_Dat_X,Mem_Dat_Y,
                Aout,Bout,Cout,
                /*Take this line out later*/ Areg,Breg,Creg);
  
  input clk;
  input ack;
  input [3:0] op_code_alu;
  
  input aregread;
  input cregread;
  
  input aregwrite;
  input bregwrite;
  input cregwrite;
  
  input aoutregread;
  input boutregread;
  input coutregread;
  
  /*input aoutregwrite;
  input boutregwrite;
  input coutregwrite;*/
  input [1:0] outregwrite;
  
  
  output [15:0] Aout;
  output [15:0] Bout;
  output [15:0] Cout;
  output [15:0] Areg;
  output [15:0] Breg;
  output [15:0] Creg;
  
  input [15:0] Mem_Dat_X;
  input [15:0] Mem_Dat_Y;
  
  reg [15:0] Areg;
  reg [15:0] Breg;
  reg [15:0] Creg;
  
  reg [15:0] Aout;
  reg [15:0] Bout; 
  reg [15:0] Cout;
  
  wire [15:0] X;
  wire [15:0] Y;
  wire [15:0] Z;
  
  ALU alu(
    .X(X),
    .Y(Y),
    .op_code(op_code_alu),
    .Z(Z)
  );
  
  assign X = (aregread == 'b1) ? Areg : Breg;
  
  assign Y = (cregread == 'b1) ? Creg :
             (aoutregread == 'b1) ? Aout :
             (boutregread == 'b1) ? Bout :
             (coutregread == 'b1) ? Cout : Y;
  
  always @(posedge clk)
  begin
    wait(ack);
    if(aregwrite == 'b1)
      begin  
          if(aoutregread == 'b1)
            Areg = Aout;
            
          else if(boutregread == 'b1)
            Areg = Bout;
          
          else
            Areg = Mem_Dat_X;    
      end
    
    else if(bregwrite == 'b1)
      begin  
          if(aoutregread == 'b1)
            Breg = Aout;
            
          else if(boutregread == 'b1)
            Breg = Bout;
            
          else if(coutregread == 'b1)
            Breg = Cout;
            
          else
            Breg = Mem_Dat_X;    
      end
    
    if(cregwrite == 'b1)
      begin   
          if(aoutregread == 'b1)
            Creg = Aout;
            
          else if(boutregread == 'b1)
            Creg = Bout;
          
          else if(coutregread == 'b1)
            Creg = Cout;
            
          else
            Creg = Mem_Dat_Y;  
      end
      

    if(outregwrite == 'b01) begin
      Aout = Z;
    end
    
    else if(outregwrite == 'b10)
      Bout = Z;
      
    else if(outregwrite == 'b11)
      Cout = Z;
    
  end
  
endmodule
