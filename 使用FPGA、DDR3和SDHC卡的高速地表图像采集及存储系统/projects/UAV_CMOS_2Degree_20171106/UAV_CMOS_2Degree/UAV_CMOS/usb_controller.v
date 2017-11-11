`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:40:21 05/31/2017 
// Design Name: 
// Module Name:    usb_controller 
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
`define USB_command {USB_SLOE,USB_SLWR_Buf,USB_SLRD}
`define EP6_Addr 2'b10
`define EP2_Addr 2'b00
module usb_controller(
								usb_clk,
								USB_FlagA,USB_FlagB,USB_FlagC,USB_FlagD,
								USB_DATA,USB_FIFO_ADR,PKTEND,USB_SLWR,USB_SLRD,USB_SLOE,
								nframe,send_out,
								parameter_data,fifo_parameter_en,
								receive_data,receive_data_en,
								image_data,fifo_image_en,parameter_fifo_empty,usb_image_addr,select_flag,ram_full								
							);
			input  usb_clk ;
			input  USB_FlagA,USB_FlagB,USB_FlagC,USB_FlagD;
			input  parameter_fifo_empty;
			inout  [15:0]USB_DATA;
			output USB_FIFO_ADR ;
			output PKTEND;
			output USB_SLWR,USB_SLRD,USB_SLOE;
			
			input  [63:0]image_data    ;
			output fifo_image_en       ;
			//reg    fifo_image_en       ;
			wire   fifo_image_en       ;
			reg    USB_SLWR_Buf        ;
			reg    USB_SLWR_Buf1        ;
/////////////////////////////////////////////////////////////////			
			input   [15:0]parameter_data;
			output  fifo_parameter_en   ;
			reg     fifo_parameter_en   ;
/////////////////////////////////////////////////////////////////
			output [15:0]receive_data  ;
			reg    [15:0]receive_data  ;
			output receive_data_en     ;
			reg    receive_data_en     ;
			reg    receive_data_en_buf ;
			output [7:0]usb_image_addr ;
			reg    [7:0]usb_image_addr ;
			output select_flag         ;
			reg    select_flag         ;
			input  ram_full            ;
			
			input  nframe    ;
			input send_out   ;
			
			reg [1:0]USB_FIFO_ADR;
			reg [1:0]USB_FIFO_ADR_buf;
			reg [15:0]USB_Data_out_buf1;
			reg [15:0]USB_Data_out_buf ;
			reg [15:0]USB_Data_in_buf ;
			reg PKTEND  = 1      ;
			reg USB_SLWR,USB_SLRD,USB_SLOE;
			
			reg [15:0]data_buf   ;
			reg [9:0]counter     ;
			reg flag_counter     ;
			reg direction_flag =1  ;
			reg USB_FlagA_EP6_EF ;
			reg USB_FlagB_EP6_PF ;
			reg USB_FlagC_EP2_EF ;
			reg USB_FlagD_EP2_FF ;
			reg fifo_parameter_en_flag;
			reg fifo_image_en_flag    ;
			reg fifo_image_en_buf     ;
			reg frame_flag            ;
			
			reg [5:0]main_state    = 0  ;
			reg [5:0]next_state    = 0  ;
			reg [5:0]previous_state= 0  ;
			reg [5:0]current_state = 0  ;
			reg parameter_fifo_empty_buf;
			
			parameter 
				power_up              = 6'b000000 ,
				usb_EP6               = 6'b000001 ,
				usb_send_sc           = 6'b000010 ,
				usb_send_paramter     = 6'b000100 ,
				usb_send_image_data   = 6'b001000 ,
				usb_EP2  			    = 6'b010000 ,
				usb_receive_data      = 6'b100000 ,
				usb_addr_delay        = 6'b100001 ,
				usb_addr_delay1       = 6'b100010 ;
			parameter 
				usb_write = 3'b101 ,
				usb_read  = 3'b010 ,
				usb_enable= 3'b011 ,
				usb_nop   = 3'b111 ;
//////////////////////////////////////////////////
			assign USB_DATA = direction_flag ? 16'bZZZZZZZZZZZZZZZZ : USB_Data_out_buf  ;
////////////////////////////////////////////////////
			always @ ( posedge usb_clk )
				begin
					parameter_fifo_empty_buf <= parameter_fifo_empty ;
				end
			always @ ( posedge usb_clk or posedge nframe )
				begin
					if ( nframe == 1 )
						begin
							frame_flag <= 1 ;
						end
					else
						if ( next_state == usb_send_sc )
							begin
								frame_flag <= 0 ;
							end
				end
//////////////////////////////////////////////////
			reg fifo_image_en_wire ;
			assign fifo_image_en = fifo_image_en_wire && main_state[3] ;
			reg [63:0]image_data_buf ;
			reg [1:0]counter_4 ;
			always @ ( posedge usb_clk )
				begin
					if ( fifo_image_en_buf )
						counter_4 <= counter_4 + 1 ;
					else
						counter_4 <= 3 ;
						
					if ( counter_4 == 3 )
						fifo_image_en_wire <= fifo_image_en_buf ;
					else
						fifo_image_en_wire <= 0 ;
						
					if ( fifo_image_en )
						image_data_buf <= image_data ;
					else
						image_data_buf[47:0] <= image_data_buf[63:16] ;						
				end
			always @ ( posedge usb_clk )
				begin
					USB_FlagA_EP6_EF       <= USB_FlagA;
					USB_FlagB_EP6_PF       <= USB_FlagB;
					USB_FlagC_EP2_EF       <= USB_FlagC;
					USB_FlagD_EP2_FF       <= USB_FlagD;
					USB_Data_in_buf[15:8]  <= USB_DATA[7:0] ;
					USB_Data_in_buf[7:0]  <= USB_DATA[15:8] ;
					USB_Data_out_buf[15:8] <= USB_Data_out_buf1[7:0] ;
					USB_Data_out_buf[7:0] <= USB_Data_out_buf1[15:8] ;
					receive_data_en  <= receive_data_en_buf ;
					USB_SLWR_Buf1    <= USB_SLWR_Buf  ;
					USB_SLWR         <= USB_SLWR_Buf1 ;
				end
			always @ ( posedge usb_clk )
				begin
						if ( flag_counter )
							begin
								counter <= counter + 1 ;
							end
						else
							begin
								counter <= 0 ;
							end
				end
			
			always @ ( posedge usb_clk )
						begin
							case ( main_state )
								power_up :
									begin
										//next_state              <= usb_send_image_data ;
										fifo_parameter_en_flag  <= 0 ;
										fifo_parameter_en       <= 0 ;
										receive_data_en_buf     <= 0 ;      
										fifo_image_en_flag      <= 0 ;
										fifo_image_en_buf       <= 0 ;
										flag_counter            <= 0 ;
										if ( USB_FlagC_EP2_EF == 0 )
											begin
												main_state   <= usb_EP2             ;
												`USB_command <= usb_nop             ;
											end
										else
											begin
												`USB_command     <= usb_read        ;
											end
									end
								usb_EP2 : 
									begin
										current_state <= usb_EP6                   ;
										previous_state<= usb_EP2                   ;
										if ( USB_FlagC_EP2_EF != 0 )
											begin
												main_state     <= usb_addr_delay     ;
												USB_FIFO_ADR   <= `EP2_Addr          ;
												`USB_command   <= usb_nop            ;
												direction_flag <= 1                  ;
											end
										else
											begin
												main_state     <= usb_EP6            ;
												`USB_command   <= usb_nop            ;
											end
										if ( frame_flag )
											begin
												next_state <= usb_send_sc            ;
											end
//										else/////////////////////21071106
//											begin
//												next_state    <= usb_send_image_data ;
//											end//////
									end
								usb_EP6   :
									begin
										current_state <= usb_EP2                    ;
										previous_state<= usb_EP6                    ;
										fifo_parameter_en <= 0                ;
										fifo_image_en_buf <= 0                ;
										if ( frame_flag )
											begin
												next_state        <= usb_send_sc      ;
												direction_flag    <= 0                ;
												USB_FIFO_ADR      <= `EP6_Addr        ;
												select_flag       <= 1                ;
											end
//										else/////////////////////21071106
//											begin
//												next_state    <= usb_send_image_data ;
//											end
											if ( (USB_FlagA_EP6_EF == 0)&&(ram_full ) )
												begin
													main_state        <= usb_addr_delay   ;
													direction_flag    <= 0                ;
													USB_FIFO_ADR      <= `EP6_Addr        ;
													if ( next_state == usb_send_sc  )
													fifo_image_en_flag<= 0     ;
													else
													fifo_image_en_flag<= 1     ;	
												end
											else
												begin
													main_state     <= usb_EP2          ;
													fifo_image_en_flag<= 0     ;
												end
									end
								usb_send_sc :
									begin
										if ( counter== 255 )
											begin
												main_state   <= current_state     ;
												next_state   <= usb_send_paramter ;
												`USB_command <= usb_nop           ;
												flag_counter <= 0                 ;
												fifo_parameter_en_flag <= 1       ;
											end
										else
											begin
												`USB_command <= usb_write  ;
												flag_counter      <= 1          ;
											end
										case ( counter[0] )
											1'b0 :
												begin
													USB_Data_out_buf1 <= 16'h7CD2 ;
												end
											1'b1 :
												begin
													USB_Data_out_buf1 <= 16'h15D8 ;
												end
											default :
												begin
													USB_Data_out_buf1 <= 16'h0000 ;
												end
										endcase
									end
								usb_send_paramter  :
									begin
										if ( counter== 255 )
											begin
												main_state   <= current_state       ;
												next_state   <= usb_send_image_data ;
												`USB_command <= usb_nop             ;
												flag_counter <= 0                   ;
												fifo_parameter_en_flag <= 0         ;
												fifo_parameter_en      <= 0         ;
												fifo_image_en_flag     <= 1         ;
											end
										else
											begin
												`USB_command      <= usb_write       ;
												flag_counter      <= 1               ;
												if ( parameter_fifo_empty_buf == 0 )
													begin
														USB_Data_out_buf1 <= parameter_data  ;
													end
												else
													begin
														fifo_parameter_en_flag <= 0         ;
														fifo_parameter_en      <= 0         ;
														USB_Data_out_buf1 <= 16'hFFFF       ;
													end
												end
									end
								usb_send_image_data  :
									begin
										USB_Data_out_buf1[7:0]  <= image_data_buf[15:8] ;
										USB_Data_out_buf1[15:8] <= image_data_buf[7:0]  ;
										if ( counter== 255 )
											begin
												main_state         <= current_state       ;
												next_state         <= usb_send_image_data ;
												`USB_command       <= usb_nop             ;
												flag_counter       <= 0                   ;
												fifo_image_en_buf  <= 0                   ;
												fifo_image_en_flag <= 0                   ;
												select_flag        <= ~select_flag        ;
											end
										else
											begin
												`USB_command      <= usb_write            ;
												flag_counter      <= 1                    ;
												usb_image_addr    <= counter              ;
												if ( counter== 253 )
													begin
														fifo_image_en_buf  <= 0                   ;
														fifo_image_en_flag <= 0                   ;
													end
											end
									end
								usb_receive_data :
									begin
										receive_data     <= USB_Data_in_buf    ;
										if ( USB_FlagC_EP2_EF == 0 )
											begin
												main_state       <= current_state  ;
												`USB_command     <= usb_nop        ;
												receive_data_en_buf <= 0              ;
											end
										else
											begin
												`USB_command     <= usb_read           ;
												receive_data_en_buf <= 1                  ;
											end
									end
								usb_addr_delay :
									begin
										main_state        <= usb_addr_delay1 ;
										fifo_image_en_buf <= fifo_image_en_flag ;
									end
								usb_addr_delay1 :
									begin
										if ( previous_state == usb_EP2 )
											begin
												main_state   <= usb_receive_data ;
												`USB_command <= usb_enable       ;
											end
										else
											if ( previous_state == usb_EP6 )
												begin
													direction_flag    <= 0                              ;
													main_state        <= next_state                     ;
													fifo_parameter_en <= fifo_parameter_en_flag         ;
												end
									end
								default  :
									begin
										flag_counter            <= 0        ;
										`USB_command            <= usb_nop  ;
										main_state              <= power_up ;
										receive_data            <= 0        ;
										fifo_parameter_en_flag  <= 0        ;
										receive_data_en_buf     <= 0        ;      
										fifo_image_en_flag      <= 0        ;
										fifo_image_en_buf       <= 0        ;
									end
							endcase
						end

endmodule
