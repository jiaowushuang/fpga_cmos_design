`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:48:40 09/16/2017 
// Design Name: 
// Module Name:    CMOS_RESET 
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
module CMOS_RESET(
							clk_input,
							cmos_reset,
							request_reset,
							PLL_Lock,
							reset_internal_module
						);
		 input clk_input  ;
		 input request_reset;
		 input PLL_Lock   ;
		 output reset_internal_module;
		 output cmos_reset;
		 
		 reg cmos_reset = 0;
		 reg reset_internal_module = 0;
       reg [14:0]reset_counter;
		 reg reset_flag1;
		 reg reset_flag2;
		 
		 always @ ( posedge clk_input )
			begin
				reset_flag1 <= cmos_reset ;
				reset_flag2 <= reset_flag1;
				reset_internal_module <= (reset_flag1) && (~reset_flag2);
			end
		 
		 always @ ( posedge clk_input )
			begin
				if ( request_reset )
					begin
						cmos_reset    <= 0 ;
						reset_counter <= 0 ;
					end
				else
					if ( reset_counter[14] )
						begin
							cmos_reset <= 1 ;
						end
					else
						begin
							reset_counter <= reset_counter + PLL_Lock ;
						end
			end
		 
		 

endmodule
