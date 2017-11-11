module spi(
    clk         ,
    rst_n       ,
    addr        ,
    data_in     ,
    cmd_write   ,
    cmd_read    ,
    spi_in      ,
    write_done  ,
    read_done   ,
    ss_n        ,
    spi_out     ,
    sck         ,
    spi_in_flag ,
    dout
    );

    //参数定义
    parameter      DATA_W =         16;
    parameter      ADDR_W =         9 ;

    //输入信号定义
    input               clk          ;
    input               rst_n        ;
    input[DATA_W-1:0]   data_in      ;
    input[ADDR_W-1:0]   addr         ;            
    input               cmd_write    ;
    input               cmd_read     ;
    input               spi_in       ;
    
    //输出信号定义
    output[DATA_W-1:0]  dout         ;
    output              write_done   ;
    output              read_done    ;
    output              ss_n         ;
    output              spi_out      ;
    output              sck          ;
    output              spi_in_flag  ;
    
    
    
    
    

    //中间信号reg定义
    reg[DATA_W-1:0]   data_r       ;
    reg[ADDR_W:0]     addr_r       ;            
    reg               cmd_write_r  ;
    reg               cmd_write_rr ;    
    reg               cmd_read_r   ;
    reg               cmd_read_rr  ;    
    reg[4:0]          cnt_spi      ;
    reg[4:0]          i            ;
    reg[DATA_W-1:0]   dataout_r    ;
    reg               ss_n_r       ;
	reg               sck_r        ;
	reg               spi_out_r    ;
	reg               write_done_r ;
	reg               read_done_r  ;
    reg               spi_in_flag_r;    
    

   



    //产生SS_N信号
    always@(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            cmd_read_rr <= 1'b0 ;
            cmd_read_r  <= 1'b0 ;
            cmd_write_rr<= 1'b0 ;
            cmd_write_r <= 1'b0 ;
            cnt_spi     <= 5'd0 ;
            i           <= 5'd0 ;
            ss_n_r      <= 1'b1 ;				
        end
        else begin
            cmd_read_r   <= cmd_read    ;
            cmd_read_rr  <= cmd_read_r  ;
            cmd_write_r  <= cmd_write   ;
            cmd_write_rr <= cmd_write_r ;
            if(i==5'd30&&cnt_spi==5'd3)begin
                    i <= 5'd0  ;
            end
            if(cmd_write_rr==1'b1||cmd_read_rr==1'b1)begin
                if(cnt_spi==5'd24)begin
                    cnt_spi <=5'd0 ;
                    i  <= i+ 1 ;
                end
               else if(i==5'd30&&cnt_spi==5'd3)begin
                 cnt_spi <= 5'd0 ;
               end
                
                else begin
                  cnt_spi <= cnt_spi + 1 ;
                end
              if(i<5'd28)begin
                    ss_n_r     <=  1'b0       ;
              end  
              if(i==5'd28)begin
                    ss_n_r  <= 1'b1 ;
              end
            end
          else begin
            ss_n_r <= 1'b1 ;
          end
        end
    end
    //产生SCK信号    
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            sck_r         <= 1'b0 ;
        end
        else begin
            if(i>0 && i < 5'd27)begin
                if(cnt_spi==0 || cnt_spi == 5'd12)begin
                    sck_r <= ~sck_r ;
                end
            end
            else begin
                sck_r <= 1'd0 ;
            end

        end
    end
    //产生spi_out信号
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            spi_out_r <= 1'b0 ;
            dataout_r <= 16'd0;
            write_done_r <= 1'b0;
            read_done_r  <= 1'b0;
            spi_in_flag_r  <= 1'b0;
        end
        else begin
//            if(i==5'd0 && cnt_spi==5'd0)begin
//                dataout_r <= 16'd0 ;
//            end
            if(cmd_write_rr==1'b1)begin
                data_r  <= data_in      ;
                addr_r  <= {addr,1'b1}  ;
 //               if((i>=5'd0&&i<5'd10)&&cnt_spi== 5'd12)begin
 //                   spi_out_r  <= addr_r[9-i] ;
 //               end
                if(i==5'd0&& cnt_spi== 5'd12)begin
                    spi_out_r  <= addr_r[9-i] ;
                end
                if(i==5'd1&& cnt_spi== 5'd12)begin
                    spi_out_r  <= addr_r[9-i] ;
                end
                if(i==5'd2&& cnt_spi== 5'd12)begin
                    spi_out_r  <= addr_r[9-i] ;
                end
                if(i==5'd3&& cnt_spi== 5'd12)begin
                    spi_out_r  <= addr_r[9-i] ;
                end
                if(i==5'd4&& cnt_spi== 5'd12)begin
                    spi_out_r  <= addr_r[9-i] ;
                end
                if(i==5'd5&& cnt_spi== 5'd12)begin
                    spi_out_r  <= addr_r[9-i] ;
                end
                if(i==5'd6&& cnt_spi== 5'd12)begin
                    spi_out_r  <= addr_r[9-i] ;
                end
                if(i==5'd7&& cnt_spi== 5'd12)begin
                    spi_out_r  <= addr_r[9-i] ;
                end
                if(i==5'd8&& cnt_spi== 5'd12)begin
                    spi_out_r  <= addr_r[9-i] ;
                end
                if(i==5'd9&& cnt_spi== 5'd12)begin
                    spi_out_r  <= addr_r[9-i] ;
                end
                //????
                if(i==5'd10&&cnt_spi==5'd12)begin
                    spi_out_r  <= data_r[25-i];
                end
                if(i==5'd11&&cnt_spi==5'd12)begin
                    spi_out_r  <= data_r[25-i];
                end
                if(i==5'd12&&cnt_spi==5'd12)begin
                    spi_out_r  <= data_r[25-i];
                end
                if(i==5'd13&&cnt_spi==5'd12)begin
                    spi_out_r  <= data_r[25-i];
                end
                if(i==5'd14&&cnt_spi==5'd12)begin
                    spi_out_r  <= data_r[25-i];
                end
                if(i==5'd15&&cnt_spi==5'd12)begin
                    spi_out_r  <= data_r[25-i];
                end
                if(i==5'd16&&cnt_spi==5'd12)begin
                    spi_out_r  <= data_r[25-i];
                end
                if(i==5'd17&&cnt_spi==5'd12)begin
                    spi_out_r  <= data_r[25-i];
                end
                if(i==5'd18&&cnt_spi==5'd12)begin
                    spi_out_r  <= data_r[25-i];
                end
                if(i==5'd19&&cnt_spi==5'd12)begin
                    spi_out_r  <= data_r[25-i];
                end
                if(i==5'd20&&cnt_spi==5'd12)begin
                    spi_out_r  <= data_r[25-i];
                end
                if(i==5'd21&&cnt_spi==5'd12)begin
                    spi_out_r  <= data_r[25-i];
                end
                if(i==5'd22&&cnt_spi==5'd12)begin
                    spi_out_r  <= data_r[25-i];
                end
                if(i==5'd23&&cnt_spi==5'd12)begin
                    spi_out_r  <= data_r[25-i];
                end
                if(i==5'd10&&cnt_spi==5'd12)begin
                    spi_out_r  <= data_r[25-i];
                end
                if(i==5'd10&&cnt_spi==5'd12)begin
                    spi_out_r  <= data_r[25-i];
                end
                if(i==5'd24&&cnt_spi==5'd12)begin
                    spi_out_r  <= data_r[25-i];
                end
                if(i==5'd25&&cnt_spi==5'd12)begin
                    spi_out_r  <= data_r[25-i];
                end
                if(i==5'd26&&cnt_spi==5'd12)begin
                    spi_out_r  <= 1'b0 ;
                end
                if(i==5'd30&&cnt_spi==5'd0)begin
                    write_done_r<=1'b1;
                end
                else begin
                    write_done_r<= 1'b0;
                end
            end
            else if(cmd_read_rr==1'b1)begin   //若同时读写有效，只进行写操作
                addr_r  <={addr,1'b0};

                if(i==5'd0&& cnt_spi== 5'd12)begin
                    spi_out_r  <= addr_r[9-i] ;
                end
                else if(i==5'd1&& cnt_spi== 5'd12)begin
                    spi_out_r  <= addr_r[9-i] ;
                end
                else if(i==5'd2&& cnt_spi== 5'd12)begin
                    spi_out_r  <= addr_r[9-i] ;
                end
                else if(i==5'd3&& cnt_spi== 5'd12)begin
                    spi_out_r  <= addr_r[9-i] ;
                end
                else if(i==5'd4&& cnt_spi== 5'd12)begin
                    spi_out_r  <= addr_r[9-i] ;
                end
                else if(i==5'd5&& cnt_spi== 5'd12)begin
                    spi_out_r  <= addr_r[9-i] ;
                end
                else if(i==5'd6&& cnt_spi== 5'd12)begin
                    spi_out_r  <= addr_r[9-i] ;
                end
                else if(i==5'd7&& cnt_spi== 5'd12)begin
                    spi_out_r  <= addr_r[9-i] ;
                end
                else if(i==5'd8&& cnt_spi== 5'd12)begin
                    spi_out_r  <= addr_r[9-i] ;
                end
                else if(i==5'd9&& cnt_spi== 5'd12)begin
                    spi_out_r  <= addr_r[9-i] ;
                end

                else if(i==5'd11&&cnt_spi==5'd12)begin
                    dataout_r[26-i]  <= spi_in;
                end
                else if(i==5'd12&&cnt_spi==5'd12)begin
                    dataout_r[26-i]  <= spi_in;
                end
                else if(i==5'd13&&cnt_spi==5'd12)begin
                    dataout_r[26-i]  <= spi_in;
                end
                else if(i==5'd14&&cnt_spi==5'd12)begin
                    dataout_r[26-i]  <= spi_in;
                end
                else if(i==5'd15&&cnt_spi==5'd12)begin
                    dataout_r[26-i]  <= spi_in;
                end
                if(i==5'd16&&cnt_spi==5'd12)begin
                    dataout_r[26-i]  <= spi_in;
                end
                else if(i==5'd17&&cnt_spi==5'd12)begin
                    dataout_r[26-i]  <= spi_in;
                end
                else if(i==5'd18&&cnt_spi==5'd12)begin
                    dataout_r[26-i]  <= spi_in;
                end
                else if(i==5'd19&&cnt_spi==5'd12)begin
                    dataout_r[26-i]  <= spi_in;
                end
                else if(i==5'd20&&cnt_spi==5'd12)begin
                    dataout_r[26-i]  <= spi_in;
                end
                else if(i==5'd21&&cnt_spi==5'd12)begin
                    dataout_r[26-i]  <= spi_in;
                end
                else if(i==5'd22&&cnt_spi==5'd12)begin
                    spi_out_r  <= data_r[25-i];
                end
                else if(i==5'd23&&cnt_spi==5'd12)begin
                    dataout_r[26-i]  <= spi_in;
                end
                else if(i==5'd24&&cnt_spi==5'd12)begin
                    dataout_r[26-i]  <= spi_in;
                end
                else if(i==5'd25&&cnt_spi==5'd12)begin
                    dataout_r[26-i]  <= spi_in;
                end
                else if(i==5'd26&&cnt_spi==5'd12)begin
                    dataout_r[26-i]  <= spi_in;
                end

                else if(i==5'd29 && cnt_spi==5'd24)begin
                    read_done_r<=1'b1;
                end
                else begin
                     read_done_r<=1'b0 ;
                end
				end
			else begin
				spi_out_r <= 1'b0 ;
			end
      end
	end
	always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
      spi_in_flag_r <= 1'b0      ;
    end
    else begin
      if(cmd_read_rr==1'b1)begin
        if(i==5'd11 && cnt_spi==5'd0)begin
          spi_in_flag_r <= 1'b1      ;
        end
        else begin spi_in_flag_r <= 1'b0    ;end
      end 
      else begin 
        spi_in_flag_r <= 1'b0    ;
      end
    end
end
	assign dout = dataout_r ;
	assign ss_n = ss_n_r       ;
	assign sck  = sck_r        ;
	assign spi_out=spi_out_r    ;
	assign spi_in_flag=spi_in_flag_r  ;    
	assign write_done=write_done_r ;
	assign read_done= read_done_r  ;
endmodule

