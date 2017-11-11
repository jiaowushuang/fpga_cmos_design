`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:51:17 09/22/2017 
// Design Name: 
// Module Name:    request_reset 
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
module request_reset(
								clk,command_latch,command_data,request_reset_signal
							);
				input clk ;
				input command_latch ;
				input [7:0]command_data  ;
				output request_reset_signal;
				
				reg  request_reset_signal  ;
				reg reset_flag      ;
				reg reset_flag_falling_buf1;
				reg reset_flag_falling_buf2;
				reg [7:0]command_data_buf ;
				
				always @ ( posedge clk )
					begin
						if ( command_latch )
							begin
								command_data_buf  <= command_data ;
							end
						else
							if ( command_data_buf == 8'b10101010 )
								begin
									reset_flag <= 1 ;
								end
							else
								begin
									command_data_buf <= 0 ;
									reset_flag       <= 0 ;
								end
					end
				always @ ( posedge clk )
					begin
						reset_flag_falling_buf1 <= reset_flag ;
						reset_flag_falling_buf2 <= reset_flag_falling_buf1 ;
						request_reset_signal    <= ( reset_flag_falling_buf2 ) && ( ~reset_flag_falling_buf1 ) ;
					end

endmodule
