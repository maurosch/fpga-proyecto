
-- ARCHIVO AUTOGENERADO CON generate_weights_package.py

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.perceptron_package.perceptron_input;

package matrix_inputs is
    function GetInputs(Dummy: natural)
    return perceptron_input;
end package matrix_inputs;

package body matrix_inputs is
    function GetInputs(Dummy: natural) return perceptron_input is
        variable pesos_i : perceptron_input(1 downto 0);
    begin
	pesos_i(0) := b"0000000000000000_0000000000000000_0001100110011001_1001100110011010"; -- 0.1
	pesos_i(1) := b"0000000000000000_0000000000000000_0011001100110011_0011001100110011"; -- 0.2

    return pesos_i;
    end function;
end package body matrix_inputs;
    