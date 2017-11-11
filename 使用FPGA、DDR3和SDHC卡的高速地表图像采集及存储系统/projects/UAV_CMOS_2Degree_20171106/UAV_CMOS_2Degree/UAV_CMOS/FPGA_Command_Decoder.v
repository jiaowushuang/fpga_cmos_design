`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:52:18 09/22/2017 
// Design Name: 
// Module Name:    FPGA_Command_Decoder 
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
module FPGA_Command_Decoder(
								clk,command_latch,command_data,request_reset_signal,request_nframe_signal,usb_output,sd_output
							);
				input clk ;
				input command_latch ;
				input [7:0]command_data  ;
				output request_nframe_signal;
				output request_reset_signal;
				output usb_output          ;
				output sd_output           ;
				
				reg  request_reset_signal  ;
				reg  request_nframe_signal ;
				reg reset_flag             ;
				reg nframe_flag            ;
				reg usb_flag               ;
				reg sd_flag                ;
				reg usb_output          ;
				reg sd_output           ;
				reg reset_flag_falling_buf1;
				reg reset_flag_falling_buf2;
				reg nframe_flag_falling_buf1;
				reg nframe_flag_falling_buf2;
				reg usd_flag_falling_buf1  ;
				reg usd_flag_falling_buf2  ;
				reg sd_flag_falling_buf1   ;
				reg sd_flag_falling_buf2   ;
				reg [7:0]command_data_buf ;
				
				always @ ( posedge clk )
					begin
						if ( command_latch )
							begin
								command_data_buf  <= command_data ;
							end
						else
							begin
								if ( command_data_buf == 8'b10101010 )
									begin
										reset_flag <= 1 ;
										command_data_buf <= 0 ;
									end
								else
									if ( command_data_buf == 8'b01010101 )
										begin
											command_data_buf <= 0 ;
											nframe_flag       <= 1 ;
										end
									else
										if ( command_data_buf == 8'b01011010 )
											begin
												usb_flag         <= 1 ;
												command_data_buf <= 0 ;
											end
										else
											if ( command_data_buf == 8'b10100101 )
												begin
													command_data_buf <= 0 ;
													sd_flag          <= 1 ;
												end
											else
												begin
													reset_flag       <= 0 ;
													nframe_flag      <= 0 ;
													sd_flag          <= 0 ;
													usb_flag         <= 0 ;
												end
							end
					end
				always @ ( posedge clk )
					begin
						reset_flag_falling_buf1  <= reset_flag ;
						reset_flag_falling_buf2  <= reset_flag_falling_buf1 ;
						request_reset_signal     <= ( reset_flag_falling_buf2 ) && ( ~reset_flag_falling_buf1 ) ;
						nframe_flag_falling_buf1 <= nframe_flag ;
						nframe_flag_falling_buf2 <= nframe_flag_falling_buf1 ;
						request_nframe_signal    <= ( nframe_flag_falling_buf2 ) && ( ~nframe_flag_falling_buf1 ) ;
						usd_flag_falling_buf1    <= usb_flag ;
						usd_flag_falling_buf2    <= usd_flag_falling_buf1 ;
						usb_output               <= ( usd_flag_falling_buf2 ) && ( ~usd_flag_falling_buf1 ) ;
						sd_flag_falling_buf1     <= sd_flag ;
						sd_flag_falling_buf2     <= sd_flag_falling_buf1 ;
						sd_output                <= ( sd_flag_falling_buf2 ) && ( ~sd_flag_falling_buf1 ) ;
					end

endmodule
