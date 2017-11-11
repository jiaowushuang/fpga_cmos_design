`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:32:23 09/10/2017 
// Design Name: 
// Module Name:    digital_filter 
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
module digital_filter(
							clk_in,
							key_in,
							key_out);
							
		input  clk_in ;
		input  key_in ;
		output key_out;
		reg    key_out;
		
		reg [8:0]counter;
		
		reg flag1;
		reg flag2;
		reg flag3;
		
		
		always @ ( posedge clk_in ) 
			begin
				if ( flag3 )
					begin
						if ( counter[8] )
							begin
								if ( key_in == 0 )
									key_out <= 1 ;
								else
									begin
										flag1   <= 0 ;
										flag2   <= 0 ;
										flag3   <= 0 ;
										counter <= 0 ;
										key_out <= 0 ;
									end
							end
						else
							if ( key_in == 0 )
								begin
									counter <= counter + 1 ;
								end
							else
								begin
									flag1   <= 0 ;
									flag2   <= 0 ;
									flag3   <= 0 ;
									counter <= 0 ;
									key_out <= 0 ;
								end
					end
				else
					if ( flag2 )
						begin
							if ( counter[8] )
								begin
									flag3   <= 1 ;
									counter <= 0 ;
								end
							else
								if ( key_in == 0 )
									begin
										counter <= counter + 1 ;
									end
								else
									begin
										flag1   <= 0 ;
										flag2   <= 0 ;
										flag3   <= 0 ;
										counter <= 0 ;
										key_out <= 0 ;
									end
						end
					else
						if ( flag1 )
							begin
								if ( counter[8] )
									begin
										flag2 <= 1 ;
										counter <= 0;
									end
								else
									if ( key_in == 0 )
										begin
											counter <= counter + 1 ;
										end
									else
										begin
											flag1   <= 0 ;
											flag2   <= 0 ;
											flag3   <= 0 ;
											counter <= 0 ;
											key_out <= 0 ;
										end
							end
						else
							if ( key_in == 0 )
							begin
								if ( counter[8] )
									begin
										flag1 <= 1 ;
										counter <= 0 ;
									end
								else
									if ( key_in == 0 )
										begin
											counter <= counter + 1 ;
										end
									else
										begin
											flag1   <= 0 ;
											flag2   <= 0 ;
											flag3   <= 0 ;
											counter <= 0 ;
											key_out <= 0 ;
										end
							end
			end
							


endmodule
