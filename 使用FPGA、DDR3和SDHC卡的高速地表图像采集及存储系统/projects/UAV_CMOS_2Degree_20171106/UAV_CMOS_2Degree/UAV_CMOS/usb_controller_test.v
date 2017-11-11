`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:59:31 09/15/2017
// Design Name:   usb_controller
// Module Name:   D:/03_FPGA_Project/01_UAV_CMOS/02_FPGA/UAV_CMOS/UAV_CMOS/usb_controller_test.v
// Project Name:  UAV_CMOS
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: usb_controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module usb_controller_test;

	// Inputs
	reg usb_clk;
	reg USB_FlagA;
	reg USB_FlagB;
	reg USB_FlagC;
	reg USB_FlagD;
	reg nframe;
	reg send_out;
	reg [15:0] parameter_data;
	reg [15:0] image_data;

	// Outputs
	wire [1:0] USB_FIFO_ADR;
	wire PKTEND;
	wire USB_SLWR;
	wire USB_SLRD;
	wire USB_SLOE;
	wire fifo_parameter_en;
	wire [15:0] receive_data;
	wire receive_data_en;
	wire fifo_image_en;

	// Bidirs
	wire [15:0] USB_DATA;

	// Instantiate the Unit Under Test (UUT)
	usb_controller uut (
		.usb_clk(usb_clk), 
		.USB_FlagA(USB_FlagA), 
		.USB_FlagB(USB_FlagB), 
		.USB_FlagC(USB_FlagC), 
		.USB_FlagD(USB_FlagD), 
		.USB_DATA(USB_DATA), 
		.USB_FIFO_ADR(USB_FIFO_ADR), 
		.PKTEND(PKTEND), 
		.USB_SLWR(USB_SLWR), 
		.USB_SLRD(USB_SLRD), 
		.USB_SLOE(USB_SLOE), 
		.nframe(nframe), 
		.send_out(send_out), 
		.parameter_data(parameter_data), 
		.fifo_parameter_en(fifo_parameter_en), 
		.receive_data(receive_data), 
		.receive_data_en(receive_data_en), 
		.image_data(image_data), 
		.fifo_image_en(fifo_image_en)
	);

	initial begin
		// Initialize Inputs
		usb_clk = 0;
		USB_FlagA = 1;
		USB_FlagB = 1;
		USB_FlagC = 1;
		USB_FlagD = 1;
		nframe = 0;
		send_out = 0;
		parameter_data = 0;
		image_data = 0;

		// Wait 100 ns for global reset to finish
		#10;
      #50 USB_FlagC = 0 ;
		// Add stimulus here
      #20 USB_FlagC = 1 ;
		#10 nframe = 1    ;
		#5  nframe = 0    ;
		#30 USB_FlagA = 0 ;
		#50 USB_FlagC = 0 ;
	end
always #1  usb_clk = ~ usb_clk ;      
endmodule

