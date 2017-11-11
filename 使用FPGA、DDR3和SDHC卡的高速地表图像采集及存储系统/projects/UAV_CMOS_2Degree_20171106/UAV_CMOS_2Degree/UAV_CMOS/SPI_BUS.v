`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:06:38 09/05/2017 
// Design Name: 
// Module Name:    SPI_BUS 
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
module SPI_BUS(
					clk_input,
					SCLK,SS_N,MOSI,MISO,
					data_write,data_read,
					command_address,
					command_read,read_latch,
					reset,spi_idle_fd,
					execute_pulse
				  );
			input  clk_input           ;
			input  [15:0]data_write    ;
			input  [9:0]command_address;
			output [15:0]data_read     ;
			output [9:0]command_read   ;
			output SCLK,SS_N,MOSI      ;
			output spi_idle_fd         ;
			output read_latch          ;
			input  MISO                ;
			input  reset               ;
			input  execute_pulse       ;
			
			parameter 
				SPI_bus_busy    = 4'b0001 ,
				SPI_bus_start   = 4'b0010 ,
				SPI_bus_stop    = 4'b0100 ,
				SPI_bus_idle    = 4'b1000 ;
			parameter
				SPI_idle        = 6'b000000,
				SPI_waite 		 = 6'b000010,
				SPI_address		 = 6'b000100, 
				SPI_data_write	 = 6'b001000,
				SPI_data_read	 = 6'b010000,
				SPI_stop     	 = 6'b100000,
				SPI_read_wait   = 6'b000001;
				
			reg [3:0]SPI_bus_state  ;
			reg [5:0]SPI_state      ;
			reg [5:0]next_SPI_state ;
			reg [4:0]SPI_bus_counter;
			reg read_latch          ;
			reg read_latch_buf      ;
			reg sclk_buf            ;
			reg SCLK                ;
			reg SS_N                ;
			reg MOSI                ;
			reg [15:0]data_read     ;
			reg [9:0]command_read   ;
			reg [15:0]data_read_buf ;
			reg [15:0]data_write_buf;
			reg [9:0]command_address_buf;
			reg execute_pulse_buf   ;
			reg [15:0]data_write_shift;
			reg [15:0]data_read_shift ;
			reg [9:0]command_address_shift;
			reg MISO_buf ;
			reg spi_read_flag       ;
			reg spi_read_flag_buf1  ;
			reg spi_read_flag_buf2  ;
			reg spi_idle_fd         ;
			reg spi_idle_fd_flag    ;
			reg spi_idle_fd_flag_buf1;
			reg spi_idle_fd_flag_buf2;
			always @ ( posedge clk_input or posedge reset )
				begin
					if ( reset )
						begin
							read_latch_buf     <= 0 ;
							read_latch         <= 0 ;
							spi_read_flag      <= 0 ;
							spi_read_flag_buf1 <= 0 ;
							spi_read_flag_buf2 <= 0 ;
						end
					else
						begin
							if ( SPI_state == SPI_data_read )
								begin
									spi_read_flag <= 1 ;
								end
							else
								begin
									spi_read_flag <= 0 ;
								end
							spi_read_flag_buf1 <= spi_read_flag ;
							spi_read_flag_buf2 <= spi_read_flag_buf1 ;
							read_latch_buf     <= ( spi_read_flag_buf2 ) && ( ~spi_read_flag_buf1 ) ;
							read_latch         <= read_latch_buf ;
						end
				end
			always @ ( posedge clk_input or posedge reset )
				begin
					if ( reset == 1 )
						begin
							spi_idle_fd <= 1           ;
							spi_idle_fd_flag <= 1      ;
							spi_idle_fd_flag_buf1 <= 1 ;
							spi_idle_fd_flag_buf2 <= 1 ;
						end
					else
						begin
							if ( SPI_state == SPI_idle )
								begin
									spi_idle_fd_flag <= 1 ;
								end
							else
								begin
									spi_idle_fd_flag <= 0 ;
								end
							spi_idle_fd_flag_buf1 <= spi_idle_fd_flag      ;
							spi_idle_fd_flag_buf2 <= spi_idle_fd_flag_buf1 ;
							spi_idle_fd           <= ( ~spi_idle_fd_flag_buf2 ) && ( spi_idle_fd_flag_buf1 ) ;
						end
				end
			always @ ( posedge clk_input or posedge reset )
				begin
					if ( reset )
						begin
							MISO_buf <= 0 ;
						end
					else
						begin
							MISO_buf <= MISO ;
						end
				end
			always @ ( posedge clk_input or posedge reset )
				begin
					if ( reset )
						begin
							data_write_buf      <= 0 ;
							command_address_buf <= 0 ;
							execute_pulse_buf   <= 0 ;
						end
					else
						begin
							data_write_buf      <= data_write      ;
							command_address_buf <= command_address ;
							execute_pulse_buf   <= execute_pulse   ;
						end
				end
			always @ ( posedge clk_input or posedge reset )
				begin
					if ( reset )
						begin
							SPI_bus_counter <= 0 ;
						end
					else
						if ( SPI_bus_state == SPI_bus_idle )
							begin
								SPI_bus_counter <= 0 ;
							end
						else
							if ( SPI_bus_counter == 31 )
								begin
									SPI_bus_counter <= SPI_bus_counter ;
								end
							else
								begin
									SPI_bus_counter <=SPI_bus_counter + sclk_buf ;
								end
				end
			always @ ( posedge clk_input or posedge reset )
				begin
					if ( reset )
						begin
							sclk_buf       <= 0           ;
						end
					else
						if ( SPI_bus_state != SPI_bus_idle )
							begin
								sclk_buf <= ~sclk_buf;
							end
						else
							begin
								sclk_buf <= 0 ;
							end
				end
			
			always @ ( posedge clk_input or posedge reset )
				begin
					if ( reset )
						begin
							SCLK           <= 0           ;
							SS_N           <= 1           ;
							SPI_bus_state  <= SPI_bus_idle;
						end
					else
						begin
							case ( SPI_bus_state )
								SPI_bus_idle :
									begin
										SCLK           <= 0           ;
										SS_N           <= 1           ;
										if ( execute_pulse_buf )
											SPI_bus_state <= SPI_bus_start ;
									end
								SPI_bus_start:
									begin
										if ( SPI_bus_counter == 1 )
											begin
												SS_N     <= 0    ;
											end
										else
											if ( SPI_bus_counter == 2 )
												begin
													SPI_bus_state <= SPI_bus_busy ;
												end
									end
								SPI_bus_busy :
									begin
										if ( SPI_bus_counter == 28 )
											begin
												SCLK <= 0 ;	
												SPI_bus_state <= SPI_bus_stop;												
											end
										else
											begin
												SCLK          <= sclk_buf ;
											end
									end
								SPI_bus_stop :
									begin
										if ( SPI_bus_counter == 30 )
											begin
												SS_N           <= 1           ;
											end
										else
											if ( SPI_bus_counter == 31 )
												begin
													SPI_bus_state <= SPI_bus_idle;
												end
									end
								default :
									begin
										SPI_bus_state <= SPI_bus_idle;
										SS_N          <= 1           ;
										SCLK          <= 0           ;
									end
							endcase
						end
				end
			always @ ( posedge clk_input or posedge reset )
				begin
					if ( reset )
						begin
							SPI_state             <= SPI_idle ;
							next_SPI_state        <= SPI_idle ;
							MOSI                  <= 0        ;
							data_read             <= 0        ;
							data_write_shift 	    <= 0        ;
							command_address_shift <= 0        ;
							data_read_shift       <= 0        ;
							command_read          <= 0        ;
						end
					else
						begin
							case ( SPI_state )
								SPI_idle  :
									begin
										if ( execute_pulse_buf )
											begin
												SPI_state <= SPI_waite ;
											end
										data_write_shift      <= data_write_buf      ;
										command_read          <= command_address_buf ;
										command_address_shift <= command_address_buf ;
									end
								SPI_waite :
									begin
										if ( command_address_shift[0] )
											begin
												next_SPI_state <= SPI_data_write ;
											end
										else
											begin
												next_SPI_state <= SPI_read_wait ;
											end
										if ( SPI_bus_counter == 1 )
											begin
												SPI_state  <= SPI_address ;
											end
									end
								SPI_address :
									begin
										if ( SPI_bus_counter == 11 )
											begin
												SPI_state <= next_SPI_state ;
											end
										if ( sclk_buf == 0 )
											begin
												MOSI <= command_address_shift[9] ;
												command_address_shift[9:0] <= {command_address_shift[8:0],1'b0}; 
											end
									end
								SPI_data_write:
									begin
										if ( SPI_bus_counter == 27 )
											begin
												SPI_state <= SPI_stop ;
											end
										if ( sclk_buf == 0 )
											begin
												MOSI <= data_write_shift[15] ;
												data_write_shift[15:0] <= {data_write_shift[14:0],1'b0}; 
											end
									end
								SPI_read_wait :
									begin
										if ( SPI_bus_counter == 13 )
											begin
												SPI_state <= SPI_data_read ;
											end
									end
								SPI_data_read :
									begin
										if ( SPI_bus_counter == 29 )
											begin
												SPI_state <= SPI_stop ;
											end
										if ( sclk_buf == 0 )
											begin
												data_read_shift[0] <= MISO_buf;
												data_read_shift[15:1] <= data_read_shift[14:0]; 
											end
									end
								SPI_stop      :
									begin
										//data_read_buf <= data_read_shift ;
										if ( sclk_buf == 0 )
											begin
												MOSI <= 0 ;
												data_read_buf <= data_read_shift ;
												
											end	
										if ( SPI_bus_counter == 31 )
											begin
												SPI_state <= SPI_idle ;
												data_read <= data_read_buf ;
											end
									end
								default :
									begin
										SPI_state             <= SPI_idle ;
										next_SPI_state        <= SPI_idle ;
										MOSI                  <= 0        ;
										data_read             <= 0        ;
										data_write_shift 	  <= 0        ;
										command_address_shift <= 0        ;
										data_read_shift       <= 0        ;
									end
							endcase
						end
				end

endmodule
