ghdl -a perceptron_fpga/*.vhdl
ghdl -e perceptron_test
ghdl -r perceptron_test --vcd=out/out.vcd
