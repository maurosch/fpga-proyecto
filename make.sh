set -xe
ghdl -a perceptron_fpga/*.vhdl
ghdl -e perceptron_test
ghdl -e three_nodes_test
timeout 1 ghdl -r perceptron_test --vcd=out/out_test.vcd || true
timeout 1 ghdl -r three_nodes_test --vcd=out/out_three_nodes.vcd || true
