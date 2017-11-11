`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:05:54 08/22/2017
// Design Name:   spi
// Module Name:   D:/work/ADC Snap/ON_sensor/ON_sensor/test_spi.v
// Project Name:  ON_sensor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: spi
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module write_read_spi;

	// Inputs
	reg clk;
	reg rst_n;
	reg spi_in;

	// Outputs
    wire spi_in_flag;
	wire ss_n;
	wire spi_out;
	wire sck;

//????????ns???????????
        parameter CYCLE    = 20;

        //???????????3?????????
        parameter RST_TIME = 3 ;
	// Instantiate the Unit Under Test (UUT)
	register_option_spi uut (
		.sys_clk_50M     (clk)      , 
		.sys_reset_n     (rst_n)    ,   
		.data_miso_in    (spi_in)   ,  
		.ss_n            (ss_n)     , 
		.data_mosi_out   (spi_out)  , 
		.sck             (sck)      ,
        .spi_in_flag     (spi_in_flag)    
	);


//生成本地时钟50M
            initial begin
                clk = 0;
                forever
                #(CYCLE/2)
                clk=~clk;
            end

            //产生复位信号
            initial begin
                rst_n = 1;
                #10;
                rst_n = 0;
                #(CYCLE*RST_TIME);
                rst_n = 1;
            end

            //输入信号din0赋值方式
 

            initial begin
                #1;
                repeat(300) begin
                    wait(spi_in_flag==1'b1)
                    spi_in = 1  ;
                    #(25*CYCLE) ;
                    spi_in = 0  ;
                    #(25*CYCLE) ;
                    spi_in = 0  ;
                    #(25*CYCLE) ;
                    spi_in = 0  ;
                    #(25*CYCLE) ;
                    spi_in = 0  ;
                    #(25*CYCLE) ;
                    spi_in = 1  ;
                    #(25*CYCLE) ;
                    spi_in = 0  ;
                    #(25*CYCLE) ;
                    spi_in = 0  ;
                    #(25*CYCLE) ;
                    spi_in = 0  ;
                    #(25*CYCLE) ;
                    spi_in = 0  ;
                    #(25*CYCLE) ;
                    spi_in = 1  ;
                    #(25*CYCLE) ;
                    spi_in = 0  ;
                    #(25*CYCLE) ;
                    spi_in = 0  ;
                    #(25*CYCLE) ;
                    spi_in = 0  ;
                    #(25*CYCLE) ;
                    spi_in = 0  ;
                    #(25*CYCLE) ;
                    spi_in = 1  ;
                    #(25*CYCLE) ;
                    spi_in = 0  ;     //1000 0100 0010 0001 
                end
            end
      
endmodule

