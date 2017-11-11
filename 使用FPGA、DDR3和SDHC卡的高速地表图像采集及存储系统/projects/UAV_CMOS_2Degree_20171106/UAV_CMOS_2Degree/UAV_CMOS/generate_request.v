`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:43:15 11/03/2017 
// Design Name: 
// Module Name:    generate_request 
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
module generate_request( 
								clk,initial_done,frame_triger,write_frame_done,write_start,black_output,
								usb_request,sd_request,request_frame,request_usb,request_sd,request_data,request_flag
							);
							
		input clk ;
		input initial_done;
		input write_frame_done;
		output write_start ;
		output frame_triger;
		input black_output;
		input usb_request ;
		input sd_request  ;
		input request_frame;
		input request_usb ;
		input request_sd;
		output request_data;
		output request_flag;
		reg  request_data ;

		reg  write_start ;
		reg  frame_triger;
		reg  initial_done_buf1;
		reg  initial_done_buf2;
		reg  initial_done_rise;
		reg  flag_frame_triger;
		reg  write_start_buf1 ;
		reg  write_start_buf2 ;
		reg  request_flag  = 0;
		always @ ( posedge clk )
			begin
				if ( request_flag )
					begin
						request_data <= request_usb ;
					end
				else
					begin
						request_data <= request_sd  ;
					end
			end
		always @ ( posedge clk )
			begin
				if ( request_flag )
					begin
						initial_done_buf1 <= 1 ;
					end
				else
					begin
						initial_done_buf1 <= initial_done ;
					end
				//initial_done_buf1 <= initial_done ;
				initial_done_buf2 <= initial_done_buf1 ;
				initial_done_rise <= ( ~ initial_done_buf2 ) && ( initial_done_buf1 ) ;
			end
		always @ ( posedge clk )
			begin
				if ( usb_request )
					begin
						request_flag <= 1 ;
					end
				else
					if ( sd_request )
						begin
							request_flag <= 0 ;
						end
				if ( request_flag )
					begin
						frame_triger <= request_frame ;
					end
				else
					begin
						frame_triger <= initial_done_rise || write_frame_done ;
					end
			end
		always @ ( posedge clk )
			begin
				if ( frame_triger )
					begin
						flag_frame_triger <= 0 ;
					end
				else
					if ( black_output )
						begin
							flag_frame_triger <= 1 ;
						end
			end
		always @ ( posedge clk )
			begin
				write_start_buf1 <= flag_frame_triger ;
				write_start_buf2 <= write_start_buf1  ;
				write_start      <= ( ~write_start_buf2 ) && ( write_start_buf1 ) ;
			end
endmodule
