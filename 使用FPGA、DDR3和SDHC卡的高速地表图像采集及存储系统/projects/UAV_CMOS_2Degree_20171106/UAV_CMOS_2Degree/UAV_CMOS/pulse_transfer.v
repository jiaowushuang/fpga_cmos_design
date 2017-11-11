`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:22:26 09/19/2017 
// Design Name: 
// Module Name:    pulse_transfer 
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
module pulse_transfer(
								clk_original,
								clk_target,
								pulse_in,
								pulse_out
							);
			input clk_original ;
			input clk_target   ;
			input pulse_in     ;
			output pulse_out   ;
			
			reg    pulse_out   ;
			reg    pulse_indicator;
			reg    delay_buf1  ;
			reg    delay_buf2  ;
			reg    delay_buf3  ;
			reg    delay_buf4  ;
			reg    delay_buf   ;
			reg    pulse_buf1  ;
			reg    pulse_buf2  ;
			reg    pulse_out_buf;
			
			always @ ( posedge clk_original )
				begin
					if ( pulse_in )
						pulse_indicator <= pulse_indicator + 1 ;
				end
			always @ ( posedge clk_target )
				begin
					delay_buf1 <= pulse_indicator ;
					delay_buf2 <= delay_buf1      ;
					delay_buf3 <= delay_buf2      ;
					delay_buf4 <= delay_buf3      ;
					delay_buf  <= delay_buf1 && delay_buf2 && delay_buf3 && delay_buf4 ;
				end
			always @ ( posedge clk_target )
				begin
					pulse_buf1 <= delay_buf ;
					pulse_buf2 <= pulse_buf1;
					pulse_out_buf <= pulse_buf1 ^ pulse_buf2 ;
					pulse_out  <= pulse_out_buf ;
				end

endmodule
