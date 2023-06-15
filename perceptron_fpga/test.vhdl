library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity perceptron_test IS
end perceptron_test;

architecture behavior of perceptron_test is 
	-- Inputs
	signal peso_i : std_logic_vector(63 downto 0);
	signal input : std_logic_vector(63 downto 0);
	signal clock_i : std_logic := '1';
    signal clr_i : std_logic := '1';
	signal enable_i : std_logic := '1';

	-- Ouputs
	signal output : std_logic_vector(127 downto 0);

	-- Clock
	constant clock_period : time := 50 ms;

begin
	clock_process : process
	begin
		clock_i <= '0';
		wait for clock_period/2;
		clock_i <= '1';
		wait for clock_period/2;
	end process;

    peso_i <= std_logic_vector(to_signed(-2, 64));
    input <= std_logic_vector(to_signed(2, 64));

	clr_i <= '1', '0' after 200 ms;
	enable_i <= '0', '1' after 300 ms;

	uut : entity work.perceptron
	port map (clock_i => clock_i,
		  clr_i => clr_i,
		  peso_i => peso_i,
		  input => input,
		  enable_i => enable_i,
		  output => output
		  );
end architecture;
