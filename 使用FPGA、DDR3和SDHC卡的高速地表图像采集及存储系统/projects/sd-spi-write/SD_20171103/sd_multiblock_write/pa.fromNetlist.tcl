
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name sd_multiblock_write -dir "D:/work/ADC Snap/SD/SD_PROJECT/SD_2017110022226/sd_multiblock_write/planAhead_run_2" -part xc6slx45lcsg324-1L
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/work/ADC Snap/SD/SD_PROJECT/SD_2017110022226/sd_multiblock_write/sd_test.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/work/ADC Snap/SD/SD_PROJECT/SD_2017110022226/sd_multiblock_write} }
set_property target_constrs_file "D:/work/ADC Snap/SD/SD_PROJECT/SD_2017110022226/rtl/sd_test.ucf" [current_fileset -constrset]
add_files [list {D:/work/ADC Snap/SD/SD_PROJECT/SD_2017110022226/rtl/sd_test.ucf}] -fileset [get_property constrset [current_run]]
link_design
