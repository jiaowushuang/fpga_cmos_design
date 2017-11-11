`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:23:22 10/30/2017 
// Design Name: 
// Module Name:    usb_reset 
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
module usb_reset( clk,initial_done,reset_out );
			input clk ;
			input initial_done;
			output reset_out   ;
			reg    reset_out   ;
			
			
			reg    [12:0]reset_counter ;
			
			always @ ( posedge clk )
				begin
					if ( initial_done == 0 )
						begin
							reset_out <= 0 ;
							reset_counter <= 0 ;
						end
					else
						if ( reset_counter[12] )
							begin
								reset_out <= 1 ;
							end
						else
							begin
								reset_counter <= reset_counter + 1;
							end
				end

endmodule
