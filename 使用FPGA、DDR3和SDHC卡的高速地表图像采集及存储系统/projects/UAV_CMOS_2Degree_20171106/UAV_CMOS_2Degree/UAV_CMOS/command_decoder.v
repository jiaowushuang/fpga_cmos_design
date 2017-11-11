`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:26:42 09/18/2017 
// Design Name: 
// Module Name:    command_decoder 
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
module command_decoder(
								clk_input,
								reset    ,
								intial_done,
								receive_en,
								data_in,
								CMOS_command,
								fifo_cmos_en,
								FPGA_command,
								config_ram_addr,
								config_ram_en,
								FPGA_command_latch
							 );
			input  clk_input           ;
			input  reset               ;
			input  receive_en          ;
			input  [15:0]data_in       ;
			input  intial_done         ;
			output [15:0]CMOS_command  ;
			output [7:0]FPGA_command   ;
			output fifo_cmos_en        ;
			output config_ram_en       ;
			output [8:0]config_ram_addr;
			output FPGA_command_latch  ;
			
			
			reg [15:0]CMOS_command  ;
			reg [7:0]FPGA_command  ;
			reg [15:0]command_buf   ;
			reg fifo_cmos_en        ;
			reg config_ram_en       ;
			reg [8:0]config_ram_addr;
			reg [8:0]config_ram_addr_buf;
			reg FPGA_command_latch  ;
			reg FPGA_command_latch_flag;
			reg FPGA_command_latch_buf1;
			
			reg [15:0]data_in_buf ;
			reg [15:0]data_in_buf1;
			reg [15:0]data_in_buf2;
			reg [15:0]data_in_buf3;
			reg flag_7C ;
			reg flag_D2 ;
			reg flag_15 ;
			reg flag_D8 ;
			reg flag_head;
			reg [3:0]command_state ;
			reg receive_en_delay1   ;
			reg receive_en_delay2   ;
			reg receive_en_delay3   ;
			reg receive_en_delay    ;
			parameter 
				power_up  = 4'b0000 ,
				cd_idle   = 4'b0001 ,
				cd_cmos   = 4'b0010 ,
				cd_config = 4'b0100 ,
				cd_judge  = 4'b1000 ;
			always @ ( posedge clk_input )
				begin
					FPGA_command_latch_buf1 <= FPGA_command_latch_flag ;
					FPGA_command_latch      <= ( ~FPGA_command_latch_buf1 ) && FPGA_command_latch_flag ;
				end
			always @ ( posedge clk_input )
				begin
					receive_en_delay1 <= receive_en ;
					receive_en_delay2 <= receive_en_delay1;
					receive_en_delay3 <= receive_en_delay2;
					receive_en_delay  <= receive_en_delay3;
				end
			always @ ( posedge clk_input )
				 begin
					data_in_buf <= data_in ;
					data_in_buf1 <= data_in_buf ;
					data_in_buf2 <= data_in_buf1;
					data_in_buf3 <= data_in_buf2;
				 end
			always @ ( posedge clk_input )
				begin
					CMOS_command <= data_in_buf3 ;
				end
			always @ ( posedge clk_input )
				begin
					config_ram_addr <= config_ram_addr_buf;
				end
			always @ ( posedge clk_input )
				begin
					if (data_in_buf2[15:8] == 8'h7C )
						begin
							flag_7C <= 1 ;
						end
					else
						begin
							flag_7C <= 0 ;
						end
					if (data_in_buf2[7:0] == 8'hD2 )
						begin
							flag_D2 <= 1 ;
						end
					else
						begin
							flag_D2 <= 0 ;
						end
					if (data_in_buf1[15:8] == 8'h15 )
						begin
							flag_15 <= 1 ;
						end
					else
						begin
							flag_15 <= 0 ;
						end
					if (data_in_buf1[7:0] == 8'hD8 )
						begin
							flag_D8 <= 1 ;
						end
					else
						begin
							flag_D8 <= 0 ;
						end
					flag_head <= flag_7C && flag_D2 && flag_15 && flag_D8 ;
				end
			always @ ( posedge clk_input or posedge reset )
				 begin
					if ( reset )
						begin
							command_state   <= cd_idle ;
							config_ram_addr_buf <= 0       ;
							config_ram_en   <= 0       ;
							fifo_cmos_en    <= 0       ;
							FPGA_command    <= 0       ;
							command_buf     <= 0       ;
							FPGA_command_latch_flag <= 0 ;
						end
					else
						begin
							case ( command_state )
								power_up  :
									begin
										if ( intial_done )
											begin
												command_state   <= cd_idle ;
											end
										config_ram_addr_buf <= 0         ;
										config_ram_en   <= 0             ;
										fifo_cmos_en    <= 0             ;
										FPGA_command    <= 0             ;
										FPGA_command_latch_flag <= 0     ;
									end
								cd_idle   :
									begin
										if ( flag_head )
											begin
												command_state   <= cd_judge     ;
												command_buf     <= data_in_buf2 ;
											end
										config_ram_addr_buf <= 0       ;
										config_ram_en   <= 0       ;
										fifo_cmos_en    <= 0       ;
										FPGA_command    <= 0       ;
										FPGA_command_latch_flag <= 0 ;
									end
								cd_config   :
									begin
										if ( receive_en_delay == 0 )
											begin
												config_ram_en   <= 0 ;
												config_ram_addr_buf <= 0 ;
												command_state   <= cd_idle ;
											end
										else
											begin
												config_ram_en        <= 1 ;
												//config_ram_addr_buf[8]   <= 1 ;
												config_ram_addr_buf[7:0] <= config_ram_addr_buf[7:0] + 1 ;
											end
									end
								cd_cmos :
									begin
										if ( receive_en_delay == 0 )
											begin
												fifo_cmos_en   <= 0 ;
												command_state  <= cd_idle ;
											end
										else
											begin
												fifo_cmos_en   <= 1 ;
											end
									end
								cd_judge  :
									begin
										if ( command_buf[15:8] == 8'hAA )
											begin
												command_state <= cd_config ;
												config_ram_addr_buf[8]   <= 1 ;
											end
										else
											if ( command_buf[15:8] == 8'hBB )
												begin
													command_state <= cd_config ;
													config_ram_addr_buf[8]   <= 0 ;
												end
											else
												if ( command_buf[15:8] == 8'h55 )
													begin
														command_state <= cd_cmos ;
													end
												else
													if ( command_buf[15:8] == 8'hFF )
														begin
															FPGA_command <= command_buf[7:0] ;
															command_buf  <= 0                ;
															FPGA_command_latch_flag <= 1     ;
														end
													else
														if ( receive_en_delay == 0  )
															begin
																FPGA_command_latch_flag <= 0 ;
																command_state  <= cd_idle ;
															end
									end
								default   :
									begin
										command_state   <= power_up;
										config_ram_addr_buf <= 0       ;
										config_ram_en   <= 0       ;
										fifo_cmos_en    <= 0       ;
										FPGA_command    <= 0       ;
										FPGA_command_latch_flag <= 0 ;
									end
							endcase
						end
					
				 end
			

endmodule
