onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /usb_controller_test/usb_clk
add wave -noupdate /usb_controller_test/USB_FlagA
add wave -noupdate /usb_controller_test/USB_FlagB
add wave -noupdate /usb_controller_test/USB_FlagC
add wave -noupdate /usb_controller_test/USB_FlagD
add wave -noupdate /usb_controller_test/nframe
add wave -noupdate -radix hexadecimal /usb_controller_test/uut/main_state
add wave -noupdate -radix hexadecimal /usb_controller_test/uut/next_state
add wave -noupdate -radix hexadecimal /usb_controller_test/uut/current_state
add wave -noupdate /usb_controller_test/uut/frame_flag
add wave -noupdate /usb_controller_test/uut/image_data
add wave -noupdate /usb_controller_test/uut/fifo_image_en
add wave -noupdate /usb_controller_test/uut/parameter_data
add wave -noupdate /usb_controller_test/uut/fifo_parameter_en
add wave -noupdate /usb_controller_test/uut/receive_data
add wave -noupdate /usb_controller_test/uut/receive_data_en
add wave -noupdate /usb_controller_test/uut/USB_SLWR
add wave -noupdate /usb_controller_test/uut/USB_SLRD
add wave -noupdate /usb_controller_test/uut/USB_SLOE
add wave -noupdate /usb_controller_test/uut/USB_FIFO_ADR
add wave -noupdate -radix unsigned /usb_controller_test/uut/counter
add wave -noupdate /usb_controller_test/uut/flag_counter
add wave -noupdate /usb_controller_test/uut/direction_flag
add wave -noupdate /usb_controller_test/uut/fifo_parameter_en_flag
add wave -noupdate /usb_controller_test/uut/fifo_image_en_flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {206997 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 260
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {183750 ps} {236250 ps}
