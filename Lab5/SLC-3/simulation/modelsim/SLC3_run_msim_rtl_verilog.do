transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab5 {C:/Users/ENIAC/Desktop/ECE385/Lab5/test_memory.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab5 {C:/Users/ENIAC/Desktop/ECE385/Lab5/synchronizers.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab5 {C:/Users/ENIAC/Desktop/ECE385/Lab5/SLC3_2.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab5 {C:/Users/ENIAC/Desktop/ECE385/Lab5/Mem2IO.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab5 {C:/Users/ENIAC/Desktop/ECE385/Lab5/ISDU.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab5 {C:/Users/ENIAC/Desktop/ECE385/Lab5/RegUnit.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab5 {C:/Users/ENIAC/Desktop/ECE385/Lab5/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab5 {C:/Users/ENIAC/Desktop/ECE385/Lab5/Decoder.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab5 {C:/Users/ENIAC/Desktop/ECE385/Lab5/ALU_Unit.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab5 {C:/Users/ENIAC/Desktop/ECE385/Lab5/LED_unit.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab5 {C:/Users/ENIAC/Desktop/ECE385/Lab5/memory_contents.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab5 {C:/Users/ENIAC/Desktop/ECE385/Lab5/PC_Unit.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab5 {C:/Users/ENIAC/Desktop/ECE385/Lab5/MAR_Unit.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab5 {C:/Users/ENIAC/Desktop/ECE385/Lab5/MDR_Unit.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab5 {C:/Users/ENIAC/Desktop/ECE385/Lab5/IR_Unit.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab5 {C:/Users/ENIAC/Desktop/ECE385/Lab5/RegFile.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab5 {C:/Users/ENIAC/Desktop/ECE385/Lab5/BEN_Unit.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab5 {C:/Users/ENIAC/Desktop/ECE385/Lab5/datapath.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab5 {C:/Users/ENIAC/Desktop/ECE385/Lab5/slc3.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab5 {C:/Users/ENIAC/Desktop/ECE385/Lab5/slc3_testtop.sv}

vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab5 {C:/Users/ENIAC/Desktop/ECE385/Lab5/testbench_slc3.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  testbench_slc3

add wave *
view structure
view signals
run -all
