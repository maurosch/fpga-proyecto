library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.perceptron_package.perceptron_input;


entity perceptron_matrix_test IS
end perceptron_matrix_test;

architecture behavior of perceptron_matrix_test is 
    constant MATRIX_COLUMNS : natural := 3;
    constant ROWS_PER_COLUMN : natural := 3;
    constant MATRIX_INPUTS : natural := 2;
    constant INPUT_WEIGHTS: natural := ROWS_PER_COLUMN * MATRIX_INPUTS;
    constant MIDDLE_WEIGHTS: natural := (MATRIX_COLUMNS-1) * (ROWS_PER_COLUMN * ROWS_PER_COLUMN);
    constant TOTAL_WEIGHTS: natural := INPUT_WEIGHTS + MIDDLE_WEIGHTS;
	-- Inputs
	signal pesos_i : perceptron_input(TOTAL_WEIGHTS downto 0);
	signal peso_0 : std_logic_vector(63 downto 0);
	signal peso_1 : std_logic_vector(63 downto 0);
	signal peso_2 : std_logic_vector(63 downto 0);
	signal peso_3 : std_logic_vector(63 downto 0);
	signal peso_4 : std_logic_vector(63 downto 0);
	signal peso_5 : std_logic_vector(63 downto 0);
	signal peso_6 : std_logic_vector(63 downto 0);
	signal peso_7 : std_logic_vector(63 downto 0);
	signal peso_8 : std_logic_vector(63 downto 0);
	signal peso_9 : std_logic_vector(63 downto 0);
	signal peso_10 : std_logic_vector(63 downto 0);
	signal peso_11 : std_logic_vector(63 downto 0);
	signal peso_12 : std_logic_vector(63 downto 0);
	signal peso_13 : std_logic_vector(63 downto 0);
	signal peso_14 : std_logic_vector(63 downto 0);

	signal inputs_i : perceptron_input(MATRIX_INPUTS-1 downto 0);
	signal input_0 : std_logic_vector(63 downto 0);
	signal input_1 : std_logic_vector(63 downto 0);
	signal clock_i : std_logic := '1';
    signal clr_i : std_logic := '1';
	signal enable_i : std_logic := '1';

	-- Ouputs
	signal outputs_o : perceptron_input(ROWS_PER_COLUMN-1 downto 0);
	signal output_0 : std_logic_vector(63 downto 0);
	signal output_1 : std_logic_vector(63 downto 0);
	signal output_2 : std_logic_vector(63 downto 0);

	-- Clock
	constant clock_period : time := 10 ms;

begin
	clock_process : process
	begin
		clock_i <= '0';
		wait for clock_period/2;
		clock_i <= '1';
		wait for clock_period/2;
	end process;

    peso_0 <= b"0000000000000000_0000000000000001_0000000000000000_0000000000000000"; -- 1
    peso_1 <= b"1111111111111111_1111111111111111_0000000000000000_0000000000000000"; -- -1
    peso_2 <= b"0000000000000000_0000000000000010_0000000000000000_0000000000000000"; -- 2
    peso_3 <= b"0000000000000000_0000000000000011_0000000000000000_0000000000000000"; -- 3
    peso_4 <= b"0000000000000000_0000000000000101_0000000000000000_0000000000000000"; -- 5
    peso_5 <= b"0000000000000000_0000000000000000_0000000000000000_0000000000000000"; -- 0
    peso_6 <= b"0000000000000000_0000000000000001_0000000000000000_0000000000000000"; -- 1
    peso_7 <= b"0000000000000000_0000000000000001_0000000000000000_0000000000000000"; -- 1
    peso_8 <= b"1111111111111111_1111111111111111_0000000000000000_0000000000000000"; -- -1
    peso_9 <= b"0000000000000000_0000000000000000_0000000000000000_0000000000000000"; -- 0
    peso_10 <= b"0000000000000000_0000000000000010_0000000000000000_0000000000000000"; -- 2
    peso_11 <= b"1111111111111111_1111111111111110_0000000000000000_0000000000000000"; -- -2
    peso_12 <= b"0000000000000000_0000000000000001_0000000000000000_0000000000000000"; -- 1
    peso_13 <= b"0000000000000000_0000000000000001_0000000000000000_0000000000000000"; -- 1
    peso_14 <= b"1111111111111111_1111111111111110_0000000000000000_0000000000000000"; -- -2

    pesos_i(0) <= peso_0;
    pesos_i(1) <= peso_1;
    pesos_i(2) <= peso_2;
    pesos_i(3) <= peso_3;
    pesos_i(4) <= peso_4;
    pesos_i(5) <= peso_5;
    pesos_i(6) <= peso_6;
    pesos_i(7) <= peso_7;
    pesos_i(8) <= peso_8;
    pesos_i(9) <= peso_9;
    pesos_i(10) <= peso_10;
    pesos_i(11) <= peso_11;
    pesos_i(12) <= peso_12;
    pesos_i(13) <= peso_13;
    pesos_i(14) <= peso_14;

    input_0 <= b"0000000000000000_0000000000000011_0000000000000000_0000000000000000"; -- 3
    input_1 <= b"0000000000000000_0000000000000101_0000000000000000_0000000000000000"; -- 5

    inputs_i(0) <= input_0;
    inputs_i(1) <= input_1;

	clr_i <= '1', '0' after 200 ms;
	enable_i <= '0', '1' after 300 ms;

	uut1 : entity work.perceptron_matrix
    generic map(
        COLUMNS => MATRIX_COLUMNS,
        ROWS_PER_COLUMN => ROWS_PER_COLUMN,
        MATRIX_INPUTS => MATRIX_INPUTS,
        WEIGHTS_IN => INPUT_WEIGHTS,
        WEIGHTS => MIDDLE_WEIGHTS
    )
	port map (clock_i => clock_i,
		  clr_i => clr_i,
		  enable_i => enable_i,
		  pesos_in_i => pesos_i(INPUT_WEIGHTS-1 downto 0),
		  pesos_i => pesos_i((MIDDLE_WEIGHTS+INPUT_WEIGHTS)-1 downto INPUT_WEIGHTS),
		  inputs_i => inputs_i,
		  outputs_o => outputs_o
		  );
    output_0 <= outputs_o(0);
    output_1 <= outputs_o(1);
    output_2 <= outputs_o(2);
end architecture;
