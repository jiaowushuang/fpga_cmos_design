`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:44:49 10/21/2017 
// Design Name: 
// Module Name:    image_ram_control 
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
module image_ram_control(
			clk_cmos,
			cmos_data_pulse,frame,training_pattern,image_data0,image_data1,image_data2,image_data3,image_data4,image_data5,image_data6,image_data7,
			image_data_ram,image_ram_addr,image_data_write_en1,image_data_write_en2,image_select_pulse
    );
		input clk_cmos            ;  
		input [9:0]image_data0,image_data1,image_data2,image_data3,image_data4,image_data5,image_data6,image_data7;
		input cmos_data_pulse     ;
		input frame               ;
		input training_pattern    ;
		
		output [15:0]image_data_ram;
		output [7:0]image_ram_addr ;
		output image_data_write_en1;
		output image_data_write_en2;
		output image_select_pulse  ;
		
		
		reg    [15:0]image_data_ram;
		reg    [7:0]image_ram_addr ;
		reg    [7:0]image_ram_addr_buf ;
		reg    image_data_write_en1;
		reg    image_data_write_en2;
		reg    image_select        ;
		reg    [2:0]addr_buf1      ;
		reg    [4:0]addr_buf2      ;
		reg    image_select_pulse  ;
		reg    [9:0]image_data0_buf,image_data1_buf,image_data2_buf,image_data3_buf,image_data4_buf,image_data5_buf,image_data6_buf,image_data7_buf;
		

		parameter 
			controller_idle  =  5'b00001 , 
			decode_addr_odd  =  5'b00010 ,
			decode_addr_even =  5'b00100 ,
			output_data      =  5'b01000 ,
			frame_reset      =  5'b00000 ;
		
		reg   [4:0]main_state      ;
		reg   [9:0]image_data_buf1 ;
		reg   [9:0]image_data_buf2 ;
		reg   [9:0]image_data_buf3 ;
		reg   [9:0]image_data_buf4 ;
		reg   image_data_write_en ;
		
		reg   image_select_buf1;
		reg   image_select_buf2;
		
		always @ ( posedge clk_cmos )
			begin
				if ( cmos_data_pulse )
					begin
						image_data0_buf <= image_data0 ;
						image_data1_buf <= image_data1 ;
						image_data2_buf <= image_data2 ;
						image_data3_buf <= image_data3 ;
						image_data4_buf <= image_data4 ;
						image_data5_buf <= image_data5 ;
						image_data6_buf <= image_data6 ;
						image_data7_buf <= image_data7 ;
					end
			end
		
		always @ ( posedge clk_cmos )
			begin
				image_select_buf1  <= image_select ;
				image_select_pulse <= ( image_select_buf1 ) ^ ( image_select ) ;
			end
		
		reg flag_odd_en ;
		reg flag_even_en;
		reg flag_odd_even;
		
		always @ ( posedge clk_cmos )
			begin
				image_data_write_en1 <= ( ~image_select ) && image_data_write_en;
				image_data_write_en2 <= (  image_select ) && image_data_write_en;
				image_ram_addr       <= image_ram_addr_buf ;
			end
		reg  addr_buf1_buf1 ;
		reg  addr_buf1_buf2 ;
		always @ ( posedge clk_cmos )
			begin
				addr_buf1_buf1 <= addr_buf1 ;
				addr_buf1_buf2 <= addr_buf1_buf1 ;
			end
		always @ ( posedge clk_cmos )
			begin
				case ( addr_buf1_buf2 )
					3'b000 :
						begin
							image_data_ram <= {6'b000000 ,image_data0_buf} ;
						end
					3'b001 :
						begin
							image_data_ram <= {6'b000000 ,image_data1_buf}  ;
						end
					3'b010 :
						begin
							image_data_ram <= {6'b000000 ,image_data2_buf}  ;
						end
					3'b011 :
						begin
							image_data_ram <= {6'b000000 ,image_data3_buf}  ;
						end
					3'b100 :
						begin
							image_data_ram <= {6'b000000 ,image_data4_buf}  ;
						end
					3'b101 :
						begin
							image_data_ram <= {6'b000000 ,image_data5_buf}  ;
						end
					3'b110 :
						begin
							image_data_ram <= {6'b000000 ,image_data6_buf}  ;
						end
					3'b111 :
						begin
							image_data_ram <= {6'b000000 ,image_data7_buf}  ;
						end
					default :
						begin
							image_data_ram <= 0 ;
						end
				endcase
			end
		always @ ( posedge clk_cmos )
			begin
				flag_odd_en   <= ( ~flag_odd_even ) && cmos_data_pulse ;
				flag_even_en  <=    flag_odd_even   && cmos_data_pulse ;
			end
		
		
		always @ ( posedge clk_cmos or posedge frame )
			begin
				if ( frame )
					begin
						main_state          <= controller_idle ;
						image_ram_addr_buf      <=  0 ;
						image_data_write_en <=  0 ;
						flag_odd_even       <=  0 ;
						addr_buf1           <=  0 ;
						addr_buf2           <=  0 ;
						image_select        <=  0 ;
					end
				else
					begin
						case ( main_state )
							controller_idle :
								begin
									image_data_write_en       <= 0  ;
									if ( flag_odd_en )
										begin
											main_state                <= decode_addr_odd               ;
											//{flag_odd_even,addr_buf1} <= {flag_odd_even,addr_buf1} + 1 ;
										end
									else
										if ( flag_even_en )
											begin
												main_state                <=  decode_addr_even             ;
												//{flag_odd_even,addr_buf1} <= {flag_odd_even,addr_buf1} + 1 ;
											end
								end
							decode_addr_odd :
								begin
									if ( addr_buf1 == 7 )
										begin
											main_state     <=  controller_idle                                ;
										end
									else
										begin
											main_state     <=  decode_addr_odd                                ;
										end
									{addr_buf2[4:0],flag_odd_even,addr_buf1} <= {addr_buf2[4:0],flag_odd_even,addr_buf1} + 1 ;
									image_ram_addr_buf <= {addr_buf2[3:0],flag_odd_even,(~addr_buf1[1]),(~addr_buf1[0]),(~addr_buf1[2])} ;
									image_data_write_en       <= 1  ;
									image_select   <= addr_buf2[4]                                        ;
								end
							decode_addr_even:
								begin
									if ( addr_buf1 == 7 )
										begin
											main_state     <=  controller_idle                                ;
										end
									else
										begin
											main_state     <=  decode_addr_even                                ;
										end
									{addr_buf2[4:0],flag_odd_even,addr_buf1} <= {addr_buf2[4:0],flag_odd_even,addr_buf1} + 1 ;
									image_ram_addr_buf <= {addr_buf2[3:0],flag_odd_even,addr_buf1[1],addr_buf1[0],addr_buf1[2]}          ;
									//main_state     <=  controller_idle                                                     ;
									image_data_write_en       <= 1  ;
									image_select   <= addr_buf2[4]                                                     ;
								end	
							default         :
								begin
									main_state              <= controller_idle ;
									image_ram_addr_buf          <=  0              ;
									image_data_write_en     <=  0              ;
									flag_odd_even           <=  0 ;
									addr_buf1               <=  0 ;
									addr_buf2               <=  0 ;
									image_select            <=  0 ; 
								end
						endcase
					end
			end

endmodule
