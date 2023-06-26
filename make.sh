set -xe
ghdl -a perceptron_fpga/perceptron.vhdl \
        perceptron_fpga/perceptron_row.vhdl \
        perceptron_fpga/perceptron_matrix.vhdl \
        perceptron_fpga/test.vhdl \
        perceptron_fpga/three_nodes_test.vhdl \
        perceptron_fpga/perceptron_row_test.vhdl \
        perceptron_fpga/matrix_weights.vhdl \
        perceptron_fpga/perceptron_matrix_test.vhdl

ghdl -e perceptron_test
ghdl -e three_nodes_test
ghdl -e perceptron_row_test
ghdl -e perceptron_matrix_test
timeout 1 ghdl -r perceptron_test --vcd=out/out_test.vcd || true
timeout 1 ghdl -r three_nodes_test --vcd=out/out_three_nodes.vcd || true
timeout 1 ghdl -r perceptron_row_test --vcd=out/perceptron_row_test.vcd || true
timeout 1 ghdl -r perceptron_matrix_test --vcd=out/perceptron_matrix_test.vcd || true
