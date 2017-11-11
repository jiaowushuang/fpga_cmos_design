module image_interface(
								clk_input,request_image,initial_done,
								channel_data_0,channel_data_1,channel_data_2,channel_data_3,
								sync_channel,
								triger0,triger1,triger2,
								monitor,
								image_fifo_en,training_pattern,
								//image_data0,image_data1,image_data2,image_data3,image_data4,image_data5,image_data6,image_data7
								image_data_ddr,frame_end
							 );
/////////////////////////////////////////////////////////////////////////////////////////					
			input  clk_input ;
			input  initial_done;
			input  request_image;
			input  [1:0]channel_data_0,channel_data_1,channel_data_2,channel_data_3;
			input  [1:0]sync_channel;
			output triger0,triger1,triger2;
			output frame_end ;
			reg    triger0,triger1,triger2;
			input  [1:0]monitor ;
/////////////////////////////////////////////////////////////////////////////////////////
			//output [9:0]image_data0,image_data1,image_data2,image_data3,image_data4,image_data5,image_data6,image_data7 ;
			output [63:0]image_data_ddr ;
			reg    [63:0]image_data_ddr ;
			reg    [9:0]image_data0,image_data1,image_data2,image_data3,image_data4,image_data5,image_data6,image_data7 ;
			output image_fifo_en   ;
			reg    image_fifo_en   ;
			output training_pattern;
			reg    training_pattern;
			//reg    image_data0_latch,image_data1_latch,image_data2_latch,image_data3_latch,image_data4_latch,image_data5_latch,image_data6_latch,image_data7_latch;
//////////////////////////////////////////////////////////////////////////////////////////
			reg    [9:0]sync_channel_buf  ;
			reg    [9:0]channel_data_0_buf;
			reg    [9:0]channel_data_1_buf;
			reg    [9:0]channel_data_2_buf;
			reg    [9:0]channel_data_3_buf; 
			always @ ( posedge clk_input )
				begin
					sync_channel_buf[1:0] <= sync_channel ;
					sync_channel_buf[9:2] <= sync_channel_buf[7:0] ;
				end
			always @ ( posedge clk_input )
				begin
					channel_data_0_buf[1:0] <= channel_data_0 ;
					channel_data_0_buf[9:2] <= channel_data_0_buf[7:0] ;
				end
			always @ ( posedge clk_input )
				begin
					channel_data_1_buf[1:0] <= channel_data_1 ;
					channel_data_1_buf[9:2] <= channel_data_1_buf[7:0] ;
				end
			always @ ( posedge clk_input )
				begin
					channel_data_2_buf[1:0] <= channel_data_2 ;
					channel_data_2_buf[9:2] <= channel_data_2_buf[7:0] ;
				end
			always @ ( posedge clk_input )
				begin
					channel_data_3_buf[1:0] <= channel_data_3 ;
					channel_data_3_buf[9:2] <= channel_data_3_buf[7:0] ;
				end
////////////////////////////////////////////////////////////////////Generate Trigger signal
			reg [5:0]trigger_counter ;
			always @ ( posedge clk_input )
				begin
					if ( request_image )
						begin
							triger0 <= 1 ;
							trigger_counter <= 0 ;
						end
					else
						if ( trigger_counter[5] )
							begin
								triger0 <= 0 ;
							end
						else
							begin
								trigger_counter <= trigger_counter + 1 ;
							end
						
				end
////////////////////////////////////////////////////////////////////Judge the training code
			reg flag_3 ;
			reg flag_3_buf1 ;
			reg flag_3_buf2 ;
			reg flag_3_buf3 ;
			reg flag_3_buf4 ;
			reg flag_3_buf5 ;
			reg flag_A ;
			reg flag_A_buf1 ;
			reg flag_A_buf2 ;
			reg flag_A_buf3 ;
			reg flag_6 ;
			reg flag_training       ;
			always @ ( posedge clk_input )
				begin
					training_pattern <= flag_training ;
				end
			always @ ( posedge clk_input )
				begin
					if ( sync_channel_buf[1:0] == 2'b11 )
						begin
							flag_3 <= 1 ;
						end
					else
						begin
							flag_3 <= 0 ;
						end
					if ( sync_channel_buf[3:0] == 4'b1010 )
						begin
							flag_A <= 1 ;
						end
					else
						begin
							flag_A <= 0 ;
						end
					if ( sync_channel_buf[3:0] == 4'b0110 )
						begin
							flag_6 <= 1 ;
						end
					else
						begin
							flag_6 <= 0 ;
						end
					flag_3_buf1 <= flag_3 ;
					flag_3_buf2 <= flag_3_buf1 ;
					flag_3_buf3 <= flag_3_buf2 ;
					flag_3_buf4 <= flag_3_buf3 ;
					flag_3_buf5 <= flag_3_buf4 ;
					flag_A_buf1 <= flag_A      ;
					flag_A_buf2 <= flag_A_buf1 ;
					flag_A_buf3 <= flag_A_buf2 ;
					flag_training        <= flag_3_buf4 && flag_A_buf2 && flag_6  ;
				end
////////////////////////////////////////////////////////////////////Judgeing Frame start
			reg sync_flag_5     ;
			reg sync_flag_6     ;
			reg sync_flag_1     ;
			reg sync_flag_2     ;
			reg sync_flag_2A    ;
			reg frame_start_flag;
			reg frame_end_flag  ;
			reg line_start_flag ;
			reg line_end_flag   ;
			reg frame_start_flag_buf;
			reg frame_end_flag_buf  ;
			reg line_start_flag_buf ;
			reg line_end_flag_buf   ;
			reg frame_start_flag_rising;
			reg frame_end_flag_rising  ;
			reg line_start_flag_rising ;
			reg line_end_flag_rising   ;
			always @ ( posedge clk_input )
				begin
					if ( sync_code[9:7] == 3'b101 )
						begin
							sync_flag_5 <= 1 ;
						end
					else
						begin
							sync_flag_5 <= 0 ;
						end
					if ( sync_code[9:7] == 3'b110 )
						begin
							sync_flag_6 <= 1 ;
						end
					else
						begin
							sync_flag_6 <= 0 ;
						end
					if ( sync_code[9:7] == 3'b001 )
						begin
							sync_flag_1 <= 1 ;
						end
					else
						begin
							sync_flag_1 <= 0 ;
						end
					if ( sync_code[9:7] == 3'b010 )
						begin
							sync_flag_2 <= 1 ;
						end
					else
						begin
							sync_flag_2 <= 0 ;
						end
					if ( sync_code[6:0] == 7'b0101010 )
						begin
							sync_flag_2A <= 1 ;
						end
					else
						begin
							sync_flag_2A <= 0 ;
						end
					frame_start_flag <= sync_flag_5 && sync_flag_2A ;
					frame_end_flag   <= sync_flag_6 && sync_flag_2A ;
					line_start_flag  <= sync_flag_1 && sync_flag_2A ;
					line_end_flag    <= sync_flag_2 && sync_flag_2A ;
					frame_start_flag_buf <= frame_start_flag        ;
					frame_end_flag_buf   <= frame_end_flag          ;
					line_start_flag_buf  <= line_start_flag         ;
					line_end_flag_buf    <= line_end_flag           ;
					frame_start_flag_rising <= (~frame_start_flag_buf) && frame_start_flag;
					frame_end_flag_rising   <= (~frame_end_flag_buf)   && frame_end_flag  ;
					line_start_flag_rising  <= (~line_start_flag_buf)  && line_start_flag ;
					line_end_flag_rising    <= (~line_end_flag_buf)    && line_end_flag   ;
				end
////////////////////////////////////////////////////////////////////
			reg [3:0]main_state ;
			reg [2:0]counter_5  ;
			parameter 
				power_up       = 4'b0000 ,
				training_code  = 4'b0001 ,
				image_idle     = 4'b0010 ,    
				image_read_out = 4'b0100 ,
				image_buffer   = 4'b1000 ;
			always @ ( posedge clk_input )
				begin
					if ( flag_training )
						begin
							counter_5 		 <= 1 ;
							latch_counter_5 <= 0 ;
						end
					else
						if ( counter_5 == 4)
							begin
								counter_5       <= 0 ;
								latch_counter_5 <= 1 ;
							end
						else
							begin
								counter_5       <= counter_5 + 1 ;
								latch_counter_5 <= 0 ;
							end
				end
			always @ ( posedge clk_input )
				begin
					case ( main_state )
						power_up       :
							begin
								if ( initial_done )
									main_state <= image_idle ;
							end
						training_code  :
							begin
								if ( frame_start_flag_rising )
									begin
										main_state <= image_read_out ;
									end
								else
									if ( line_start_flag_rising )
										begin
											main_state <= image_read_out ;
										end
							end
						image_idle     :
							begin
								if ( flag_training )
									main_state <= training_code ;
							end
						image_read_out :
							begin
								if ( line_end_flag_rising )
									begin
										main_state <= image_idle ;
									end
								else
									if ( frame_end_flag_rising )
										begin
											main_state <= image_idle ;
										end
							end
						default        :
							begin
								main_state <= image_idle ;
							end
					endcase
				end
//////////////////////////////////////////////////////////////////
			reg frame_flag ;
			reg frame_end_buf1;
			reg frame_end_buf2;
			reg frame_end     ;
			reg frame_end_buf3;
			reg frame_end_buf4;
			reg frame_end_buf5;
			reg frame_end_buf6;
			reg frame_end_buf7;
			reg frame_end_buf8;
			reg frame_end_buf9;
			reg frame_end_buf10;
			reg frame_end_buf11;
			reg frame_end_buf12;
			always @ ( posedge clk_input )
				begin
					frame_end_buf1  <= frame_flag ;
					frame_end_buf2  <= frame_end_buf1 ;
					frame_end_buf3  <= (  ~frame_end_buf1 ) && frame_end_buf2 ;
					frame_end_buf4  <= frame_end_buf3 ;
					frame_end_buf5  <= frame_end_buf4 ;
					frame_end_buf6  <= frame_end_buf5 ;
					frame_end_buf7  <= frame_end_buf6 ;
					frame_end_buf8  <= frame_end_buf7 ;
					frame_end_buf9  <= frame_end_buf8 ;
					frame_end_buf10 <= frame_end_buf9 ;
					frame_end_buf11 <= frame_end_buf10 ;
					frame_end_buf12 <= frame_end_buf11 ;
					frame_end       <= frame_end_buf12 ;
				end
			always @ ( posedge clk_input )
				begin
					if ( sync_code == 10'h32A )
						begin
							frame_flag <= 1 ;
						end
					else
						begin
							frame_flag <= 0 ;
						end
				end

			reg [3:0]counter_4 ;
			reg flag_odd_even ;
			reg image_fifo_en_buf;
			reg latch_counter_5;
			reg latch_counter_5_buf1;
			reg latch_counter_5_buf2;
			reg [9:0]sync_code ;
			reg flag_counter   ;
			reg flag_counter_buf;
			reg [9:0]image_data0_latch;
			reg [9:0]image_data1_latch;
			reg [9:0]image_data2_latch;
			reg [9:0]image_data3_latch;
			reg [9:0]image_data4_latch;
			reg [9:0]image_data5_latch;
			reg [9:0]image_data6_latch;
			reg [9:0]image_data7_latch;
			reg [9:0]sync_code_buf1 ;
			reg [9:0]channel_data_0_buf1;
			reg [9:0]channel_data_1_buf1;
			reg [9:0]channel_data_2_buf1;
			reg [9:0]channel_data_3_buf1;
			reg [9:0]sync_code_buf2 ;
			reg [9:0]channel_data_0_buf2;
			reg [9:0]channel_data_1_buf2;
			reg [9:0]channel_data_2_buf2;
			reg [9:0]channel_data_3_buf2;
			reg image_fifo_en_buf1;
			reg image_fifo_en_buf2;
			reg image_fifo_en_buf3;
			always @ ( posedge clk_input )
				if ( frame_end )
					begin
						image_fifo_en_buf1 <= 0 ;
						image_fifo_en_buf2 <= 0 ;
						image_fifo_en_buf3 <= 0 ;
						image_fifo_en      <= 0 ;
						image_data_ddr     <= 0 ;
					end
				else
				begin
					image_fifo_en_buf1 <= image_fifo_en_buf ;
					image_fifo_en_buf2 <= image_fifo_en_buf1;
					image_fifo_en_buf3 <= image_fifo_en_buf2;
					image_fifo_en      <= image_fifo_en_buf3;
					if ( image_fifo_en_buf3 )
						begin
							//image_data_ddr[15:0] <= image_data_ddr[15:0] + 1 ;
							image_data_ddr <= { image_data7[9:2],image_data6[9:2],image_data5[9:2],image_data4[9:2],image_data3[9:2],image_data2[9:2],image_data1[9:2],image_data0[9:2] } ;
							//image_data_ddr   <= {8'hAA ,8'hBB ,8'hCC ,8'hDD ,8'h99,8'h88 ,8'h55,8'hEE};
						end
//					else
//						if ( image_data_ddr[15:0] == 160 )
//							begin
//								image_data_ddr[31:16] <= image_data_ddr[31:16] + 1 ;
//								image_data_ddr[15:0] <= 0                          ;
//							end
						
				end
			always @ ( posedge clk_input )
				begin
					sync_code_buf1 <= sync_channel_buf ;
					sync_code_buf2 <= sync_code_buf1;
					channel_data_0_buf1 <= channel_data_0_buf ;
					channel_data_0_buf2 <= channel_data_0_buf1;
					channel_data_1_buf1 <= channel_data_1_buf ;
					channel_data_1_buf2 <= channel_data_1_buf1;
					channel_data_2_buf1 <= channel_data_2_buf ;
					channel_data_2_buf2 <= channel_data_2_buf1;
					channel_data_3_buf1 <= channel_data_3_buf ;
					channel_data_3_buf2 <= channel_data_3_buf1;
				end
			always @ ( posedge clk_input )
				begin
					latch_counter_5_buf1 <= latch_counter_5 ;
					latch_counter_5_buf2 <= latch_counter_5_buf1 ;
				end
			always @ ( posedge clk_input )
				begin
					if ( latch_counter_5 )
						begin
							if ( flag_counter == 0 )
								begin
									counter_4     <= 1 ;
									flag_odd_even <= 1 ;
								end
							else
								begin
									counter_4 			  <= counter_4 + 1		;
								end
							sync_code             <= sync_code_buf2     ;
							image_data7_latch     <= channel_data_0_buf2;
							image_data6_latch     <= image_data7_latch  ;
							image_data5_latch     <= image_data6_latch  ;
							image_data4_latch     <= image_data5_latch  ;
							image_data3_latch     <= image_data4_latch  ;
							image_data2_latch     <= image_data3_latch  ;
							image_data1_latch     <= image_data2_latch  ;
							image_data0_latch     <= image_data1_latch  ;
						end
					else
						begin
							if ( sync_code == 10'h2AA )
								begin
									flag_counter <= 1 ;
								end
							else
								if ( sync_code == 10'h0AA )
									begin
										flag_counter <= 1 ;
									end
								else
									if ( sync_code == 10'h059 )
										begin
											flag_counter <= 0 ;
										end
							if ( counter_4 == 8 )
								begin
									flag_odd_even   <= flag_odd_even + 1  ;
									counter_4       <= 0                  ;
									image_data0     <= image_data7_latch  ;
									image_data1     <= image_data3_latch  ;
									image_data2     <= image_data6_latch  ;
									image_data3     <= image_data2_latch  ;
									image_data4     <= image_data5_latch  ;
									image_data5     <= image_data1_latch  ;
									image_data6     <= image_data4_latch  ;
									image_data7     <= image_data0_latch  ;
									image_fifo_en_buf<= 1                  ;
								end
							else
								if ( flag_odd_even == 0 )
									begin
										image_data0     <= image_data0_latch  ;
										image_data1     <= image_data4_latch  ;
										image_data2     <= image_data1_latch  ;
										image_data3     <= image_data5_latch  ;
										image_data4     <= image_data2_latch  ;
										image_data5     <= image_data6_latch  ;
										image_data6     <= image_data3_latch  ;
										image_data7     <= image_data7_latch  ;
										image_fifo_en_buf   <= 0              ;
									end
								else
									begin
										image_data0     <= image_data0_latch  ;
										image_data1     <= image_data1_latch  ;
										image_data2     <= image_data2_latch  ;
										image_data3     <= image_data3_latch  ;
										image_data4     <= image_data4_latch  ;
										image_data5     <= image_data5_latch  ;
										image_data6     <= image_data6_latch  ;
										image_data7     <= image_data7_latch  ;
										image_fifo_en_buf   <= 0              ;
									end
						end
				end
endmodule
