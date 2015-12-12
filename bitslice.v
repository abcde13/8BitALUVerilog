`timescale 1ns / 1ns

module bitslice(mem_data_x, mem_data_y, lsb_y, left_i,right_i, op_code, cin, cin2c, z, cout);
  output z;
  output cout;
  input cin;
  input cin2c;
  input mem_data_x;
  input mem_data_y;
  input lsb_y;
  input left_i;
  input right_i;
  input[3:0] op_code;
  
  reg z;
  reg cout;
  
  wire complement_out,add_cout,add_out,sub_out,sub_cout, complement_cout;

  always @ (*) begin
    case(op_code)
      'b1000: begin
        z <= #5 complement_out ;
        cout <= #1 complement_cout;
      end
      'b0011: begin
        z <= #5 right_i ;
        cout <= #5 mem_data_x;
      end
      'b0100: begin
        z <= #5 left_i ;
        cout <= #5 mem_data_x;
      end
      'b1010: begin
        z <= #0.217 left_i;
        cout <= #0.217 mem_data_y;
      end
      'b0010: z <= #0.232 'b0 ;
      'b0101: z <= #0.216 mem_data_x & lsb_y ;
      'b0110: z <= #0.209 mem_data_x & mem_data_y ;
      'b0111: z <= #0.250 mem_data_x | mem_data_y ;
      'b0000: begin
        z <= #7 add_out ;
        cout <= #3 add_cout;
      end
      default: begin
         z <= #10 sub_out;
         cout <= #5 sub_cout;
      end
    endcase
  end
  
  adder complement_adder(
    cin2c,
    ~mem_data_x,
    1'b0,
    complement_cout,
    complement_out
  );
  
  adder adder(
    cin,
    mem_data_x,
    mem_data_y,
    add_cout,
    add_out
  );
  
  subtractor subtractor(
    cin,
    mem_data_x,
    mem_data_y,
    sub_cout,
    sub_out
  );
  
  
        
  
endmodule
  
