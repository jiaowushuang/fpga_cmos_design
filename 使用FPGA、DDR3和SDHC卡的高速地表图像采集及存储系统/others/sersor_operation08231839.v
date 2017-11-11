`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:34:38 08/22/2017 
// Design Name: 
// Module Name:    sensor_operation 
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
module sensor_operation(

input camera_clk, 
input rst_n,
input read_over,

output  [15:0] write_data_sersor,
output  [8:0] write_sec_sersor,
output  init_over,
output  all_done,
output  reset_n 
);

parameter 		POWER_OFF					= 8'b0000_0001,
					LOW_POWER_STANDBY			= 8'b0000_0010,
					STANGBY_1               = 8'b0000_0100,
					STANGBY_2					= 8'b0000_1000,
					IDLE                    = 8'b0001_0000,
					RUNNING                 = 8'b0010_0000,
               INTERMEDIATE_STANDBY    = 8'b0100_0000;
					
parameter      COUNT                   = 600;    			  //Power up sequence count
reg [7:0]		FSM_STATES;
reg [2:0]counta = 3'd0;                                    //Enable clock management part 1(count)
reg [6:0] countd = 7'd0;
reg [15:0] write_data_sersor_r ;
reg [8:0]  write_sec_sersor_r ;
reg all_done_r;

reg reset_n_r ;

reg [9:0] cnt_sersor;
reg init_over_r ;
reg [107:0] register[24:0];





assign write_data_sersor=write_data_sersor_r ;
assign write_sec_sersor = write_sec_sersor_r ;
assign all_done = all_done_r ;
assign reset_n = reset_n_r;
assign init_over= init_over_r;

always@(posedge camera_clk)
begin
    if(!rst_n)
    begin
        cnt_sersor <= 0;
        all_done_r<= 1'b0 ;
        register[  0]  ={9'd41, 16'h085F} ;
        register[  1]  ={9'd42, 16'h4110} ;
        register[  2]  ={9'd43, 16'h0008} ;
        register[  3]  ={9'd65, 16'h382B} ;
        register[  4]  ={9'd66, 16'h53C8} ;
        register[  5]  ={9'd67, 16'h0665} ;
        register[  6]  ={9'd68, 16'h0085} ;
        register[  7]  ={9'd69, 16'h0088} ;
        register[  8]  ={9'd70, 16'h1111} ;
        register[  9]  ={9'd72, 16'h0010} ;   
        register[  10] ={9'd128,16'h4714} ;
        register[  11] ={9'd129,16'h8001} ;
        register[  12] ={9'd171,16'h1002} ;
        register[  13] ={9'd175,16'h0080} ;
        register[  14] ={9'd176,16'h00E6} ;
        register[  15] ={9'd177,16'h0400} ;
        register[  16] ={9'd192,16'h080C} ;
        register[  17] ={9'd194,16'h0224} ;
        register[  18] ={9'd197,16'h0306} ;
        register[  19] ={9'd204,16'h01E1} ;
        register[  20] ={9'd207,16'h0000} ;
        register[  21] ={9'd211,16'h0E49} ;
        register[  22] ={9'd215,16'h111F} ;
        register[  23] ={9'd216,16'h7F00} ;
        register[  24] ={9'd219,16'h0020} ;
        register[  25] ={9'd220,16'h3A28} ;
        register[  26] ={9'd221,16'h624D} ;
        register[  27] ={9'd222,16'h624D} ;
        register[  28] ={9'd224,16'h3E5E} ;
        register[  29] ={9'd227,16'h0000} ;
        register[  30] ={9'd250,16'h2081} ;  
        register[  31] ={9'd384,16'hC800} ; 
        register[  32] ={9'd385,16'hFB1F} ; 
        register[  33] ={9'd386,16'hFB1F} ; 
        register[  34] ={9'd387,16'hFB12} ; 
        register[  35] ={9'd388,16'hF903} ; 
        register[  36] ={9'd389,16'hF802} ; 
        register[  37] ={9'd390,16'hF30F} ; 
        register[  38] ={9'd391,16'hF30F} ; 
        register[  39] ={9'd392,16'hF30F} ; 
        register[  40] ={9'd393,16'hF30A} ; 
        register[  41] ={9'd394,16'hF101} ; 
        register[  42] ={9'd395,16'hF00A} ; 
        register[  43] ={9'd396,16'hF24B} ; 
        register[  44] ={9'd397,16'hF226} ; 
        register[  45] ={9'd398,16'hF001} ; 
        register[  46] ={9'd399,16'hF402} ;     
        register[  47] ={9'd400,16'hF001} ; 
        register[  48] ={9'd401,16'hF402} ; 
        register[  49] ={9'd402,16'hF001} ; 
        register[  50] ={9'd403,16'hF401} ; 
        register[  51] ={9'd404,16'hF007} ; 
        register[  52] ={9'd405,16'hF20F} ; 
        register[  53] ={9'd406,16'hF20F} ; 
        register[  54] ={9'd407,16'hF202} ; 
        register[  55] ={9'd408,16'hF006} ; 
        register[  56] ={9'd409,16'hEC02} ; 
        register[  57] ={9'd410,16'hE801} ; 
        register[  58] ={9'd411,16'hEC02} ; 
        register[  59] ={9'd412,16'hE801} ; 
        register[  60] ={9'd413,16'hEC02} ; 
        register[  61] ={9'd414,16'hC801} ; 
        register[  62] ={9'd415,16'hC800} ; 
        register[  63] ={9'd416,16'hC800} ; 
        register[  64] ={9'd417,16'hCC02} ; 
        register[  65] ={9'd418,16'hC801} ; 
        register[  66] ={9'd419,16'hCC02} ; 
        register[  67] ={9'd420,16'hC801} ; 
        register[  68] ={9'd421,16'hCC02} ; 
        register[  69] ={9'd422,16'hC805} ; 
        register[  70] ={9'd423,16'hC800} ; 
        register[  71] ={9'd424,16'h0030} ; 
        register[  72] ={9'd425,16'h207C} ; 
        register[  73] ={9'd426,16'h2071} ; 
        register[  74] ={9'd427,16'h0074} ; 
        register[  75] ={9'd428,16'h107F} ; 
        register[  76] ={9'd429,16'h1072} ; 
        register[  77] ={9'd430,16'h1074} ; 
        register[  78] ={9'd431,16'h0076} ; 
        register[  79] ={9'd432,16'h0031} ; 
        register[  80] ={9'd433,16'h21BB} ; 
        register[  81] ={9'd434,16'h20B1} ; 
        register[  82] ={9'd435,16'h20B1} ; 
        register[  83] ={9'd436,16'h00B1} ; 
        register[  84] ={9'd437,16'h10BF} ; 
        register[  85] ={9'd438,16'h10B2} ; 
        register[  86] ={9'd439,16'h10B4} ;     
        register[  87] ={9'd440,16'h00B1} ; 
        register[  88] ={9'd441,16'h0030} ; 
        register[  89] ={9'd442,16'h0030} ; 
        register[  90] ={9'd443,16'h217B} ; 
        register[  91] ={9'd444,16'h2071} ; 
        register[  92] ={9'd445,16'h2071} ; 
        register[  93] ={9'd446,16'h0074} ; 
        register[  94] ={9'd447,16'h107F} ; 
        register[  95] ={9'd448,16'h1072} ; 
        register[  96] ={9'd449,16'h1074} ; 
        register[  97] ={9'd450,16'h0076} ; 
        register[  98] ={9'd451,16'h0031} ; 
        register[  99] ={9'd452,16'h20BB} ; 
        register[ 100] ={9'd453,16'h20B1} ;
        register[ 101] ={9'd454,16'h20B1} ;
        register[ 102] ={9'd455,16'h00B1} ;
        register[ 103] ={9'd456,16'h10BF} ;
        register[ 104] ={9'd457,16'h10B2} ;
        register[ 105] ={9'd458,16'h10B4} ;
        register[ 106] ={9'd459,16'h00B1} ;
        register[ 107] ={9'd460,16'h0030} ;
    end
    else 
    begin
        cnt_sersor <= cnt_sersor+1;
    end
end




reg start_flag = 1'b1;

always@(posedge camera_clk)
begin  
  
  if(!rst_n)begin   FSM_STATES<=POWER_OFF;countd <= 0 ;end
else begin
        case(FSM_STATES)
        POWER_OFF: //Power up sequence|NULL
        begin
            reset_n_r <= 1'b1;
            if(cnt_sersor>COUNT)
            begin
                start_flag <= 1'b1;
                init_over_r <= 1'b1;
                FSM_STATES <= LOW_POWER_STANDBY;
            end
        end
        LOW_POWER_STANDBY: //Enable clock management part 1|Power down sequence
        begin
        if(start_flag)
        begin
            case(counta)
            3'd0:
            begin
            write_sec_sersor_r <= 9'd2;
            write_data_sersor_r <= 16'h0000; //Monochrome sensor
            if(read_over) counta <= counta+1;
            end
            3'd1:
            begin
            write_sec_sersor_r <= 9'd8;
            write_data_sersor_r <= 16'h0000;
            if(read_over) counta <= counta+1;
            end
            3'd2:
            begin
            write_sec_sersor_r <= 9'd16;
            write_data_sersor_r <= 16'h0003;
            if(read_over) counta <= counta+1;
            end
            3'd3:
            begin
            write_sec_sersor_r <= 9'd17;
            write_data_sersor_r <= 16'h2113;
            if(read_over) counta <= counta+1;
            end
            3'd4:
            begin
            write_sec_sersor_r <= 9'd20;
            write_data_sersor_r <= 16'h0000;
            if(read_over) counta <= counta+1;
            end
            3'd5:
            begin
            write_sec_sersor_r <= 9'd26;
            write_data_sersor_r <= 16'h2280;
            if(read_over) counta <= counta+1;
            end
            3'd6:
            begin
            write_sec_sersor_r <= 9'd27;
            write_data_sersor_r <= 16'h3D2D;
            if(read_over) counta <= counta+1;
            end
            3'd7:
            begin
            write_sec_sersor_r <= 9'd32;
            write_data_sersor_r <= 16'h7004;
            if(read_over) counta <= counta+1;
            end
            endcase
            if(counta==7) begin FSM_STATES <= STANGBY_1; counta <=0; start_flag <= 1'b1;end
        end
            /////////////
        else
        begin
            reset_n_r <= 1'b0;
            init_over_r <= 1'b0;
            start_flag<=0;
        end
        end
        STANGBY_1: //Enable clock management part 2|Disable clock management part 1
        begin
        if(start_flag)
        begin
            case(counta)
            3'd0:
            begin
            write_sec_sersor_r <= 9'd9;
            write_data_sersor_r <= 16'h0000; 
            if(read_over) counta <= counta+1;
            end
            3'd1:
            begin
            write_sec_sersor_r <= 9'd32;
            write_data_sersor_r <= 16'h7006;
            if(read_over) counta <= counta+1;
            end
            3'd2:
            begin
            write_sec_sersor_r <= 9'd34;
            write_data_sersor_r <= 16'h0001;
            if(read_over) counta <= counta+1;
            end
            endcase
            if(counta==3) begin FSM_STATES <=INTERMEDIATE_STANDBY; counta<=0; start_flag <= 1'b1;end
        end
            /////////////
        else 
        begin
            case(counta)
            3'd0:
            begin
            write_sec_sersor_r <= 9'd8;
            write_data_sersor_r <= 16'h0099; 
            if(read_over) counta <= counta+1;
            end
            3'd1:
            begin
            write_sec_sersor_r <= 9'd16;
            write_data_sersor_r <= 16'h0000;
            if(read_over) counta <= counta+1;
            end
            endcase
            if(counta==2) begin FSM_STATES <= LOW_POWER_STANDBY; counta<=0;start_flag<=0; all_done_r <= 1;end
        end
        end
        INTERMEDIATE_STANDBY: //Required Register uploaded|NULL
        begin
            if(countd<108)begin
              if(read_over)begin
                 write_sec_sersor_r <= register[countd][24:16];
                 write_data_sersor_r <= register[countd][15:0];
              	  countd <= countd+1;
            	  end
            end
            else if(countd==108) begin FSM_STATES <= STANGBY_2;start_flag <= 1'b1;end

        end
        STANGBY_2: //Soft power up|Disable clock management part 2
        begin
        if(start_flag)
        begin
            case(counta)
            3'd0:
            begin
            write_sec_sersor_r <= 9'd10;
            write_data_sersor_r <= 16'h0000; 
            if(read_over) counta <= counta+1;
            end
            3'd1:
            begin
            write_sec_sersor_r <= 9'd32;
            write_data_sersor_r <= 16'h7007;
            if(read_over) counta <= counta+1;
            end
            3'd2:
            begin
            write_sec_sersor_r <= 9'd40;
            write_data_sersor_r <= 16'h0003;
            if(read_over) counta <= counta+1;
            end
            3'd3:
            begin
            write_sec_sersor_r <= 9'd42;
            write_data_sersor_r <= 16'h4113;
            if(read_over) counta <= counta+1;
            end
            3'd4:
            begin
            write_sec_sersor_r <= 9'd48;
            write_data_sersor_r <= 16'h0001;
            if(read_over) counta <= counta+1;
            end
            3'd5:
            begin
            write_sec_sersor_r <= 9'd64;
            write_data_sersor_r <= 16'h0001;
            if(read_over) counta <= counta+1;
            end
            3'd6:
            begin
            write_sec_sersor_r <= 9'd72;
            write_data_sersor_r <= 16'h0017;
            if(read_over) counta <= counta+1;
            end
            3'd7:
            begin
            write_sec_sersor_r <= 9'd112;
            write_data_sersor_r <= 16'h0007;
            if(read_over) counta <= counta+1;
            end
            endcase
            if(counta==7) begin FSM_STATES <= IDLE;counta <=0;start_flag <= 1'b1; end
        end
            //////////
        else
        begin
            case(counta)
            3'd0:
            begin
            write_sec_sersor_r <= 9'd9;
            write_data_sersor_r <= 16'h0000; 
            if(read_over) counta <= counta+1;
            end
            3'd1:
            begin
            write_sec_sersor_r <= 9'd32;
            write_data_sersor_r <= 16'h7004;
            if(read_over) counta <= counta+1;
            end
            3'd2:
            begin
            write_sec_sersor_r <= 9'd34;
            write_data_sersor_r <= 16'h0000;
            if(read_over) counta <= counta+1;
            end
            endcase
            if(counta==3) begin FSM_STATES <= STANGBY_1; counta<=0;start_flag<=0; end
        end
        end
        IDLE: //Enable sequence|Soft power down
        begin
        if(start_flag)
        begin
            case(counta)
            3'd0:
            begin
            write_sec_sersor_r <= 9'd192;
            write_data_sersor_r <= 16'h080D; 
            if(read_over) counta <= counta+1;
            end
            endcase
            if(counta==1) begin FSM_STATES <= RUNNING; counta<=0;start_flag <= 1'b1;end
        end
//////////////////////////////////////////////
        else
        begin
            case(counta)
            3'd0:
            begin
            write_sec_sersor_r <= 9'd10;
            write_data_sersor_r <= 16'h9999;
            if(read_over) counta <= counta+1; 
            end
            3'd1:
            begin
            write_sec_sersor_r <= 9'd32;
            write_data_sersor_r <= 16'h7006;
            if(read_over) counta <= counta+1;
            end
            3'd2:
            begin
            write_sec_sersor_r <= 9'd40;
            write_data_sersor_r <= 16'h0000;
            if(read_over) counta <= counta+1;
            end
            3'd3:
            begin
            write_sec_sersor_r <= 9'd42;
            write_data_sersor_r <= 16'h4110;
            if(read_over) counta <= counta+1;
            end
            3'd4:
            begin
            write_sec_sersor_r <= 9'd48;
            write_data_sersor_r <= 16'h0000;
            if(read_over) counta <= counta+1;
            end
            3'd5:
            begin
            write_sec_sersor_r <= 9'd64;
            write_data_sersor_r <= 16'h0000;
            if(read_over) counta <= counta+1;
            end
            3'd6:
            begin
            write_sec_sersor_r <= 9'd72;
            write_data_sersor_r <= 16'h0010;
            if(read_over) counta <= counta+1;
            end
            3'd7:
            begin
            write_sec_sersor_r <= 9'd112;
            write_data_sersor_r <= 16'h0000;
            if(read_over) counta <= counta+1;
            end
            endcase
            if(counta==7) begin FSM_STATES <= STANGBY_2;counta<=0;start_flag<=0;end
        end
        end
		  
        RUNNING: // NULL|Disable squence
        begin
        if(start_flag) start_flag<=0;
        else
        begin
            case(counta)
            3'd0:
            begin
            write_sec_sersor_r <= 9'd192;
            write_data_sersor_r <= 16'h080C; 
            if(read_over) counta <= counta+1;
            end
            endcase
            if(counta==1) begin FSM_STATES<=IDLE; counta<=0;start_flag<=0;end
        end
        end
		  
        default: //set IDLE
        begin
            write_sec_sersor_r <= 9'd192;
            write_data_sersor_r <= 16'h080D; 
        end				
endcase
end
end	


    		
											
endmodule
