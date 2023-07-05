set -xe
ghdl -a perceptron_fpga/src/neural_network/perceptron_input.vhdl \
        perceptron_fpga/src/neural_network/perceptron.vhdl \
        perceptron_fpga/src/neural_network/perceptron_row.vhdl \
        perceptron_fpga/src/neural_network/perceptron_matrix.vhdl \
        perceptron_fpga/tests/mnist_model/mnist_weights.vhdl \
        perceptron_fpga/tests/mnist_model/mnist_biases.vhdl \
        perceptron_fpga/tests/mnist_model/mnist_inputs.vhdl \
        perceptron_fpga/tests/mnist_model/mnist_model_test.vhdl

# ghdl -e perceptron_test
# ghdl -e perceptron_row_test
# ghdl -e perceptron_matrix_test
ghdl -e mnist_model_test

# timeout 1 ghdl -r perceptron_test --vcd=out/perceptron_test.vcd || true
# timeout 1 ghdl -r perceptron_row_test --vcd=out/perceptron_row_test.vcd || true
# timeout 1 ghdl -r perceptron_matrix_test --vcd=out/perceptron_matrix_test.vcd || true
timeout 300 ghdl -r mnist_model_test --vcd=out/mnist_model_test.vcd || true
