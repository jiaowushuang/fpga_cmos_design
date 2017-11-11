`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:37:56 09/23/2017 
// Design Name: 
// Module Name:    generate_frame 
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
module generate_frame(
								clk,nframe_output,
								command_fifo_empty,spi_idle_fd
							);
							
		 input clk ;
		 input command_fifo_empty ;
		 input spi_idle_fd ;
		 output nframe_output;
		 reg    nframe_output;
		 
		 reg nframe_flag ;
		 
		 always @ ( posedge clk )
			begin
				if ( command_fifo_empty )
					nframe_flag <= 1 ;
				else
					if ( nframe_flag )
						begin
							if ( spi_idle_fd )
								begin
									nframe_flag <= 0 ;
									nframe_output <= 1 ;
								end
						end
					else
						begin
							nframe_output <= 0;
						end
			end


endmodule
