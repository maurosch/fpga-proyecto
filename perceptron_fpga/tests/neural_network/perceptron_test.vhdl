library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.perceptron_package.perceptron_input;


entity perceptron_test IS
end perceptron_test;

architecture behavior of perceptron_test is 
    constant TOTAL_INPUTS : natural := 2;
	-- Inputs
	signal input_i : perceptron_input(TOTAL_INPUTS-1 downto 0);
	signal pesos_i : perceptron_input(TOTAL_INPUTS-1 downto 0);
    signal bias_i : std_logic_vector(63 downto 0);

	signal clock_i : std_logic := '1';
    signal clr_i : std_logic := '1';
	signal enable_i : std_logic := '1';

	-- Ouputs
	signal output_o : std_logic_vector(63 downto 0);

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

    pesos_i(0) <= b"0000000000000000_0000000000000000_0001100110011001_1001100110011010"; -- 0.1
    pesos_i(1) <= b"1111111111111111_1111111111111111_1110011001100110_0110011001100110"; -- -0.1

    input_i(0) <= b"0000000000000000_0000000000000000_0001100110011001_1001100110011010"; -- 0.1
    input_i(1) <= b"0000000000000000_0000000000000000_0000010100011110_1011100001010010"; -- 0.02

    bias_i <= b"0000000000000000_0000000000000001_0001100110011001_1001100110011010"; -- 1.1
 

	clr_i <= '1', '0' after 200 ms;
	enable_i <= '0', '1' after 300 ms;

	uut1 : entity work.perceptron
    generic map(N => TOTAL_INPUTS)
	port map (clock_i => clock_i,
		  clr_i => clr_i,
		  peso_i => pesos_i,
		  input_i => input_i,
          bias_i => bias_i,
		  enable_i => enable_i,
		  output_o => output_o
		  );
end architecture;
