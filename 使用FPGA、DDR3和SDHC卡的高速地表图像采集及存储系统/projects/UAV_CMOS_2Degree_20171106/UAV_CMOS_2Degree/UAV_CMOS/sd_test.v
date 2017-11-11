

`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////
// Module Name:    sd_test
///////////////////////////////////////////////////////////////////
module sd_test(
					input  clk,     //50Mhz input clock      
					input  rst_n,
//					input  key_in,
					output SD_clk,					
					output SD_cs,
					output SD_datain,
//				   output led_out,
					input  SD_dataout,
					output write_frame_done,
					output request_data,
					input  write_start,
					input [63:0] ddr_data,
					output init_o
					
    );
//reg write_start;
//wire CLKFB;
//wire CLK0;
//wire CLKDV;
//wire CLKFX;
//wire CLK2X;
//wire clock100M;

wire SD_datain_i;
wire SD_datain_w;
wire SD_datain_r;
reg  SD_datain_o;
wire SD_dataout;

wire SD_cs_i;
wire SD_cs_w;
wire SD_cs_r;
reg SD_cs_o;

reg [31:0]write_sec;
reg write_req;
//reg SD_dataout_reg;

wire [7:0]mydata_o;
wire myvalid_o;

wire init_o;
wire write_o;            //SD blcok写完成标识

reg [3:0] sd_state;
wire [3:0] initial_state;
wire [3:0] write_state;


wire rx_valid;

parameter STATUS_INITIAL=4'd0;
parameter STATUS_WRITE=4'd1;
parameter STATUS_IDLE=4'd2;

assign SD_cs=SD_cs_o;
assign SD_datain=SD_datain_o;
//assign SD_clk=clk ;


/*reg [19:0] count_key;//按键计数
reg key_scan;

always@(posedge CLK0 or negedge rst_n) 
begin
	if(!rst_n)
		count_key <= 20'd0 ;
	else 
	begin
		if(count_key == 20'd999999) // 20ms扫描一次按键
			begin
				count_key <= 20'b0 ;
				key_scan  <= key_in ;
			end
		else count_key <= count_key +20'b1;
	end
end

reg key_scan_r;
always@(posedge CLK0) begin key_scan_r <= key_scan ; end

reg flag_key ;

//得到按键指示信号
always @ (posedge CLK0 or negedge rst_n) begin
	if(!rst_n) begin
		flag_key <= 1'b0 ;
	end
	else if(key_scan_r && (~key_scan))begin  //检测到下降沿
		flag_key <= 1'b1 ;
	end
	else if( write_frame_done )begin
		flag_key <= 1'b0 ;
	end
	else flag_key <= flag_key;
end

//输出LED灯


always @ (posedge CLK0 or negedge rst_n)      //检测时钟的上升沿和复位的下降沿
begin
    if (!rst_n) begin                //复位信号低有效
         temp_led <= 1'b1;   //LED灯控制信号输出为低, LED灯全亮
	 end
    else if(flag_key ) begin            
           temp_led <= 0;   //按键KEY1值变化时，LED1将做亮灭翻转
         end
	 else begin
			temp_led <= 1'b1 ;
	end
end */
//reg  temp_led ;
//reg [25:0] cnt_led;
//reg        cnt_led_start;

/*
always @ (posedge SD_clk or negedge rst_n)      //检测时钟的上升沿和复位的下降沿
begin
    if (!rst_n) begin                //复位信号低有效
         temp_led <= 1'b1;   //LED灯控制信号输出为低, LED灯全亮
			//cnt_led_start<= 1'b0;
	 end
    else if(write_flag ) begin            
           temp_led <=  ~temp_led ;			  //检测到一帧数据写完，LED1将亮
			  //cnt_led_start<= 1'b1;
         end
	 //else if(cnt_led==26'd4999999) begin
		//temp_led <= 1'b1 ;
		//cnt_led_start<= 1'b0;
	 //end
	 else temp_led <= temp_led;
end

*/

/*
reg  write_frame_done_r ;
reg  write_frame_done_rr;
always@ (posedge SD_clk or negedge rst_n)
begin
    if (!rst_n) begin                //复位信号低有效
         write_frame_done_r <= 1'b0 ;
			write_frame_done_rr<= 1'b0 ;
	 end
    else begin 
			write_frame_done_r <= write_frame_done ;
			write_frame_done_rr<= write_frame_done_r;
	 end           
end
*/

//reg  cnt_delay_start;
//reg  write_flag ;
//reg  [28:0]  cnt_time  ;
//reg  [9:0] cnt_delay  ;
/*
always@ (posedge SD_clk or negedge rst_n)
begin
    if (!rst_n) begin                //复位信号低有效
			write_flag         <= 1'b0 ;
			cnt_time     <= 29'd0 ;
			//cnt_delay_start          <= 1'b0;
	 end
    else if(write_frame_done_r &&(!write_frame_done_rr)) begin 
			write_flag         <= 1'b1 ;
			cnt_time  <= 29'd0 ;
			//cnt_delay_start    <= 1'b1;
	 end
	 //else if(cnt_delay==1022)
			//cnt_delay_start    <= 1'b0 ;
			//write_flag         <= 1'b0 ;
	 //end
	 else begin
			//cnt_delay_start <= cnt_delay_start;
			write_flag      <= 1'b0 ;
			cnt_time        <= cnt_time+1 ;
	 end
end
*/
/*
always @ (posedge CLK0 or negedge rst_n)      //检测时钟的上升沿和复位的下降沿
begin
    if (!rst_n) begin                //复位信号低有效
         cnt_delay <= 10'd0;   //LED灯控制信号输出为低, LED灯全亮
	 end
    else if(cnt_delay_start ) begin            
           cnt_delay <= cnt_delay + 1 ;   //按键KEY1值变化时，LED1将做亮灭翻转
    end
	 else cnt_led <=10'd0;
end

*/ 
//assign led_out = temp_led;   //配置 P7 引脚  key1 




reg write_frame_done ;

//assign SD_dataout=SD_dataout_reg;
/*******************************/
//SD卡初始化,block写	
/*******************************/

reg [11:0]  count_frame ; 
//reg [9:0]   count_byte  ;
reg [2:0]   count_byte_req  ;

always @ ( posedge SD_clk or negedge rst_n ) begin
    if( !rst_n ) begin
			sd_state <= STATUS_INITIAL;
			write_req <= 1'b0;
			write_sec <= 32'd0;
			write_frame_done <= 1'b0 ;
			count_frame <= 12'd0 ;
			count_byte_req  <= 3'd0 ;
	 end
	 else 
	     case( sd_state )

	      STATUS_INITIAL:      // 等待sd卡初始化结束
			if( init_o  ) begin sd_state <= STATUS_IDLE; write_sec <= 32'd0;end
			else begin sd_state <= STATUS_INITIAL; end	
			
			STATUS_IDLE: begin       //空闲状态
				count_frame <= 12'd0 ;
				count_byte_req  <= 3'd0 ;
				write_frame_done <= 1'b0 ;
				//if ( flag_key) begin  //检测到按键 进入写数据状态，写一帧数据
				if(write_start)begin
					sd_state <= STATUS_WRITE;
				end
				//end
			end
	      STATUS_WRITE: 

			if(count_frame < 12'd2570 )begin
				write_req<=1'b1;
				write_frame_done <= 1'b0;
				if(write_o) begin
					count_frame <= count_frame + 1 ;
					write_sec <= write_sec + 1 ;
				end
				else if(next_byte_req==1)begin
					count_byte_req <= count_byte_req + 1 ;
					//count_byte <= count_byte + 1 ;
				end
				else if(write_state==4'd5)begin
					count_byte_req <= 3'd0 ;
				end
				//else if(/*count_byte == 10'd511 && */next_byte_req==1)begin
					//count_byte <= 10'd0 ;
					//count_data <= 8'd0 ;					
				//end
			end
			else begin
				write_frame_done <= 1'b1;  //写一帧结束 
				write_req<=1'b0;
				count_byte_req <= 3'd0 ;
				count_frame <= 12'd0;
				sd_state <= STATUS_IDLE;
			end

	      
			
			default: sd_state <= STATUS_IDLE;
	      endcase
end			
/*always@(posedge CLK0 or negedge rst_n)begin
	if(!rst_n)begin
		next_byte_req_r <= 1'b0 ;
		next_byte_req_rr <= 1'b0 ;
	end
	else begin
		next_byte_req_r <= next_byte_req ;
		next_byte_req_rr <= next_byte_req_r ;
		if(next_byte_req_r&&(!next_byte_req_rr)) next_byte_flag <= 1'b1 ;
		else next_byte_flag <= 1'b0 ;
	end
end*/  



//always@(posedge SD_clk or negedge rst_n)
//begin
//	if(!rst_n)begin
//		write_start <= 1'b0 ;
//	end
//
//	else if((sd_state==STATUS_INITIAL) && init_o)begin
//		write_start <= 1'b1 ;
//	end
//	
//	else if((sd_state==STATUS_IDLE) && write_flag)begin
//		write_start <= 1'b1 ;
//	end
//	else begin
//		write_start <= 1'b0 ;
//	end
//end




reg  [6:0] cnt_request ;
reg [63:0] ddr_data_reg;
always@ (posedge SD_clk or negedge rst_n)
begin
    if (!rst_n) begin                //复位信号低有效
         request_data <= 1'b0 ;
			ddr_data_reg <= 64'd0;
			cnt_request   <= 7'd0 ;
	 end
	 	 
	 else if((write_state==4'd3)&&(cnta==3'd7))begin
			request_data <= 1'b1;
			ddr_data_reg <= ddr_data;
			cnt_request <= cnt_request + 1 ;
	 end
    else if((count_byte_req==7)&&next_byte_req&&(cnt_request<7'd64)) begin 
		   request_data <= 1'b1;
			ddr_data_reg <= ddr_data;
			cnt_request <= cnt_request + 1 ;
	 end           
	 else if((cnt_request==7'd64)&&(write_state==4'd5)) begin
		request_data <= 1'b0 ;
		cnt_request <= 7'd0 ;		
	 end
	 else begin
		request_data <= 1'b0 ;
	 end
	 
end




//reg [63:0] ddr_data_come ;
//reg  [7:0] cnt_data_0   ;
//reg  [7:0] cnt_data_1   ;
//reg  [7:0] cnt_data_2   ;
//reg  [7:0] cnt_data_3   ;
//reg  [7:0] cnt_data_4   ;
//reg  [7:0] cnt_data_5   ;
//reg  [7:0] cnt_data_6   ;
//reg  [7:0] cnt_data_7   ;

reg  request_data;
//always@(posedge SD_clk or negedge rst_n)begin
//	if(!rst_n)begin
//		//ddr_data_come   <= 64'h0706050403020100;
//		cnt_data_0  <= 8'd8   ;
//		cnt_data_1  <= 8'd9   ;
//		cnt_data_2  <= 8'd10   ;
//		cnt_data_3  <= 8'd11  ;
//		cnt_data_4  <= 8'd12   ;
//		cnt_data_5  <= 8'd13   ;
//		cnt_data_6  <= 8'd14   ;
//		cnt_data_7  <= 8'd15   ;
//	end
//	else if(request_data) begin
//		ddr_data_come <= {cnt_data_7,cnt_data_6,cnt_data_5,cnt_data_4,cnt_data_3,cnt_data_2,cnt_data_1,cnt_data_0};
//		cnt_data_0   <=   cnt_data_0 + 8 ;
//		cnt_data_1   <=   cnt_data_1 + 8 ;
//		cnt_data_2   <=   cnt_data_2 + 8 ;
//		cnt_data_3   <=   cnt_data_3 + 8 ;
//		cnt_data_4   <=   cnt_data_4 + 8 ;
//		cnt_data_5   <=   cnt_data_5 + 8 ;
//		cnt_data_6   <=   cnt_data_6 + 8 ;
//		cnt_data_7   <=   cnt_data_7 + 8 ;		
//	end
//end 
wire [7:0] data_transfer;
reg [7:0] data_tran;
assign data_transfer = data_tran;



always@(posedge SD_clk or negedge rst_n)begin
	if(!rst_n)begin
		data_tran <= 8'd0 ;
	end
	else begin
		case (count_byte_req)
		0:begin
			if(next_byte_req)begin
				data_tran <= ddr_data_reg[7:0];
			end
		end
		1:begin
			if(next_byte_req)begin
				data_tran <= ddr_data_reg[15:8];
			end
		end
		2:begin
			if(next_byte_req)begin
				data_tran <= ddr_data_reg[23:16];
			end
		end
		3:begin
			if(next_byte_req)begin
				data_tran <= ddr_data_reg[31:24];
			end
		end
		4:begin
			if(next_byte_req)begin
				data_tran <= ddr_data_reg[39:32];
			end
		end
		5:begin
			if(next_byte_req)begin
				data_tran <= ddr_data_reg[47:40];
			end
		end
		6:begin
			if(next_byte_req)begin
				data_tran <= ddr_data_reg[55:48];
			end
		end
		7:begin
			if(next_byte_req)begin
				data_tran <= ddr_data_reg[63:56];
			end
		end
//		default: data_tran <= 8'd0 ;
		endcase
	end
end


/*reg 	next_byte_req_r ;
reg 	next_byte_req_rr ;
reg   next_byte_flag ;

always@(posedge CLK0 or negedge rst_n)begin
	if(!rst_n)begin
		next_byte_req_r <= 1'b0 ;
		next_byte_req_rr <= 1'b0 ;
	end
	else begin
		next_byte_req_r <= next_byte_req ;
		next_byte_req_rr <= next_byte_req_r ;
		if(next_byte_req_r&&(!next_byte_req_rr)) next_byte_flag <= 1'b1 ;
		else next_byte_flag <= 1'b0 ;
	end
end  */



//SD卡初始化程序
wire [47:0]rx;				
sd_initial	sd_initial_inst(					
						.rst_n(rst_n),
						.SD_clk(SD_clk),
						.SD_cs(SD_cs_i),
						.SD_datain(SD_datain_i),
						.SD_dataout(SD_dataout),
						.rx(rx),
						.init_o(init_o),
						.rx_valid(rx_valid),						
						.state(initial_state)

);

//SD卡block写程序, 写512个0~255,0~255的数据	
wire next_byte_req;		//高电平，分发下一byte数据 
wire [7:0] data_transfer_r;
wire [3:0] cnta;
wire [7:0] rx_data;
wire  [12:0] cnt_busy;
wire [9:0]  cnt_req ;
sd_write	sd_write_inst(   
						.SD_clk(SD_clk),
						.rst_n (rst_n),
						.SD_cs(SD_cs_w),
						.SD_datain(SD_datain_w),
						.SD_dataout(SD_dataout),
						.data_transfer(data_tran),
						.init(init_o),
						.sec(write_sec),
						.write_req(write_req),
						.mystate(write_state),
						.rx_valid(),
						.next_byte_req (next_byte_req),
						
						.cnt_busy(cnt_busy),
						.cnt_req(cnt_req),
						
						.data_transfer_r(data_transfer_r),
						.cnta(cnta),
						.rx(rx_data),
						.write_o(write_o)			
						
    );

always @(*)
begin
	 case( sd_state )
	 STATUS_INITIAL: begin SD_cs_o<=SD_cs_i;SD_datain_o<=SD_datain_i; end
	 STATUS_WRITE: begin SD_cs_o<=SD_cs_w;SD_datain_o<=SD_datain_w; end
	 default: begin SD_cs_o<=1'b1;SD_datain_o<=1'b1; end	 
	 endcase
end

//////////////////////////////////////////提供SD卡时钟
//DCM_SP #(
//      .CLKDV_DIVIDE(2),                   // CLKDV divide value
//                                            // (1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,9,10,11,12,13,14,15,16).
//      .CLKFX_DIVIDE(4),                     // Divide value on CLKFX outputs - D - (1-32)
//      .CLKFX_MULTIPLY(2),                   // Multiply value on CLKFX outputs - M - (2-32)
//      .CLKIN_DIVIDE_BY_2("FALSE"),          // CLKIN divide by two (TRUE/FALSE)
//      .CLKIN_PERIOD(20.0),                  // Input clock period specified in nS
//      .CLKOUT_PHASE_SHIFT("NONE"),          // Output phase shift (NONE, FIXED, VARIABLE)
//      .CLK_FEEDBACK("1X"),                  // Feedback source (NONE, 1X, 2X)
//      .DESKEW_ADJUST("SYSTEM_SYNCHRONOUS"), // SYSTEM_SYNCHRNOUS or SOURCE_SYNCHRONOUS
//      .DFS_FREQUENCY_MODE("LOW"),           // Unsupported - Do not change value
//      .DLL_FREQUENCY_MODE("LOW"),           // Unsupported - Do not change value
//      .DSS_MODE("NONE"),                    // Unsupported - Do not change value
//      .DUTY_CYCLE_CORRECTION("TRUE"),       // Unsupported - Do not change value
//      .FACTORY_JF(16'hc080),                // Unsupported - Do not change value
//      .PHASE_SHIFT(0),                      // Amount of fixed phase shift (-255 to 255)
//      .STARTUP_WAIT("FALSE")                // Delay config DONE until DCM_SP LOCKED (TRUE/FALSE)
//   )
//   DCM_SP_inst (
//      .CLK0(CLK0),         // 1-bit output: 0 degree clock output
//      .CLK180(CLK180),     // 1-bit output: 180 degree clock output
//      .CLK270(CLK270),     // 1-bit output: 270 degree clock output
//      .CLK2X(CLK2X),       // 1-bit output: 2X clock frequency clock output
//      .CLK2X180(CLK2X180), // 1-bit output: 2X clock frequency, 180 degree clock output
//      .CLK90(CLK90),       // 1-bit output: 90 degree clock output
//      .CLKDV(CLKDV),       // 1-bit output: Divided clock output
//      .CLKFX(CLKFX),       // 1-bit output: Digital Frequency Synthesizer output (DFS)
//      .CLKFX180(CLKFX180), // 1-bit output: 180 degree CLKFX output
//      .LOCKED(LOCKED),     // 1-bit output: DCM_SP Lock Output
//
//      .CLKFB(CLKFB),       // 1-bit input: Clock feedback input
//      .CLKIN(clk_o),       // 1-bit input: Clock input
//      .PSEN(1'b0),
//      .RST(1'b0)            // 1-bit input: Active high reset input
//   ); 
//
//
//
//
//BUFG bufg_inst(
//					.I(CLK0),
//					.O(CLKFB)
//					);
//  
//BUFG bufg_insta(
//					.I(CLKDV),
//					.O(SD_clk)
//					);
//
//BUFG bufg_instb(
//					.I(CLK2X),
//					.O(clock100M)
//					);
//BUFG bufg_instc(
//					.I(clk),
//					.O(clk_o)
//					);



/***************************/
//chipscope icon和ila, 用于观察信号//
/***************************/	
//wire [35:0]   CONTROL0;
//wire [255:0]  TRIG0;
//chipscope_icon icon_debug (
//    .CONTROL0(CONTROL0) // INOUT BUS [35:0]
//);
//
//chipscope_ila ila_filter_debug (
//    .CONTROL(CONTROL0), // INOUT BUS [35:0]
//   // .CLK(dma_clk),    // IN
//    .CLK(SD_clk),      // IN, chipscope的采样时钟
//    .TRIG0(TRIG0)       // IN BUS [255:0], 采样的信号
//    //.TRIG_OUT(TRIG_OUT0)
//);                                                     
//
////assign  TRIG0[0]=cnt_led_start;    //采样信号                                           
////assign  TRIG0[20:1]=count_key ;
//
//
//assign  TRIG0[7:0] =  data_tran ;
//assign  TRIG0 [8] =request_data ;
//assign  TRIG0[11:9]=cnta;
//assign  TRIG0[12]=SD_datain;
//assign  TRIG0[20:13]=rx_data;
//assign  TRIG0[21]=temp_led;
//assign  TRIG0[33:22]=count_frame ;
// 
//assign  TRIG0[97:34]=ddr_data_come  ;
//
//assign  TRIG0[100:98]=count_byte_req  ;
//
//assign  TRIG0[164:101]= ddr_data_reg ;
//
//
//
//
//
//
//assign  TRIG0[168:165]=write_state; //idle=4'd0; write_cmd=4'd1;wait_8clk=4'd2; start_taken=4'd3; writea=4'd4; write_crc=4'd5; write_wait=4'd6; write_done=4'd7;
//assign  TRIG0[169]=next_byte_req;
//assign  TRIG0[177:170]=cnt_data_0 ;
//assign  TRIG0[185:178]=cnt_data_1 ;
//assign  TRIG0[193:186]=cnt_data_2 ;
//assign  TRIG0[201:194]=cnt_data_3 ;
//assign  TRIG0[209:202]=cnt_data_4 ;
//assign  TRIG0[217:210]=cnt_data_5 ;
//assign  TRIG0[225:218]=cnt_data_6 ;
//assign  TRIG0[233:226]=cnt_data_7 ;
//assign  TRIG0[241:234]=data_transfer_r;
//
//assign  TRIG0[242]=write_frame_done;
























/*assign  TRIG0[214:0:] =  data_transfer ;
assign  TRIG0[8:1]=data_transfer_r;
assign  TRIG0[11:9]=cnta;
assign  TRIG0[12]=SD_datain;
assign  TRIG0[20:13]=rx_data;
assign  TRIG0[21]=temp_led;
assign  TRIG0[33:22]=count_frame ;
 
assign  TRIG0[43:34]=ddr_data_reg[9:0]  ;

assign  TRIG0[46:44]=count_byte_req  ;
assign  TRIG0 [47] =request_data ;

assign  TRIG0[51:48]=ddr_data_reg[13:10]  ;


assign  TRIG0[52]=write_frame_done;
assign  TRIG0[53]=init_o;
assign  TRIG0[54]=write_o;


assign  TRIG0[58:55]=sd_state;//parameter STATUS_INITIAL=4'd0; STATUS_WRITE=4'd1;  STATUS_IDLE=4'd2;


assign  TRIG0[59]=write_req;
assign  TRIG0[60]=next_byte_req;

assign  TRIG0[64:61]=initial_state;     //parameter idle=4'b0000; send_cmd0=4'b0001;   wait_01=4'b0010;   waitb=4'b0011;  send_cmd8=4'b0100; waita=4'b0101; send_cmd55=4'b0110; send_acmd41=4'b0111;init_done=4'b1000; init_fail=4'b1001;
 
assign  TRIG0[116:69]=rx;  //SD卡输出数据
assign  TRIG0[117]=rx_valid;

assign  TRIG0[121:118]=write_state; //idle=4'd0; write_cmd=4'd1;wait_8clk=4'd2; start_taken=4'd3; writea=4'd4; write_crc=4'd5; write_wait=4'd6; write_done=4'd7;

assign  TRIG0[153:122]=write_sec;*/







/*assign  TRIG0[182:154] = cnt_time ;
assign  TRIG0[195:184]= cnt_busy;
assign  TRIG0[196]= SD_dataout;
assign  TRIG0[206:197]= cnt_req;*/

DCM_SP #(
      .CLKDV_DIVIDE(2),                   // CLKDV divide value
                                            // (1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,9,10,11,12,13,14,15,16).
      .CLKFX_DIVIDE(2),                     // Divide value on CLKFX outputs - D - (1-32)
      .CLKFX_MULTIPLY(2),                   // Multiply value on CLKFX outputs - M - (2-32)
      .CLKIN_DIVIDE_BY_2("FALSE"),          // CLKIN divide by two (TRUE/FALSE)
      .CLKIN_PERIOD(20.0),                  // Input clock period specified in nS
      .CLKOUT_PHASE_SHIFT("NONE"),          // Output phase shift (NONE, FIXED, VARIABLE)
      .CLK_FEEDBACK("1X"),                  // Feedback source (NONE, 1X, 2X)
      .DESKEW_ADJUST("SYSTEM_SYNCHRONOUS"), // SYSTEM_SYNCHRNOUS or SOURCE_SYNCHRONOUS
      .DFS_FREQUENCY_MODE("LOW"),           // Unsupported - Do not change value
      .DLL_FREQUENCY_MODE("LOW"),           // Unsupported - Do not change value
      .DSS_MODE("NONE"),                    // Unsupported - Do not change value
      .DUTY_CYCLE_CORRECTION("TRUE"),       // Unsupported - Do not change value
      .FACTORY_JF(16'hc080),                // Unsupported - Do not change value
      .PHASE_SHIFT(0),                      // Amount of fixed phase shift (-255 to 255)
      .STARTUP_WAIT("FALSE")                // Delay config DONE until DCM_SP LOCKED (TRUE/FALSE)
   )
   DCM_SP_inst (
      .CLK0(clk0),         // 1-bit output: 0 degree clock output
      .CLK180(CLK180),     // 1-bit output: 180 degree clock output
      .CLK270(CLK270),     // 1-bit output: 270 degree clock output
      .CLK2X(CLK2X),       // 1-bit output: 2X clock frequency clock output
      .CLK2X180(CLK2X180), // 1-bit output: 2X clock frequency, 180 degree clock output
      .CLK90(CLK90),       // 1-bit output: 90 degree clock output
      .CLKDV(CLKDV),       // 1-bit output: Divided clock output
      .CLKFX(CLKFX),       // 1-bit output: Digital Frequency Synthesizer output (DFS)
      .CLKFX180(CLKFX180), // 1-bit output: 180 degree CLKFX output
      .LOCKED(LOCKED),     // 1-bit output: DCM_SP Lock Output

      .CLKFB(CLKFB),       // 1-bit input: Clock feedback input
      .CLKIN(clk_o),       // 1-bit input: Clock input
      .PSEN(1'b0),
      .RST(1'b0)            // 1-bit input: Active high reset input
   ); 




BUFG bufg_inst(
					.I(clk0),
					.O(CLKFB)
					);
  
BUFG bufg_insta(
					.I(CLKFX),
					.O(SD_clk)
					);
					
//BUFG bufg_instb(
					//.I(CLK2X),
					//.O(clock100M)
					//);	
					
BUFG bufg_instc(
					.I(clk),
					.O(clk_o)
					);
endmodule
