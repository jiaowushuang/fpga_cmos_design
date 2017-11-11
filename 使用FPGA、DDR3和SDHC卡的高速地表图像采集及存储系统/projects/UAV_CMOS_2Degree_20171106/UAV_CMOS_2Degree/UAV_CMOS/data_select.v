`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:59:25 10/22/2017 
// Design Name: 
// Module Name:    data_select 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module data_select(
			clk,data_in1,data_in2,data_out,data_select
    );
	 
	 input  clk ;
	 input  [15:0]data_in1,data_in2 ;
	 input  data_select ;
	 output [15:0]data_out ;
	 
	 
	 reg  [15:0]data_out ;
	 
	 always @ ( posedge clk )
		begin
			if ( data_select )
				begin
					data_out <= data_in1 ;
				end
			else
				begin
					data_out <= data_in2 ;
				end
		end


endmodule
