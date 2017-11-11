module register_option_spi(
	input  sys_clk_50M,          
	input  sys_reset_n,
    
	input  data_miso_in,
   output data_mosi_out,			
	output sck,					
	output ss_n	,
   output spi_in_flag 

);

reg [3:0] sersor_register_state;
parameter STATUS_INITIAL = 4'd0;
parameter STATUS_WRITE   = 4'd1;
parameter STATUS_READ    = 4'd2;
parameter STATUS_IDLE    = 4'd3;

//初始化写,读(req:请求；sec：地址)	
reg read_req;
//reg [8:0]read_sec;
reg write_req;
reg [8:0]write_sec;

wire [8:0]write_sec_sersor;
reg [8:0]write_sec_sersor_rr;
wire [15:0]write_data_sersor;
wire       init_over       ;
wire       all_done        ;
wire [8:0]     write_sec_sersor_r;
wire       write_over ;
wire       read_over  ;
wire [15:0]    data_rec;
reg [15:0]    write_data_sersor_r;
reg [15:0]    data_rec_r;

assign        data_in = data_rec_r;


always@(posedge sys_clk_50M or negedge sys_reset_n)
begin
    if(!sys_reset_n) 
    begin
			sersor_register_state <= 4'd0;
			read_req  <= 1'b0;
			//read_sec  <= 9'd0;
			write_req <= 1'b0;
			write_sec_sersor_rr <= 9'd0;
					
	end
	else 
	    case(sersor_register_state)
	    0:             //等待sersor_operation初始化完毕的指示信号（包括每一个状态的指示信号）
			if(init_over==1'b1) 
                begin 
                sersor_register_state <= 4'd1;
                end
			else 
                begin 
                sersor_register_state <= 4'd0; 
                end	
        1: 
            begin  
                if(!all_done)   
                    begin 
                    sersor_register_state <= 4'd2;
                    write_sec_sersor_rr <= write_sec_sersor_r; 
                    write_req <= 1'b1; 
                end
                else 
                    sersor_register_state <= 4'd1;
            end
	    2:        
			if(write_over) 
                begin 
                sersor_register_state <= 4'd3; 
                write_sec_sersor_rr<= write_sec_sersor_r; 
                read_req <= 1'b1;
                write_req<=1'b0;
                end
			else 
                begin 
                write_req <= 1'b1; 
                sersor_register_state <= 4'd2; 
                end
		  3:       
			if(read_over) 
                begin 
                sersor_register_state <= 4'd1;
                read_req <= 1'b0; 
                end
			else 
                begin 
                read_req <= 1'b1; 
                sersor_register_state <= 3;  
                end	
		default: begin
                sersor_register_state <= 4'd1;
                read_req <= 1'b0;
                write_req <= 1'b0;
              end
      endcase
end

//wire ss_n;
//wire sck ;
wire spi_in;
//wire spi_in_flag;
//wire data_miso_in;
//wire data_mosi_out;

//wire write_over;            //写完成标识
//wire read_over;             //读完成标识
//wire all_done;

//wire write_req ;
//wire read_req ;

//wire sys_clk_50M ;
//wire sys_reset_n ;

assign write_sec_sersor_r = write_sec_sersor;

sensor_operation sensor_operation_inst(
    .init_over(init_over),
    .camera_clk(sys_clk_50M),
    .rst_n(sys_reset_n),
    .write_data_sersor(write_data_sersor),
    .write_sec_sersor(write_sec_sersor),
    .read_over(read_over),
    .all_done(all_done)
); 

//写程序			 
spi spi_inst(   		
    .clk          ( sys_clk_50M        ) ,
    .rst_n        ( sys_reset_n        ) ,
    .addr         ( write_sec_sersor_rr ) ,
    .data_in      ( write_data_sersor_r) ,
    .cmd_write    ( write_req          ) ,
    .cmd_read     ( read_req           ) ,
    .spi_in       ( data_miso_in       ) ,
    .write_done   ( write_over         ) ,
    .read_done    ( read_over          ) ,
    .ss_n         ( ss_n               ) ,
    .spi_out      ( data_mosi_out      ) ,
    .sck          ( sck                ) ,
    .spi_in_flag  ( spi_in_flag        ) ,
    .dout         ( data_rec           )
								
);

//读写


always@(posedge sys_clk_50M)
begin
	case(sersor_register_state)
	STATUS_INITIAL: 
        begin
            if(init_over) sersor_register_state <=STATUS_WRITE;
            else sersor_register_state <= STATUS_INITIAL;
        end
	STATUS_WRITE: 
        begin
             write_data_sersor_r <= write_data_sersor;
        end
	STATUS_READ: 
        begin
            data_rec_r <= data_rec;
        end
	default: 
        begin 
        data_rec_r<=16'b0; 
        write_data_sersor_r <= 16'b0;
        end	 
	endcase
end
endmodule
