
########################### Define Top Module ############################
                                                   
set top_module UART_TX

##################### Define Working Library Directory ######################
                                                   
define_design_lib work -path ./work

set_svf $top_module.svf

################## Design Compiler Library Files #setup ######################

lappend search_path /home/IC/Labs/Ass_Syn_2.0/std_cells
lappend search_path /home/IC/Labs/Ass_Syn_2.0/rtl

set SSLIB "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

## Standard Cell libraries 
set target_library [list $SSLIB $TTLIB $FFLIB]

## Standard Cell & Hard Macros libraries 
set link_library [list * $SSLIB $TTLIB $FFLIB]  

#echo "###############################################"
#echo "############# Reading RTL Files  ##############"
#echo "###############################################"

#UART_TX Files
set file_format verilog

read_file -format $file_format UART_TX.v
read_file -format $file_format MY_MUX.v
read_file -format $file_format MY_PAR.v
read_file -format $file_format MY_serializer.v
read_file -format $file_format MY_FSM.v

###################### Defining toplevel ###################################

current_design $top_module

#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## Liniking All The Design Parts ########"
puts "###############################################"

link 

#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## checking design consistency ##########"
puts "###############################################"

check_design

############################### Path groups ################################
puts "###############################################"
puts "################ Path groups ##################"
puts "###############################################"

#group_path -name INREG -from [P_DATA DATA_VALID PAR_EN PAR_TYP CLK RST]
#group_path -name REGOUT -to [TX_OUT Busy]
#group_path -name INOUT -from [P_DATA DATA_VALID PAR_EN PAR_TYP CLK RST] -to [TX_OUT Busy]

#################### Define Design Constraints #########################
puts "###############################################"
puts "############ Design Constraints #### ##########"
puts "###############################################"

source -echo ./cons.tcl

###################### Mapping and optimization ########################
puts "###############################################"
puts "########## Mapping & Optimization #############"
puts "###############################################"

compile -map_effort high

#############################################################################
# Write out Design after initial compile
#############################################################################

write_file -format verilog -hierarchy -output UART_TX.v
write_file -format ddc -hierarchy -output UART_TX.ddc
write_sdc UART_TX.sdc
write_sdf UART_TX.sdf

set_svf -off
################# reporting #######################
report_area -hierarchy > area_report.rpt
report_power -hierarchy > power_report.rpt
report_timing -max_paths 100 -delay_type max > setup_report.rpt
report_timing -max_paths 100 -delay_type min > hold_report.rpt
report_clock -attributes > CLK.rpt
report_constraint -all_violators > constraint.rpt


################# starting graphical user interface #######################

#gui_start
