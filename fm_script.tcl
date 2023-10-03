


set synopsys_auto_setup true

set_svf "UART_TX.svf"

############################## Formality Setup File ##############################

set SSLIB "/home/IC/Labs/Ass_Syn_2.0/std_cells/scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "/home/IC/Labs/Ass_Syn_2.0/std_cells/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "/home/IC/Labs/Ass_Syn_2.0/std_cells/scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

## Read Reference Design Files
read_verilog -container Ref "/home/IC/Labs/Ass_Syn_2.0/rtl/UART_TX.v"
read_verilog -container Ref "/home/IC/Labs/Ass_Syn_2.0/rtl/MY_FSM.v"
read_verilog -container Ref "/home/IC/Labs/Ass_Syn_2.0/rtl/MY_MUX.v"
read_verilog -container Ref "/home/IC/Labs/Ass_Syn_2.0/rtl/MY_PAR.v"
read_verilog -container Ref "/home/IC/Labs/Ass_Syn_2.0/rtl/MY_serializer.v"

#loading libraries
read_db -container Ref "/home/IC/Labs/Ass_Syn_2.0/std_cells/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"

## set the top Reference Design (module name)
set_reference_design UART_TX
set_top UART_TX





## Read Implementation Design Files
read_verilog -netlist -container Imp "/home/IC/Labs/Ass_Syn_2.0/syn/UART_TX.v"

## Read Implementation technology libraries
read_db -container Imp "/home/IC/Labs/Ass_Syn_2.0/std_cells/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"

## set the top Implementation Design
set_implementation_design UART_TX
set_top UART_TX



## matching Compare points
match


## verify
set successful [verify]
if {!$successful} {
diagnose
analyze_points -failing
}

#Reports
report_passing_points > "passing_points.rpt"
report_failing_points > "failing_points.rpt"
report_aborted_points > "aborted_points.rpt"
report_unverified_points > "unverified_points.rpt"


start_gui

