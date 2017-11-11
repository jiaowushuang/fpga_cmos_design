`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:31:56 09/12/2017 
// Design Name: 
// Module Name:    generate_addr 
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
module generate_addr(	
							clk_in,
							command_address,
							data,
							reset);
		input clk_in ;
		input reset  ;
		output [9:0]command_address;
		output [15:0]data;
		
		reg  [9:0]command_address;
		reg  [15:0]data;
		
		reg  flag = 0 ;
		
		always @ ( posedge  clk_in )
			begin
				if ( reset )
					flag <= ~flag ;
			end
		always @ ( posedge clk_in )
			begin
				if ( flag )
					begin
						command_address <= 10'b0000000101 ;
						data            <= 16'h0001       ;
					end
				else
					begin
						command_address <= 10'b0000100010 ;
					end
			end
							


endmodule
