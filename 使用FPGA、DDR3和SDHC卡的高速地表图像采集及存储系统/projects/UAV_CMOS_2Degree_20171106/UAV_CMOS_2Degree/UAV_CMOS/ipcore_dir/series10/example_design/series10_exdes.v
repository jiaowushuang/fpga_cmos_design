// file: series10_exdes.v
// (c) Copyright 2009 - 2011 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.

//----------------------------------------------------------------------------
// SelectIO wizard example design
//----------------------------------------------------------------------------
// This example design instantiates the IO circuitry
//----------------------------------------------------------------------------

`timescale 1ps/1ps

module series10_exdes
   // Clock -> q modeling delay
 #(
   // width of the data for the system
   parameter sys_w = 1,
   // width of the data for the device
   parameter dev_w = 2)
  (
   output     [1:0]       PATTERN_COMPLETED_OUT,
   // From the system into the device
   input      [sys_w-1:0] DATA_IN_FROM_PINS_P,
   input      [sys_w-1:0] DATA_IN_FROM_PINS_N,
   output [sys_w-1:0] DATA_OUT_TO_PINS_P,
   output [sys_w-1:0] DATA_OUT_TO_PINS_N,
   output  CLK_TO_PINS_FWD_P,
   output  CLK_TO_PINS_FWD_N,
  
   input                  CLK_IN_P,
   input                  CLK_IN_N,
   input                  CLK_IN_FWD_P,
   input                  CLK_IN_FWD_N,
   input                  CLK_RESET,
   input                  IO_RESET);


   localparam             num_serial_bits = dev_w/sys_w;
   wire        clkin1;

   reg  [num_serial_bits-1:0]  count_out;
   reg [num_serial_bits-1:0] local_counter;

   wire [dev_w-1:0]       data_in_to_device;
   reg [dev_w-1:0]       data_in_to_device_int2;
   reg [dev_w-1:0]       data_in_to_device_int3;

   wire  [dev_w-1:0]       data_out_from_device;
   wire [sys_w-1:0]  oserdes_d[0:7];   
   wire   [sys_w-1:0] data_out_to_pins_predelay;
   wire        clock_enable = 1'b1;

   wire                   clk_div_out;
   wire                   clkfbout;
   wire                   clk_in_pll;
   wire                   clk_in_pll1;
   wire                   clkfbout_buf;
   wire                   locked_in;
   wire                   locked_out;
   (* KEEP = "TRUE" *) wire        clk_div_in_int;
   wire                   clk_div_in;
   wire                    clk_fwd_out;

   reg rst_sync;
   reg rst_sync_int;
   reg rst_sync_int1;
   reg rst_sync_int2;
   reg rst_sync_int3;
   reg rst_sync_int4;
   reg rst_sync_int5;
   reg rst_sync_int6;
 
   reg rst_sync_d;
   reg rst_sync_int_d;
   reg rst_sync_int1_d;
   reg rst_sync_int2_d;
   reg rst_sync_int3_d;
   reg rst_sync_int4_d;
   reg rst_sync_int5_d;
   reg rst_sync_int6_d;
   reg [1:0] pattern_completed = 2'b00;
   reg start_check;


  IBUFGDS clkin_in_buf
   (.O (clkin1),
    .I (CLK_IN_P),
      .IB (CLK_IN_N));


   // set up the fabric PLL_BASE to drive the BUFPLL
   PLL_BASE
   #(.BANDWIDTH             ("OPTIMIZED"),
     .CLK_FEEDBACK          ("CLKFBOUT"),
     .COMPENSATION          ("SYSTEM_SYNCHRONOUS"),
     .DIVCLK_DIVIDE         (1),
     .CLKFBOUT_MULT         (8),
     .CLKFBOUT_PHASE        (0.000),
     .CLKOUT0_DIVIDE        (4),
     .CLKOUT0_PHASE         (0.000),
     .CLKOUT0_DUTY_CYCLE    (0.500),
     .CLKOUT1_DIVIDE        (4),
     .CLKOUT1_PHASE         (0.000),
     .CLKOUT1_DUTY_CYCLE    (0.500),
     .CLKOUT2_DIVIDE        (4*num_serial_bits),
     .CLKOUT2_PHASE         (0.000),
     .CLKOUT2_DUTY_CYCLE    (0.500),
     .CLKOUT3_DIVIDE        (8),
     .CLKOUT3_PHASE         (0.000),
     .CLKOUT3_DUTY_CYCLE    (0.500),
    .CLKIN_PERIOD          (10.0),
     .REF_JITTER            (0.010))
   pll_base_inst
     // Output clocks
    (.CLKFBOUT              (clkfbout),
     .CLKOUT0               (clk_in_pll1),
     .CLKOUT1               (clk_fwd_int),
     .CLKOUT2               (clk_div_in_int),
     .CLKOUT3               (clk_div_fwd_int),
     .CLKOUT4               (),
     .CLKOUT5               (),
     // Status and control signals
     .LOCKED                (locked_in),
     .RST                   (CLK_RESET),
      // Input clock control
     .CLKFBIN               (clkfbout_buf),
     .CLKIN                 (clkin1));

    BUFG clkfb_buf
    (.O (clkfbout_buf),
     .I (clkfbout));

    BUFG clkf_buf
    (.O (clk_div_in),
     .I (clk_div_in_int));

    BUFG clko_buf
    (.O (clk_in_pll),
     .I (clk_in_pll1));

    BUFG clk_fwd_buf
    (.O (clk_div_fwd),
     .I (clk_div_fwd_int));


   always @(posedge clk_div_out or posedge IO_RESET) begin
   if (IO_RESET) begin
       rst_sync <= 1'b1;
       rst_sync_int <= 1'b1;
       rst_sync_int1 <= 1'b1;
       rst_sync_int2 <= 1'b1;
       rst_sync_int3 <= 1'b1;
       rst_sync_int4 <= 1'b1;
       rst_sync_int5 <= 1'b1;
       rst_sync_int6 <= 1'b1;
    end
   else begin
       rst_sync <= 1'b0;
       rst_sync_int <= rst_sync;
       rst_sync_int1 <= rst_sync_int;
       rst_sync_int2 <= rst_sync_int1;
       rst_sync_int3 <= rst_sync_int2;
       rst_sync_int4 <= rst_sync_int3;
       rst_sync_int5 <= rst_sync_int4;
       rst_sync_int6 <= rst_sync_int5;
   end
   end

   always @(posedge clk_div_in or posedge IO_RESET) begin
   if (IO_RESET) begin
       rst_sync_d <= 1'b1;
       rst_sync_int_d <= 1'b1;
       rst_sync_int1_d <= 1'b1;
       rst_sync_int2_d <= 1'b1;
       rst_sync_int3_d <= 1'b1;
       rst_sync_int4_d <= 1'b1;
       rst_sync_int5_d <= 1'b1;
       rst_sync_int6_d <= 1'b1;
    end
   else begin
       rst_sync_d <= 1'b0;
       rst_sync_int_d <= rst_sync_d;
       rst_sync_int1_d <= rst_sync_int_d;
       rst_sync_int2_d <= rst_sync_int1_d;
       rst_sync_int3_d <= rst_sync_int2_d;
       rst_sync_int4_d <= rst_sync_int3_d;
       rst_sync_int5_d <= rst_sync_int4_d;
       rst_sync_int6_d <= rst_sync_int5_d;
   end
   end




   always @(posedge clk_div_in) begin
   if (rst_sync_int6_d) begin
     count_out <= 0;
     end
   else if (locked_in) begin
     count_out <= count_out + 1'b1;
     end
   end



   genvar assg;
   genvar pinsss;
   for (assg = 0 ; assg < num_serial_bits ; assg = assg + 1) begin
   for (pinsss = 0 ; pinsss < sys_w ; pinsss = pinsss + 1)
     begin
       assign data_out_from_device[pinsss+sys_w*assg] = count_out[assg];
   end
   end


   always @(posedge clk_div_out) begin
   if (rst_sync_int6) 
       pattern_completed <= 2'b00;

   else begin
 
     if (&data_in_to_device_int3) begin
       pattern_completed <= 2'b11;
     end
   end
  end

   always @(posedge clk_div_out) begin
   if (rst_sync_int6) begin
 
     data_in_to_device_int2 <= 0;
     data_in_to_device_int3 <= 0;
   end
   else begin
     data_in_to_device_int2 <= data_in_to_device;
     data_in_to_device_int3 <= data_in_to_device_int2;
   end
   end




  assign PATTERN_COMPLETED_OUT =  pattern_completed;


   BUFPLL
    #(.DIVIDE        (2))
    bufpll_inst
      (.IOCLK        (clk_in_int_buf),
       .LOCK         (locked_out),
       .SERDESSTROBE (serdesstrobe),
       .GCLK         (clk_div_in), // GCLK must be driven by BUFG
       .LOCKED       (locked_in),
       .PLLIN        (clk_in_pll1));





   assign clk_in_int_inv = ~clk_in_pll;
genvar pin_count;
  genvar slice_count;
  generate for (pin_count = 0; pin_count < sys_w; pin_count = pin_count + 1) begin: pins
    // Instantiate the buffers
    ////------------------------------
OBUFDS
      #(.IOSTANDARD ("LVDS_25"))
     obufds_inst
       (.O          (DATA_OUT_TO_PINS_P  [pin_count]),
        .OB         (DATA_OUT_TO_PINS_N  [pin_count]),
        .I          (data_out_to_pins_predelay[pin_count]));
// Instantiate the serdes primitive
     ////------------------------------
     // local wire only for use in this generate loop
     wire cascade_ms_d;
     wire cascade_ms_t;
     wire cascade_sm_d;
     wire cascade_sm_t;

     // declare the oserdes
     OSERDES2
       #(.DATA_RATE_OQ   ("SDR"),
         .DATA_RATE_OT   ("SDR"),
         .TRAIN_PATTERN  (0),
         .DATA_WIDTH     (num_serial_bits),
         .SERDES_MODE    ("NONE"),
         .OUTPUT_MODE    ("SINGLE_ENDED"))
      oserdes2_master
       (.D1         (oserdes_d[3][pin_count]),
        .D2         (oserdes_d[2][pin_count]),
        .D3         (oserdes_d[1][pin_count]),
        .D4         (oserdes_d[0][pin_count]),
        .T1         (1'b0),
        .T2         (1'b0),
        .T3         (1'b0),
        .T4         (1'b0),
        .SHIFTIN1   (1'b1),
        .SHIFTIN2   (1'b1),
        .SHIFTIN3   (1'b1),
        .SHIFTIN4   (1'b1),
        .SHIFTOUT1  (),
        .SHIFTOUT2  (),
        .SHIFTOUT3  (),
        .SHIFTOUT4  (),
        .TRAIN      (1'b0),
        .OCE        (clock_enable),
        .CLK0       (clk_in_int_buf),
        .CLK1       (1'b0),
        .CLKDIV     (clk_div_in),
        .OQ         (data_out_to_pins_predelay[pin_count]),
        .TQ         (),
        .IOCE       (serdesstrobe),
        .TCE        (clock_enable),
        .RST        (IO_RESET));



     // Concatenate the serdes outputs together. Keep the timesliced
     //   bits together, and placing the earliest bits on the right
     //   ie, if data comes in 0, 1, 2, 3, 4, 5, 6, 7, ...
     //       the output will be 3210, 7654, ...
     ////---------------------------------------------------------
     for (slice_count = 0; slice_count < num_serial_bits; slice_count = slice_count + 1) begin: out_slices
        // This places the first data in time on the right
        assign oserdes_d[4-slice_count-1] =
           data_out_from_device[slice_count];
        // To place the first data in time on the left, use the
        //   following code, instead
        // assign oserdes_d[slice_count] =
        //    data_out_from_device[slice_count];
     end
   
end
endgenerate


   BUFPLL
    #(.DIVIDE        (2))
    bufpll_inst_fwd
      (.IOCLK        (clk_in_int_buf_fwd),
       .LOCK         (locked_out),
       .SERDESSTROBE (serdesstrobe1),
       .GCLK         (clk_div_fwd), // GCLK must be driven by BUFG
       .LOCKED       (locked_in),
       .PLLIN        (clk_fwd_int));

      OSERDES2
       #(.DATA_RATE_OQ   ("SDR"),
         .DATA_RATE_OT   ("SDR"),
         .TRAIN_PATTERN  (0),
         .DATA_WIDTH     (4),
         .SERDES_MODE    ("NONE"),
         .OUTPUT_MODE    ("SINGLE_ENDED"))
      oserdes2_fwd
       (.D1         (1'b1),
        .D2         (1'b0),
        .D3         (1'b1),
        .D4         (1'b0),
        .T1         (1'b0),
        .T2         (1'b0),
        .T3         (1'b0),
        .T4         (1'b0),
        .SHIFTIN1   (1'b1),
        .SHIFTIN2   (1'b1),
        .SHIFTIN3   (1'b1),
        .SHIFTIN4   (1'b1),
        .SHIFTOUT1  (),
        .SHIFTOUT2  (),
        .SHIFTOUT3  (),
        .SHIFTOUT4  (),
        .TRAIN      (1'b0),
        .OCE        (locked_in),
        .CLK0       (clk_in_int_buf_fwd),
        .CLK1       (1'b0),
        .CLKDIV     (clk_div_fwd),
        .OQ         (clk_fwd_out),
        .TQ         (),
        .IOCE       (serdesstrobe1),
        .TCE        (clock_enable),
        .RST        (IO_RESET));

 // Clock Output Buffer
    OBUFDS
      #(.IOSTANDARD ("LVDS_25"))
     obufds_inst
       (.O          (CLK_TO_PINS_FWD_P),
        .OB         (CLK_TO_PINS_FWD_N),
        .I          (clk_fwd_out));
 
   // Instantiate the IO design
   series10 io_inst
    (
     // From the system into the device
     .DATA_IN_FROM_PINS_P     (DATA_IN_FROM_PINS_P),
     .DATA_IN_FROM_PINS_N     (DATA_IN_FROM_PINS_N),
     .DATA_IN_TO_DEVICE       (data_in_to_device),
     .CLK_IN_P                (CLK_IN_FWD_P),
     .CLK_IN_N                (CLK_IN_FWD_N),
     .CLK_DIV_OUT             (clk_div_out),
     .IO_RESET                (rst_sync_int));

endmodule
