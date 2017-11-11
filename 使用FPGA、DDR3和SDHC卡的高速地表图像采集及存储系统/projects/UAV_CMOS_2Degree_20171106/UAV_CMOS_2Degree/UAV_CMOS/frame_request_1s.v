`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:17:50 11/02/2017 
// Design Name: 
// Module Name:    frame_request_1s 
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
module frame_request_1s(
				             clk, initial_done,usb_request,sd_request ,request_new_frame
                        );
		input clk ;
		input initial_done;
		input usb_request ;
		input sd_request  ;
		output request_new_frame;
		
		reg   request_new_frame ;
		
		
		reg   request_flag ;
		reg   counter[20:0];
		always @ ( posedge clk )
			begin
				if ( initial_done == 0 )
					begin
						request_flag <= 0 ;
					end
				else
					if ( usb_request )
						begin
							request_flag <= 1 ;
						end
					else 
						if ( sd_request )
							begin
								request_flag <= 0 ;
							end
			end
		always @ ( posedge clk )
			begin
				if ( initial_done == 0 )
					begin
						request_new_frame <= 0 ;
					end
				else
					if ( counter == 21'h1E8480 )
						begin
							counter           <= 0 ;
							request_new_frame <= 1 ;
						end
					else
						begin
							counter <= counter + 1 ;
							request_new_frame <= 0 ;
						end
			end

endmodule
