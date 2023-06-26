library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.perceptron_package.perceptron_input;

package matrix_weights is
    function GetWeights(Dummy: natural)
    return perceptron_input;
end package matrix_weights;

package body matrix_weights is
    function GetWeights(Dummy: natural) return perceptron_input is
        variable peso_0 : std_logic_vector(63 downto 0);
        variable peso_1 : std_logic_vector(63 downto 0);
        variable peso_2 : std_logic_vector(63 downto 0);
        variable peso_3 : std_logic_vector(63 downto 0);
        variable peso_4 : std_logic_vector(63 downto 0);
        variable peso_5 : std_logic_vector(63 downto 0);
        variable peso_6 : std_logic_vector(63 downto 0);
        variable peso_7 : std_logic_vector(63 downto 0);
        variable peso_8 : std_logic_vector(63 downto 0);
        variable peso_9 : std_logic_vector(63 downto 0);
        variable peso_10 : std_logic_vector(63 downto 0);
        variable peso_11 : std_logic_vector(63 downto 0);
        variable peso_12 : std_logic_vector(63 downto 0);
        variable peso_13 : std_logic_vector(63 downto 0);
        variable peso_14 : std_logic_vector(63 downto 0);
        variable pesos_i : perceptron_input(14 downto 0);
    begin
    peso_0 := b"0000000000000000_0000000000000001_0000000000000000_0000000000000000"; -- 1
    peso_1 := b"1111111111111111_1111111111111111_0000000000000000_0000000000000000"; -- -1
    peso_2 := b"0000000000000000_0000000000000010_0000000000000000_0000000000000000"; -- 2
    peso_3 := b"0000000000000000_0000000000000011_0000000000000000_0000000000000000"; -- 3
    peso_4 := b"0000000000000000_0000000000000101_0000000000000000_0000000000000000"; -- 5
    peso_5 := b"0000000000000000_0000000000000000_0000000000000000_0000000000000000"; -- 0
    peso_6 := b"0000000000000000_0000000000000001_0000000000000000_0000000000000000"; -- 1
    peso_7 := b"0000000000000000_0000000000000001_0000000000000000_0000000000000000"; -- 1
    peso_8 := b"1111111111111111_1111111111111111_0000000000000000_0000000000000000"; -- -1
    peso_9 := b"0000000000000000_0000000000000000_0000000000000000_0000000000000000"; -- 0
    peso_10 := b"0000000000000000_0000000000000010_0000000000000000_0000000000000000"; -- 2
    peso_11 := b"1111111111111111_1111111111111110_0000000000000000_0000000000000000"; -- -2
    peso_12 := b"0000000000000000_0000000000000001_0000000000000000_0000000000000000"; -- 1
    peso_13 := b"0000000000000000_0000000000000001_0000000000000000_0000000000000000"; -- 1
    peso_14 := b"1111111111111111_1111111111111110_0000000000000000_0000000000000000"; -- -2

    pesos_i(0) := peso_0;
    pesos_i(1) := peso_1;
    pesos_i(2) := peso_2;
    pesos_i(3) := peso_3;
    pesos_i(4) := peso_4;
    pesos_i(5) := peso_5;
    pesos_i(6) := peso_6;
    pesos_i(7) := peso_7;
    pesos_i(8) := peso_8;
    pesos_i(9) := peso_9;
    pesos_i(10) := peso_10;
    pesos_i(11) := peso_11;
    pesos_i(12) := peso_12;
    pesos_i(13) := peso_13;
    pesos_i(14) := peso_14;

    return pesos_i;
    end function;


end package body matrix_weights;
