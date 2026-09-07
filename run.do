vlib work
vlog -f filelist.f
vsim -voptargs=+acc -L mtiUvm work.testbench -classdebug -uvmcontrol=all +UVM_TESTNAME=cfs_algn_test_random_rx_err -cover -l sim.log -sv_seed random -f messages.f
add wave sim:/testbench/md_rx_if/*
add wave sim:/testbench/md_tx_if/*
run -all