`include "spi_master_design.sv"
`include "spi_slave_design.sv"

module top_design(input clk,rst,newd, input [11:0] din, output [11:0] dout, output done);
  wire sclk,cs,mosi;
  
  spi_master m1(clk,newd,rst,din,sclk,cs,mosi);
  spi_slave s1(sclk,cs,mosi,dout,done);
  
endmodule
