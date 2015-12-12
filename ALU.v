`timescale 1ns / 1ns

module ALU(X, Y, op_code, Z);
  input [15:0] X;
  input [15:0] Y;
  input [3:0] op_code;
  
  wire c01;
  wire c12;
  wire c23;
  wire c34;
  wire c45;
  wire c56;
  wire c67;
  wire c78;
  wire c89;
  wire c910;
  wire c1011;
  wire c1112;
  wire c1213;
  wire c1314;
  wire c1415;
  
  wire [15:0] shiftVal;
  
  output wire [15:0] Z;
  
  assign shiftVal = (op_code[3] == 'b1) ? Y : X;
  
  always @ (X or Y) begin
    if(op_code == 'b0000) begin
      $display("X: %b, Y: %b", X, Y);
    end
  end
  
  bitslice bs0 (
    .mem_data_x(X[0]),
    .mem_data_y(Y[0]),
    .lsb_y(Y[0]),
    .left_i(shiftVal[1]),
    .right_i(1'b0),
    .op_code(op_code),
    .cin (1'b0),
    .cin2c(1'b1),
    .z(Z[0]),
    .cout (c01)
  );
  
  bitslice bs1 (
    .mem_data_x(X[1]),
    .mem_data_y(Y[1]),
    .lsb_y(Y[0]),
    .left_i(shiftVal[2]),
    .right_i(shiftVal[0]),
    .op_code(op_code),
    .cin (c01),
    .cin2c(c01),
    .z(Z[1]),
    .cout (c12)
  );
  
  bitslice bs2 (
    .mem_data_x(X[2]),
    .mem_data_y(Y[2]),
    .lsb_y(Y[0]),
    .left_i(shiftVal[3]),
    .right_i(shiftVal[1]),
    .op_code(op_code),
    .cin (c12),
    .cin2c(c12),
    .z(Z[2]),
    .cout (c23)
  );
  
  bitslice bs3 (
    .mem_data_x(X[3]),
    .mem_data_y(Y[3]),
    .lsb_y(Y[0]),
    .left_i(shiftVal[4]),
    .right_i(shiftVal[2]),
    .op_code(op_code),
    .cin (c23),
    .cin2c(c23),
    .z(Z[3]),
    .cout (c34)
  );
  
  bitslice bs4 (
    .mem_data_x(X[4]),
    .mem_data_y(Y[4]),
    .lsb_y(Y[0]),
    .left_i(shiftVal[5]),
    .right_i(shiftVal[3]),
    .op_code(op_code),
    .cin (c34),
    .cin2c(c34),
    .z(Z[4]),
    .cout (c45)
  );
  
  bitslice bs5 (
    .mem_data_x(X[5]),
    .mem_data_y(Y[5]),
    .lsb_y(Y[0]),
    .left_i(shiftVal[6]),
    .right_i(shiftVal[4]),
    .op_code(op_code),
    .cin (c45),
    .cin2c(c45),
    .z(Z[5]),
    .cout (c56)
  );
  
  bitslice bs6 (
    .mem_data_x(X[6]),
    .mem_data_y(Y[6]),
    .lsb_y(Y[0]),
    .left_i(shiftVal[7]),
    .right_i(shiftVal[5]),
    .op_code(op_code),
    .cin (c56),
    .cin2c(c56),
    .z(Z[6]),
    .cout (c67)
  );
  
  bitslice bs7 (
    .mem_data_x(X[7]),
    .mem_data_y(Y[7]),
    .lsb_y(Y[0]),
    .left_i(shiftVal[8]),
    .right_i(shiftVal[6]),
    .op_code(op_code),
    .cin (c67),
    .cin2c(c67),
    .z(Z[7]),
    .cout (c78)
  );
  
  bitslice bs8 (
    .mem_data_x(X[8]),
    .mem_data_y(Y[8]),
    .lsb_y(Y[0]),
    .left_i(shiftVal[9]),
    .right_i(shiftVal[7]),
    .op_code(op_code),
    .cin (c78),
    .cin2c(c78),
    .z(Z[8]),
    .cout (c89)
  );
  
  bitslice bs9 (
    .mem_data_x(X[9]),
    .mem_data_y(Y[9]),
    .lsb_y(Y[0]),
    .left_i(shiftVal[10]),
    .right_i(shiftVal[8]),
    .op_code(op_code),
    .cin (c89),
    .cin2c(c89),
    .z(Z[9]),
    .cout (c910)
  );
  
  bitslice bs10 (
    .mem_data_x(X[10]),
    .mem_data_y(Y[10]),
    .lsb_y(Y[0]),
    .left_i(shiftVal[11]),
    .right_i(shiftVal[9]),
    .op_code(op_code),
    .cin (c910),
    .cin2c(c910),
    .z(Z[10]),
    .cout (c1011)
  );
  
  bitslice bs11 (
    .mem_data_x(X[11]),
    .mem_data_y(Y[11]),
    .lsb_y(Y[0]),
    .left_i(shiftVal[12]),
    .right_i(shiftVal[10]),
    .op_code(op_code),
    .cin (c1011),
    .cin2c(c1011),
    .z(Z[11]),
    .cout (c1112)
  );
  
  bitslice bs12 (
    .mem_data_x(X[12]),
    .mem_data_y(Y[12]),
    .lsb_y(Y[0]),
    .left_i(shiftVal[13]),
    .right_i(shiftVal[11]),
    .op_code(op_code),
    .cin (c1112),
    .cin2c(c1112),
    .z(Z[12]),
    .cout (c1213)
  );
  
  bitslice bs13 (
    .mem_data_x(X[13]),
    .mem_data_y(Y[13]),
    .lsb_y(Y[0]),
    .left_i(shiftVal[14]),
    .right_i(shiftVal[12]),
    .op_code(op_code),
    .cin (c1213),
    .cin2c(c1213),
    .z(Z[13]),
    .cout (c1314)
  );
  
  bitslice bs14 (
    .mem_data_x(X[14]),
    .mem_data_y(Y[14]),
    .lsb_y(Y[0]),
    .left_i(shiftVal[15]),
    .right_i(shiftVal[13]),
    .op_code(op_code),
    .cin (c1314),
    .cin2c(c1314),
    .z(Z[14]),
    .cout (c1415)
  );
  
  bitslice bs15 (
    .mem_data_x(X[15]),
    .mem_data_y(Y[15]),
    .lsb_y(Y[0]),
    .left_i(shiftVal[15]),
    .right_i(shiftVal[14]),
    .op_code(op_code),
    .cin (c1415),
    .cin2c(c1415),
    .z(Z[15])
  );
  
endmodule
