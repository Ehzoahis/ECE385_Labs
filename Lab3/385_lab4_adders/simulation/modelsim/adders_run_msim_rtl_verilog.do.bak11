transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab3/385_lab4_adders {C:/Users/ENIAC/Desktop/ECE385/Lab3/385_lab4_adders/router.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab3/385_lab4_adders {C:/Users/ENIAC/Desktop/ECE385/Lab3/385_lab4_adders/reg_17.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab3/385_lab4_adders {C:/Users/ENIAC/Desktop/ECE385/Lab3/385_lab4_adders/lookahead_adder.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab3/385_lab4_adders {C:/Users/ENIAC/Desktop/ECE385/Lab3/385_lab4_adders/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab3/385_lab4_adders {C:/Users/ENIAC/Desktop/ECE385/Lab3/385_lab4_adders/control.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab3/385_lab4_adders {C:/Users/ENIAC/Desktop/ECE385/Lab3/385_lab4_adders/adder_units.sv}
vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab3/385_lab4_adders {C:/Users/ENIAC/Desktop/ECE385/Lab3/385_lab4_adders/adder2.sv}

vlog -sv -work work +incdir+C:/Users/ENIAC/Desktop/ECE385/Lab3/385_lab4_adders {C:/Users/ENIAC/Desktop/ECE385/Lab3/385_lab4_adders/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
