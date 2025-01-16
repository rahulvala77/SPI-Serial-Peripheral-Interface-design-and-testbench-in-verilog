`include "top_design.sv"

module tb_top;
  
  reg clk = 0, rst = 0, newd = 0;
  reg [11:0] din = 0;
  wire [11:0] dout;
  wire done;
  
  always #5 clk = ~clk;  // Clock period 10ns
  
  top_design dut(clk, rst, newd, din, dout, done);
  
  initial begin
    rst = 1;  // Apply reset
    repeat(5) @(posedge clk);  // Wait for a few clock cycles
    rst = 0;  // Deassert reset
    
    repeat(2) begin
      newd = 1;
      din = $urandom;  // Generate random input data
      @(posedge dut.s1.sclk);  // Wait for the slave's clock
      newd = 0;
      @(posedge done);  // Wait until the slave has processed data
      $display("Time = %0t din = %0d dout = %0d", $time, din, dout);
    end
    
    //#5000000;  // Wait for a maximum time (5ms)
    $finish;  // End the simulation
  end
endmodule
