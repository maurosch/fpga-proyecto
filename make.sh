set -x
ghdl -a perceptron_fpga/*.vhdl
ghdl -e perceptron_test
timeout 1 ghdl -r perceptron_test --vcd=out/out.vcd