gui_open_window Wave
gui_sg_create image_core_pll_group
gui_list_add_group -id Wave.1 {image_core_pll_group}
gui_sg_addsignal -group image_core_pll_group {image_core_pll_tb.test_phase}
gui_set_radix -radix {ascii} -signals {image_core_pll_tb.test_phase}
gui_sg_addsignal -group image_core_pll_group {{Input_clocks}} -divider
gui_sg_addsignal -group image_core_pll_group {image_core_pll_tb.CLK_IN1}
gui_sg_addsignal -group image_core_pll_group {{Output_clocks}} -divider
gui_sg_addsignal -group image_core_pll_group {image_core_pll_tb.dut.clk}
gui_list_expand -id Wave.1 image_core_pll_tb.dut.clk
gui_sg_addsignal -group image_core_pll_group {{Counters}} -divider
gui_sg_addsignal -group image_core_pll_group {image_core_pll_tb.COUNT}
gui_sg_addsignal -group image_core_pll_group {image_core_pll_tb.dut.counter}
gui_list_expand -id Wave.1 image_core_pll_tb.dut.counter
gui_zoom -window Wave.1 -full
