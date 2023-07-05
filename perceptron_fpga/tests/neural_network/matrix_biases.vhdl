
-- ARCHIVO AUTOGENERADO CON generate_weights_package.py

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.perceptron_package.perceptron_input;

package matrix_biases is
    function GetBiases(Dummy: natural)
    return perceptron_input;
end package matrix_biases;

package body matrix_biases is
    function GetBiases(Dummy: natural) return perceptron_input is
        variable pesos_i : perceptron_input(6 downto 0);
    begin
	pesos_i(0) := b"0000000000000000_0000000000000000_1000000000000000_0000000000000000"; -- 0.5
	pesos_i(1) := b"1111111111111111_1111111111111111_1110011001100110_0110011001100110"; -- -0.1
	pesos_i(2) := b"1111111111111111_1111111111111111_1011001100110011_0011001100110011"; -- -0.3
	pesos_i(3) := b"0000000000000000_0000000000000000_0011001100110011_0011001100110011"; -- 0.2
	pesos_i(4) := b"0000000000000000_0000000000000000_0000110011001100_1100110011001101"; -- 0.05
	pesos_i(5) := b"1111111111111111_1111111111111111_1111110111110011_1011011001000110"; -- -0.008
	pesos_i(6) := b"0000000000000000_0000000000000000_1000000000000000_0000000000000000"; -- 0.5

    return pesos_i;
    end function;
end package body matrix_biases;
    