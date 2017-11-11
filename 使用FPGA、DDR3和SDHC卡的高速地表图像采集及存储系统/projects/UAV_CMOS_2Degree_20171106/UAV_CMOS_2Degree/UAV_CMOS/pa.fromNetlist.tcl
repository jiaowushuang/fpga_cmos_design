
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name UAV_CMOS -dir "D:/03_FPGA_Project/01_UAV_CMOS/02_FPGA/UAV_CMOS/UAV_CMOS/planAhead_run_1" -part xc6slx45lcsg324-1L
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/03_FPGA_Project/01_UAV_CMOS/02_FPGA/UAV_CMOS/UAV_CMOS/main_cs.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/03_FPGA_Project/01_UAV_CMOS/02_FPGA/UAV_CMOS/UAV_CMOS} {ipcore_dir} }
add_files [list {ipcore_dir/cmos_command_fifo.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/cmos_configuration_ram.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/image_data.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/parameter_fd_fifo.ncf}] -fileset [get_property constrset [current_run]]
set_param project.pinAheadLayout  yes
set_property target_constrs_file "UAV_CMOS.ucf" [current_fileset -constrset]
add_files [list {UAV_CMOS.ucf}] -fileset [get_property constrset [current_run]]
link_design
