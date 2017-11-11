`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:29:44 09/19/2017 
// Design Name: 
// Module Name:    coms_controller 
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
`define Part1_offset            0
`define Part1_counter           8
`define Part2_offset            8
`define Part2_counter           3
`define required_upload_offset  128
`define required_upload_counter 108
`define soft_power_up_offset    11
`define soft_power_up_counter   8
`define parameter_fd_offset     19
`define parameter_fd_counter    6
module coms_controller(
								clk,reset,read_latch,spi_idle_feedback,
								spi_command,spi_data,spi_execute,
								spi_fd_command,spi_fd_data,fd_data,fd_fifo_en,
								initial_spi_data,initial_ram_addr,initial_read_en,initial_done,
								usb_spi_data,usb_read_en,command_fifo_empty,usb_command_latch,
								parameter_request,cmos_initial_done
							);
		input clk, reset,spi_idle_feedback;
///////////////////////////////////////////
		input  [15:0]initial_spi_data ;
		input  initial_done           ;
		output [8:0]initial_ram_addr  ;
		output initial_read_en        ;
		reg    [8:0]initial_ram_addr  ;
		reg    initial_read_en        ;
///////////////////////////////////////////
		input  [15:0]usb_spi_data     ;
		input  command_fifo_empty     ;
		input  usb_command_latch      ;
		output usb_read_en            ;
		reg    usb_read_en            ;
		output cmos_initial_done      ;
///////////////////////////////////////////		
		output [9:0]spi_command ;
		output [15:0]spi_data   ;
		output spi_execute      ;
		reg    [9:0]spi_command ;
		reg    [15:0]spi_data   ;
//////////////////////////////////////////
		input  read_latch         ;
		input  [9:0]spi_fd_command;
		input  [15:0]spi_fd_data  ;
		input  parameter_request  ;
		output fd_fifo_en         ;
		output [15:0]fd_data      ;
		reg    fd_fifo_en         ;
		reg    [15:0]fd_data      ;
//////////////////////////////////////////
		reg    [9:0]main_state  ;
		reg    [9:0]next_state  ;
		reg    [9:0]previouse_state ;
		reg    [8:0]config_data_counter ;
		reg    parameter_finish_flag    ;
		reg    cmos_initial_done        ;
		parameter 
			power_up             = 10'b0000000000 ,
			low_power_standby    = 10'b0000000001 ,
			judge_pll_status     = 10'b0000000010 ,
			standby1             = 10'b0000000100 ,
			intermediate_standby = 10'b0000001000 ,
			standby2             = 10'b0000010000 ,
			idle                 = 10'b0000100000 ,
			wait_idle            = 10'b0001000000 ,
			running              = 10'b0010000000 ,
			parameter_read       = 10'b0100000000 ,
			usb_command          = 10'b1000000000 ;
/////////////////////////////////////////////////////
		reg  [9:0]spi_fd_command_buf;
		reg  [15:0]spi_fd_data_buf  ;
		reg  pll_enable_flag        ;
		reg  fd_fifo_flag1          ;
		reg  fd_fifo_flag2          ;
		always @ ( posedge clk or posedge reset )
			begin
				if ( reset )
					begin
						spi_fd_command_buf <= 0 ;
						spi_fd_data_buf    <= 0 ;
						fd_fifo_flag1      <= 0 ;
						fd_fifo_flag2      <= 0 ;
						fd_data            <= 0 ;
						pll_enable_flag    <= 0 ;
					end
				else
					if ( read_latch )
						begin
							if ( previouse_state  == judge_pll_status )
								begin
									pll_enable_flag    <= spi_fd_data[0];
									fd_fifo_flag1      <= 0 ;
									fd_fifo_flag2      <= 0 ;
								end
							else
								begin
									pll_enable_flag    <= 0 ;
									fd_fifo_flag1      <= 1 ;
									fd_fifo_flag2      <= 1 ;
								end
							spi_fd_command_buf <= spi_fd_command ;
							spi_fd_data_buf    <= spi_fd_data    ;
						end
					else
						if ( fd_fifo_flag1 )
							begin
								fd_fifo_flag1 <= 0                  ;
								fd_data[9:0]  <= spi_fd_command_buf ;
								fd_data[15:10]<= 0                  ;
								fd_fifo_en    <= 1                  ;
							end
						else
							if ( fd_fifo_flag2 )
								begin
									fd_fifo_flag2 <= 0                  ;
									fd_data[15:0] <= spi_fd_data_buf    ;
									fd_fifo_en    <= 1                  ;
								end
							else
								begin
									spi_fd_command_buf <= 0 ;
									spi_fd_data_buf    <= 0 ;
									fd_fifo_flag1      <= 0 ;
									fd_fifo_flag2      <= 0 ;
									fd_data            <= 0 ;	
									fd_fifo_en         <= 0 ; 
								end
			end
//////////////////////////////////////////////
		reg    flag_en_falling_buf1;
		reg    flag_en_falling_buf2;
		reg    flag_en_falling     ;
		reg    [1:0]flag_en        ;
		always @ ( posedge clk or posedge reset )
			begin
				if ( reset == 1 )
					begin
						flag_en_falling_buf1 <= 0 ;
						flag_en_falling_buf2 <= 0 ;
						flag_en_falling      <= 0 ;
					end
				else
					begin
						flag_en_falling_buf1 <= read_config_data_flag ;
						flag_en_falling_buf2 <= flag_en_falling_buf1;
						flag_en_falling      <= ( ~flag_en_falling_buf2 ) && ( flag_en_falling_buf1 ) ;
					end
			end
/////////////////////////////////////////////////////////////////////////////////
		parameter 
			config_power_up      = 4'b0000 ,
			config_data_idle     = 4'b0001 ,
			config_data_read     = 4'b0010 ,
			config_judge         = 4'b0100 ,
			config_usb_command   = 4'b1000 ;
		reg    [3:0]config_data_state       ;
		reg    read_config_data_flag        ;
		reg    flag_up_load_register        ;
		reg    [8:0]initial_ram_addr_offset ;
		reg    flag_counter2                ;
		reg    spi_execute                  ;
		reg    spi_execute_flag             ;
		reg    spi_execute_buf1             ;
		reg    spi_execute_buf2             ;
		always @ ( posedge clk or posedge reset )
			begin
				if ( reset )
					begin
						spi_execute_flag <= 0 ;
						spi_execute      <= 0 ;
						spi_execute_buf1 <= 0 ;
						spi_execute_buf2 <= 0 ;
					end
				else
					begin
						if ( config_data_state == config_data_idle )
							begin
								spi_execute_flag <= 0 ;
							end
						else
							if ( config_data_state == config_power_up )
								begin
									spi_execute_flag <= 0 ;
								end
							else
								begin
									spi_execute_flag <= 1 ;
								end
						spi_execute_buf1 <= spi_execute_flag ;
						spi_execute_buf2 <= spi_execute_buf1 ;
						spi_execute      <= ( spi_execute_buf2 ) && ( ~spi_execute_buf1 ) ;
					end
			end
			
		reg delayed_usb_read_en     ;
		reg delayed_initial_read_en ;
		always @ ( posedge clk or posedge reset )
			begin
				if ( reset )
					begin
						delayed_usb_read_en     <= 0 ;
						delayed_initial_read_en <= 0 ;
					end
				else
					begin
						delayed_usb_read_en     <= usb_read_en     ;
						delayed_initial_read_en <= initial_read_en ;
					end
			end
		reg [15:0]usb_spi_data_buf1 ;
		reg [15:0]usb_spi_data_buf2 ;
		reg [15:0]initial_spi_data_buf1;
		reg [15:0]initial_spi_data_buf2;
		always @ ( posedge clk or posedge reset )
			begin
				if ( reset )
					begin
						spi_command <= 0 ;
						spi_data    <= 0 ;
					end
				else
					if ( previouse_state == judge_pll_status )
						begin
							spi_command <= 48 ;
							spi_data    <= 0  ;
						end
					else
						if ( previouse_state == idle )
							begin
								spi_command <= 385        ;
								spi_data    <= 16'h183D   ;
							end
						else
							if ( previouse_state == usb_command )
								begin
									if ( delayed_usb_read_en )
										begin
											usb_spi_data_buf1     <= usb_spi_data          ;
											usb_spi_data_buf2     <= usb_spi_data_buf1     ;
										end
									else
										begin
											spi_command <= usb_spi_data_buf2[9:0] ;
											spi_data    <= usb_spi_data_buf1 ;
										end
								end
							else
								if ( delayed_initial_read_en )
									begin
										initial_spi_data_buf1 <= initial_spi_data      ;
										initial_spi_data_buf2 <= initial_spi_data_buf1 ;
									end
								else
									begin
										spi_command <= initial_spi_data_buf2[9:0]      ;
										spi_data    <= initial_spi_data_buf1           ;
									end
			end
		always @ ( posedge clk or posedge reset )
			begin
				if ( reset == 1 )
					begin
						config_data_state <= config_data_idle ;
						initial_ram_addr  <= 0                ;
						initial_read_en   <= 0                ;
						flag_counter2     <= 0                ;
						usb_read_en       <= 0                ;
					end
				else
					begin
						case ( config_data_state )
							config_power_up     :
								begin
									initial_ram_addr  <= 0                ;
									initial_read_en   <= 0                ;
									flag_counter2     <= 0                ;
								end
							config_data_idle    :
								begin
									usb_read_en            <= 0                                                  ;
									flag_counter2          <= 0                                                  ;
									initial_ram_addr[8:1]  <= config_data_counter[7:0] +  initial_ram_addr_offset - 1 ;
									initial_ram_addr[0]    <= 0                                                  ;
									initial_read_en        <= 0                                                  ;
									if ( flag_en_falling )
										begin
											config_data_state <= config_judge ;
										end
								end
							config_judge        :
								begin
									if ( previouse_state == judge_pll_status )
										begin
											config_data_state <= config_data_idle ;
										end
									else
										if (  previouse_state == idle )
											begin
												config_data_state <= config_data_idle ;
											end
										else
											if ( previouse_state == usb_command )
												begin
													flag_counter2     <= 0                ;
													config_data_state <= config_usb_command  ;
													usb_read_en       <= 1                ;
												end
											else
												begin
													flag_counter2     <= 0                ;
													config_data_state <= config_data_read ;
													initial_read_en   <= 1                ;
												end
								end
							config_usb_command  :
								begin
									if ( flag_counter2 == 1 )
										begin
											config_data_state <= config_data_idle          ;
											flag_counter2     <= 0                         ;
											usb_read_en       <= 0                         ;
										end
									else
										begin
											flag_counter2     <= 1                         ;
										end
								end
							config_data_read         :
								begin
									if ( flag_counter2 == 1 )
										begin
											config_data_state     <= config_data_idle          ;
											flag_counter2         <= 0                         ;
											initial_read_en       <= 0                         ;
										end
									else
										begin
											flag_counter2       <= 1                           ;
											initial_ram_addr[0] <= 1                           ;
										end
								end
							default             :
								begin
									initial_ram_addr  <= 0                ;
									initial_read_en   <= 0                ;
									flag_counter2     <= 0                ;
									config_data_state <= config_power_up  ;
								end
						endcase
					end
			end
/////////////////////////////////////////////////////////////////////////////////
		always @ ( posedge clk or posedge reset )
			begin
				if ( reset == 1 )
					begin
						main_state              <= power_up ;
						previouse_state         <= power_up ;
						next_state              <= power_up ;
						read_config_data_flag   <= 0        ;
						initial_ram_addr_offset <= 0        ; 
						config_data_counter     <= 0        ;
						parameter_finish_flag   <= 0        ;
						cmos_initial_done       <= 0        ; 
					end
				else
					begin
						case ( main_state )
							power_up             :
								begin
									if ( initial_done )
										begin
											main_state              <= low_power_standby ;
											cmos_initial_done       <= 0                 ; 
										end
									read_config_data_flag   <= 0 ;
									config_data_counter     <= 0 ;
									previouse_state         <= power_up ;
									next_state              <= power_up ;
									parameter_finish_flag   <= 0        ;
								end
							wait_idle            :
								begin
									read_config_data_flag <= 1 ; 
									if (  spi_idle_feedback )
										begin
											main_state  <= next_state  ;
										end
									else
										begin
											main_state  <= wait_idle  ;
										end
								end
							low_power_standby    :
								begin
									if ( config_data_counter == `Part1_counter )
										begin
											next_state          <= judge_pll_status ;
											config_data_counter <= 0                ;
											main_state          <= judge_pll_status ;
										end
									else
										begin
											config_data_counter <= config_data_counter + 1 ;
											next_state          <= low_power_standby       ;
											main_state          <= wait_idle               ;
										end
									read_config_data_flag   <= 0                 ;
									initial_ram_addr_offset <= `Part1_offset     ;
									previouse_state         <= low_power_standby ;
								end
							judge_pll_status             :
								begin
									previouse_state         <= judge_pll_status  ;
									read_config_data_flag   <= 0                 ;
									if ( pll_enable_flag )
										begin
											main_state       <= standby1         ;
										end
									else
										begin
											main_state      <= wait_idle         ;
											next_state      <= judge_pll_status  ;
										end
								end
							standby1             :
								begin
									previouse_state         <= standby1          ;
									read_config_data_flag   <= 0                ;
									main_state              <= wait_idle         ;
									initial_ram_addr_offset <= `Part2_offset     ;
									if ( config_data_counter == `Part2_counter )
										begin
											next_state          <= intermediate_standby ;
											config_data_counter <= 0                    ;
											main_state          <= intermediate_standby ;
										end
									else
										begin
											config_data_counter <= config_data_counter + 1 ;
											next_state          <= standby1                ;
											main_state          <= wait_idle               ;
										end
								end
							intermediate_standby :
								begin
									previouse_state         <= intermediate_standby     ;
									read_config_data_flag   <= 0                        ;
									initial_ram_addr_offset <= `required_upload_offset  ;
									if ( config_data_counter == `required_upload_counter )
										begin
											next_state          <= standby2          ;
											config_data_counter <= 0                 ;
											main_state          <= standby2          ;
										end
									else
										begin
											config_data_counter <= config_data_counter + 1 ;
											next_state          <= intermediate_standby    ;
											main_state          <= wait_idle               ;
										end
								end
							standby2             :
								begin
									previouse_state         <= standby2                 ;
									read_config_data_flag   <= 0                        ;
									main_state              <= wait_idle                ;
									initial_ram_addr_offset <= `soft_power_up_offset    ;
									if ( config_data_counter == `soft_power_up_counter )
										begin
											next_state          <= idle                 ;
											config_data_counter <= 0                    ;
											main_state          <= idle                 ;
										end
									else
										begin
											config_data_counter <= config_data_counter + 1 ;
											next_state          <= standby2                ;
											main_state          <= wait_idle               ;
										end
								end
							idle                 :
								begin
									previouse_state         <= idle                     ;
									read_config_data_flag   <= 0                        ;
									main_state              <= wait_idle                ;
									next_state              <= running                  ;
								end
							running              :
								begin
									cmos_initial_done       <= 1                        ; 
									read_config_data_flag   <= 0                        ;
									previouse_state         <= idle                     ;
									if ( parameter_request )
										begin
											main_state  <= parameter_read               ;
											parameter_finish_flag <= 0                  ;
										end
									else
										if ( usb_command_latch )
											begin
												main_state  <= usb_command              ;
											end
								end
							parameter_read       :
								begin
									previouse_state         <= parameter_read           ;
									read_config_data_flag   <= 0                        ;
									main_state              <= wait_idle                ;
									initial_ram_addr_offset <= `parameter_fd_offset     ;
									if ( config_data_counter == `parameter_fd_counter )
										begin
											next_state            <= running              ;
											config_data_counter   <= 0                    ;
											parameter_finish_flag <= 1                    ;
											main_state            <= running              ;
										end
									else
										begin
											config_data_counter <= config_data_counter + 1 ;
											next_state          <= parameter_read          ;
											main_state              <= wait_idle           ;
										end
								end
							usb_command          :
								begin
									previouse_state         <= usb_command              ;
									read_config_data_flag   <= 0                        ;
									if ( command_fifo_empty == 1 )
										begin
											main_state          <= running               ;
											next_state          <= running               ;
										end
									else
										begin
											next_state          <= usb_command          ;
											main_state          <= wait_idle            ;
										end
								end
							default              :
								begin
									main_state              <= power_up ;
									previouse_state         <= power_up ;
									next_state               <= power_up ;
									read_config_data_flag   <= 0        ;
									initial_ram_addr_offset <= 0        ; 
									config_data_counter     <= 0        ;
								end
						endcase
							
					end
			end
			
			

endmodule
