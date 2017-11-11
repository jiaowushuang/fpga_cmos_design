`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:40:59 09/05/2017
// Design Name:   SPI_BUS
// Module Name:   D:/03_FPGA_Project/01_UAV_CMOS/02_FPGA/UAV_CMOS/UAV_CMOS/SPI_BUS_Test.v
// Project Name:  UAV_CMOS
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SPI_BUS
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module SPI_BUS_Test;

	// Inputs
	reg clk_input;
	reg MISO;
	reg [15:0] data_write;
	reg [9:0] command_address;
	reg reset;
	reg execute_pulse;

	// Outputs
	wire SCLK;
	wire SS_N;
	wire MOSI;
	wire [15:0] data_read;

	// Instantiate the Unit Under Test (UUT)
	SPI_BUS uut (
		.clk_input(clk_input), 
		.SCLK(SCLK), 
		.SS_N(SS_N), 
		.MOSI(MOSI), 
		.MISO(MISO), 
		.data_write(data_write), 
		.data_read(data_read), 
		.command_address(command_address), 
		.reset(reset), 
		.execute_pulse(execute_pulse)
	);

	initial begin
		// Initialize Inputs
		clk_input = 0;
		MISO = 0;
		data_write = 0;
		command_address = 0;
		reset = 0;
		execute_pulse = 0;

		// Wait 100 ns for global reset to finish
		#10;
      #1  reset = 1 ;
		#5  reset = 0 ;
		// Add stimulus here
		#2  command_address = 10'b1100110011 ;
		data_write = 16'hAAAA;
		#3 execute_pulse = 1 ;
		#3 execute_pulse = 0 ;
		#180
		#2  command_address = 10'b1100110010 ;
		MISO = 1 ;
		#3 execute_pulse = 1 ;
		#3 execute_pulse = 0 ;
		
	end
   always #1  clk_input = ~ clk_input ;
endmodule

