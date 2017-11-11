`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:26:49 09/24/2017 
// Design Name: 
// Module Name:    image_core_interface 
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
module image_core_interface(
								clk_input,clk_input_invert,
								lvds_data0,lvds_data1,lvds_data2,lvds_data3,lvds_sync,
								channel_0_data,channel_1_data,channel_2_data,channel_3_data,
								cmos_monitor,cmos_triger0,cmos_triger1,cmos_triger2,
								frame
							);
							
						input  clk_input ;
						input  clk_input_invert;
						input  lvds_data0,lvds_data1,lvds_data2,lvds_data3;
						input  lvds_sync ;
						output [19:0]channel_0_data,channel_1_data,channel_2_data,channel_3_data;
						input  [1:0]cmos_monitor ;
						output cmos_triger0,cmos_triger1,cmos_triger2 ;
						output frame ;
						
						reg    [19:0]channel_0_data,channel_1_data,channel_2_data,channel_3_data;
						reg    cmos_triger0,cmos_triger1,cmos_triger2 ;
						reg    frame ;
/////////////////////////////////////////////////////////////////////////////////////////////
						wire   lvds_data0_invert ;
						wire   lvds_data0_uninvert;
			reg iddr_reset = 0 ;
			reg iddr_enable =1 ;
			IDDR2 #
				(
					.DDR_ALIGNMENT("NONE"), // Sets output alignment to "NONE", "C0" or "C1"
					.INIT_Q0(1'b0), // Sets initial state of the Q0 output to 1'b0 or 1'b1
					.INIT_Q1(1'b0), // Sets initial state of the Q1 output to 1'b0 or 1'b1
					.SRTYPE("SYNC") // Specifies "SYNC" or "ASYNC" set/reset
				) 
			IDDR2_lvds_channel0 
				(
					.Q0(lvds_data0_uninvert), // 1-bit output captured with C0 clock
					.Q1(lvds_data0_invert  ), // 1-bit output captured with C1 clock
					.C0(clk_input), // 1-bit clock input
					.C1(clk_input_invert), // 1-bit clock input
					.CE(iddr_enable), // 1-bit clock enable input
					.D(lvds_data0), // 1-bit DDR data input
					.R(iddr_reset), // 1-bit reset input
					.S(iddr_reset) // 1-bit set input
				);
						wire   lvds_data1_invert ;
						wire   lvds_data1_uninvert;
			IDDR2 #
				(
					.DDR_ALIGNMENT("NONE"), // Sets output alignment to "NONE", "C0" or "C1"
					.INIT_Q0(1'b0), // Sets initial state of the Q0 output to 1'b0 or 1'b1
					.INIT_Q1(1'b0), // Sets initial state of the Q1 output to 1'b0 or 1'b1
					.SRTYPE("SYNC") // Specifies "SYNC" or "ASYNC" set/reset
				) 
			IDDR2_lvds_channel1 
				(
					.Q0(lvds_data1_uninvert), // 1-bit output captured with C0 clock
					.Q1(lvds_data1_invert  ), // 1-bit output captured with C1 clock
					.C0(clk_input), // 1-bit clock input
					.C1(clk_input_invert), // 1-bit clock input
					.CE(iddr_enable), // 1-bit clock enable input
					.D(lvds_data1), // 1-bit DDR data input
					.R(iddr_reset), // 1-bit reset input
					.S(iddr_reset) // 1-bit set input
				);
						wire   lvds_data2_invert ;
						wire   lvds_data2_uninvert;
			IDDR2 #
				(
					.DDR_ALIGNMENT("NONE"), // Sets output alignment to "NONE", "C0" or "C1"
					.INIT_Q0(1'b0), // Sets initial state of the Q0 output to 1'b0 or 1'b1
					.INIT_Q1(1'b0), // Sets initial state of the Q1 output to 1'b0 or 1'b1
					.SRTYPE("SYNC") // Specifies "SYNC" or "ASYNC" set/reset
				) 
			IDDR2_lvds_channel2
				(
					.Q0(lvds_data2_uninvert), // 1-bit output captured with C0 clock
					.Q1(lvds_data2_invert  ), // 1-bit output captured with C1 clock
					.C0(clk_input), // 1-bit clock input
					.C1(clk_input_invert), // 1-bit clock input
					.CE(iddr_enable), // 1-bit clock enable input
					.D(lvds_data2), // 1-bit DDR data input
					.R(iddr_reset), // 1-bit reset input
					.S(iddr_reset) // 1-bit set input
				);
						wire   lvds_data3_invert ;
						wire   lvds_data3_uninvert;
			IDDR2 #
				(
					.DDR_ALIGNMENT("NONE"), // Sets output alignment to "NONE", "C0" or "C1"
					.INIT_Q0(1'b0), // Sets initial state of the Q0 output to 1'b0 or 1'b1
					.INIT_Q1(1'b0), // Sets initial state of the Q1 output to 1'b0 or 1'b1
					.SRTYPE("SYNC") // Specifies "SYNC" or "ASYNC" set/reset
				) 
			IDDR2_lvds_channel3 
				(
					.Q0(lvds_data3_uninvert), // 1-bit output captured with C0 clock
					.Q1(lvds_data3_invert  ), // 1-bit output captured with C1 clock
					.C0(clk_input), // 1-bit clock input
					.C1(clk_input_invert), // 1-bit clock input
					.CE(iddr_enable), // 1-bit clock enable input
					.D(lvds_data3), // 1-bit DDR data input
					.R(iddr_reset), // 1-bit reset input
					.S(iddr_reset) // 1-bit set input
				);
						wire   lvds_sync_invert ;
						wire   lvds_sync_uninvert;
			IDDR2 #
				(
					.DDR_ALIGNMENT("NONE"), // Sets output alignment to "NONE", "C0" or "C1"
					.INIT_Q0(1'b0), // Sets initial state of the Q0 output to 1'b0 or 1'b1
					.INIT_Q1(1'b0), // Sets initial state of the Q1 output to 1'b0 or 1'b1
					.SRTYPE("SYNC") // Specifies "SYNC" or "ASYNC" set/reset
				) 
			IDDR2_lvds_sync
				(
					.Q0(lvds_sync_uninvert), // 1-bit output captured with C0 clock
					.Q1(lvds_sync_invert  ), // 1-bit output captured with C1 clock
					.C0(clk_input), // 1-bit clock input
					.C1(clk_input_invert), // 1-bit clock input
					.CE(iddr_enable), // 1-bit clock enable input
					.D(lvds_sync), // 1-bit DDR data input
					.R(iddr_reset), // 1-bit reset input
					.S(iddr_reset) // 1-bit set input
				);
/////////////////////////////////////////////////////////////////////////////////////
			reg [19:0]channel_0_data_buf ;
			always @ ( posedge clk_input )
				begin
					channel_0_data_buf[1:0] <= { lvds_data0_uninvert,lvds_data0_invert };
					channel_0_data_buf[19:2]<= channel_0_data_buf[17:0]                 ;
				end
			reg [19:0]channel_1_data_buf ;
			always @ ( posedge clk_input )
				begin
					channel_1_data_buf[1:0] <= { lvds_data1_uninvert,lvds_data1_invert };
					channel_1_data_buf[19:2]<= channel_1_data_buf[17:0]                 ;
				end
			reg [19:0]channel_2_data_buf ;
			always @ ( posedge clk_input )
				begin
					channel_2_data_buf[1:0] <= { lvds_data2_uninvert,lvds_data2_invert };
					channel_2_data_buf[19:2]<= channel_2_data_buf[17:0]                 ;
				end
			reg [19:0]channel_3_data_buf ;
			always @ ( posedge clk_input )
				begin
					channel_3_data_buf[1:0] <= { lvds_data3_uninvert,lvds_data3_invert };
					channel_3_data_buf[19:2]<= channel_3_data_buf[17:0]                 ;
				end
			reg [9:0]channel_sync_buf ;
			always @ ( posedge clk_input )
				begin
					channel_sync_buf[1:0] 	<= { lvds_sync_uninvert,lvds_sync_invert } ;
					channel_sync_buf[9:2]	<= channel_sync_buf[9:0]                  ;
				end
				
			always @ ( posedge clk_input )
				begin
					if ( head_flag )
						begin
							channel_0_data <= channel_0_data_buf ;
							channel_1_data <= channel_1_data_buf ;
							channel_2_data <= channel_2_data_buf ;
							channel_3_data <= channel_3_data_buf ;
						end
				end
				
			reg [2:0]counter_5   ;
			reg counter_flag     ;
			reg head_flag        ;
			always @ ( posedge clk_input )
				begin
					if ( channel_sync_buf == 10'h3A6)
						begin
							counter_flag <= 1 ;
						end
					else
						begin
							counter_flag <= 0 ;
						end
				end
			always @ ( posedge clk_input )
				begin
					if ( counter_5 == 4 )
						begin
							counter_5 <= 0 ;
							head_flag <= 1 ;
						end
					else
						begin
							counter_5 <= counter_5 + 1 ;
							head_flag <= 0             ;
						end
				end
			always @ ( posedge clk_input )
				begin
					frame <=	head_flag ;
				end
			
endmodule
