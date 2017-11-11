`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:53:25 09/05/2017 
// Design Name: 
// Module Name:    CMOS_Command 
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
module CMOS_Command(
							clk_input,spi_idle_feedback,reset,
							data_write_spi,command_address_spi,execute_pulse_spi,
							da_ini_pa_in,cd_ad_ini_pa_in,ini_reqeuest,ini_lah,
							da_usb_in,usb_request,usb_empty,
							rd_fb_cd,rd_fb_da,rd_fb_lah,
							fd_to_usb_da,fd_to_usb_cd_ad,fifo_fd_en
						 );
						 
			input  clk_input ;
			input  spi_idle_feedback,reset;
//////////////////////////////////////////////////////
			output [15:0]data_write_spi;
			output [9:0]command_address_spi;
			output execute_pulse_spi;
			reg    [15:0]data_write_spi;
			reg    [9:0]command_address_spi;
			reg    execute_pulse_spi;
//////////////////////////////////////////////////////
			input  [15:0]da_ini_pa_in;
			input  [15:0]cd_ad_ini_pa_in;
			input  ini_lah ;
			output ini_reqeuest;
			reg    ini_reqeuest;
//////////////////////////////////////////////////////
			input  [15:0]da_usb_in;
			input  usb_lah        ;
			input  usb_empty      ;
			output usb_request    ;
			reg    usb_request    ;
/////////////////////////////////////////////////////
			input  [9:0]rd_fb_cd;
			input  [15:0]rd_fb_da;
			input  rd_fb_lah;
			output [15:0]fd_to_usb_da;
			output [15:0]fd_to_usb_cd_ad;
			reg    [15:0]fd_to_usb_da;
			reg    [15:0]fd_to_usb_cd_ad;
			reg    fifo_fd_en;
///////////////////////////////////////////////////
			parameter 
				power_up                 = 6'b000000 ,
				command_idle             = 6'b000001 ,
				cmose_interface_command  = 6'b000010 ,
				usb_command              = 6'b000100 ,
				command_busy             = 6'b001000 ;
				
			reg [5:0]main_state ;
			
			always @ ( posedge clk_input or posedge reset )
				begin
					if ( reset )
						begin
							main_state <= power_up ;
						end
					else
						begin
							case ( main_state )
								power_up :
									begin
										if ( spi_idle_feedback )
											begin
												main_state <= command_idle ;
											end
									end
								command_idle :
									begin
										if ( usb_lah )
											begin
												main_state <= usb_command ;
											end
									end
						end
				end
			


endmodule
