`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:29:03 09/15/2017 
// Design Name: 
// Module Name:    LED_Working 
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
module LED_Working( clk_input,LED );
		input clk_input ;
		output LED ;
		
		reg  LED ;
		
		reg [23:0]counter ;
		
		always @ ( posedge clk_input )
			begin
				if ( counter[23] == 1 )
					begin
						LED <= ~LED ;
						counter <= 0 ;
					end
				else
					begin
						counter <= counter + 1 ;
					end
			end


endmodule
