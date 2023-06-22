library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.my_package.all;


entity perceptron_test IS
end perceptron_test;

architecture behavior of perceptron_test is 
	-- Inputs
	signal peso_1 : perceptron_input(0 downto 0);
	signal peso_2 : perceptron_input(0 downto 0);
	signal peso_1_v : std_logic_vector(63 downto 0);
	signal peso_2_v : std_logic_vector(63 downto 0);

	signal output_1 : std_logic_vector(63 downto 0);
	signal input_v : std_logic_vector(63 downto 0);
	signal input_in : perceptron_input(0 downto 0);
	signal input_in2 : perceptron_input(0 downto 0);
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

    peso_1_v <= std_logic_vector(to_signed(2, 64));
    peso_1(0) <= peso_1_v;
    peso_2_v <= std_logic_vector(to_signed(3, 64));
    peso_2(0) <= peso_2_v;

    input_v <= std_logic_vector(to_signed(4, 64));
    input_in(0) <= input_v;

	clr_i <= '1', '0' after 200 ms;
	enable_i <= '0', '1' after 300 ms;

	uut1 : entity work.perceptron
	port map (clock_i => clock_i,
		  clr_i => clr_i,
		  peso_i => peso_1,
		  input_i => input_in,
		  enable_i => enable_i,
		  output_o => output_1
		  );

	input_in2(0) <= output_1;

	uut2 : entity work.perceptron
	port map (clock_i => clock_i,
		  clr_i => clr_i,
		  peso_i => peso_2,
		  input_i => input_in2,
		  enable_i => enable_i,
		  output_o => output_o
		  );
end architecture;
