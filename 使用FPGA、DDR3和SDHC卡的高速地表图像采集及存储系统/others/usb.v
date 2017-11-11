module usb_controller(
								usb_clk,
								USB_DATA,
								data_in,
                                data_pulse,
                                nframe,
                                send_out
					);
			input  usb_clk ;
			output USB_DATA;
			input  [15:0]data_in   ;
			output data_pulse      ;
			input  nframe    ;
			input  send_out   ;
			
			reg [15:0]USB_DATA   ;
			reg data_pulse       ;
			
			reg [9:0]counter     ;
			reg flag_counter     ;
			
			
			reg [3:0]main_state = power_up  ;
		
			parameter 
				power_up = 4'b0000 ,
				usb_idle = 4'b0001 ,
				usb_EP6  = 4'b0010 ,
				usb_send = 4'b0011 ,
				usb_delay1= 4'b0100 ,
				usb_delay2= 4'b0101 ;


			always @ ( posedge nframe or posedge usb_clk )
				begin
					if ( nframe == 1 )
						begin
							counter <= 0 ;
						end
					else
						if ( flag_counter )
							begin
								counter <= counter + 1 ;
							end
						else
							begin
								counter <= 0 ;
							end
				end
			
			always @ ( posedge nframe or posedge usb_clk )
				begin
					if ( nframe )
						begin
							main_state   <= power_up ;
							flag_counter <= 0      ;
							data_pulse   <= 0       ;	
						end
					else
						begin
							case ( main_state )
								power_up :
									begin
										main_state   <= power_up ;
										flag_counter <= 0        ;
										data_pulse   <= 0       ;	
									end
								usb_idle : 
									begin
										flag_counter <= 0       ;
										data_pulse   <= 0       ;	
										 if ( send_out )
											main_state <= usb_send      ;
									end
								usb_send :
									begin
										
												main_state <= usb_delay1    ;
												flag_counter <= 0          ;
												data_pulse   <= 1          ;												
											
									end
								usb_delay1 :
									begin
										main_state <= usb_delay2      ;
										flag_counter <= 0          ;
									end
								usb_delay2 :
									begin
										main_state <= usb_EP6      ;
										flag_counter <= 1          ;
									end
								usb_EP6  :
									begin
										USB_DATA    <= data_in  ;
										if ( counter == 256 )
											begin
												main_state   <= usb_idle ;	
											end
										else
											if ( counter == 253 )
												begin
													data_pulse   <= 0     ;
												end
											else
												begin
												 //写到SD卡
												end
									end
								default  :
									begin
										flag_counter <= 0        ;
										main_state   <= power_up ;
										USB_DATA     <= 0        ;
									end
							endcase
						end
				end

endmodule
