library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.perceptron_package.perceptron_input;


entity three_nodes_test IS
end three_nodes_test;

architecture behavior of three_nodes_test is 
     constant N : natural := 2;
	-- Inputs
    signal pesos_i : perceptron_input(5 downto 0); -- 6 pesos
	signal peso_0_v : std_logic_vector(63 downto 0);
	signal peso_1_v : std_logic_vector(63 downto 0);
	signal peso_2_v : std_logic_vector(63 downto 0);
	signal peso_3_v : std_logic_vector(63 downto 0);
	signal peso_4_v : std_logic_vector(63 downto 0);
	signal peso_5_v : std_logic_vector(63 downto 0);

	signal output_1 : std_logic_vector(63 downto 0);
	signal output_2 : std_logic_vector(63 downto 0);
	signal inputs_i : perceptron_input(1 downto 0);
	signal input_0_v : std_logic_vector(63 downto 0);
	signal input_1_v : std_logic_vector(63 downto 0);
	signal clock_i : std_logic := '1';
    signal clr_i : std_logic := '1';
	signal enable_i : std_logic := '1';

    signal second_layer_input : perceptron_input(1 downto 0);

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

    peso_0_v <= b"0000000000000000_0000000000000001_0000000000000000_0000000000000000"; -- 1
    peso_1_v <= b"0000000000000000_0000000000000000_0000000000000000_0000000000000000"; -- 0
    peso_2_v <= b"0000000000000000_0000000000000010_0000000000000000_0000000000000000"; -- 2
    peso_3_v <= b"0000000000000000_0000000000000011_0000000000000000_0000000000000000"; -- 3
    peso_4_v <= b"0000000000000000_0000000001100100_0000000000000000_0000000000000000"; -- 100
    peso_5_v <= b"0000000000000000_0000000000101010_0000000000000000_0000000000000000"; -- 42

    pesos_i(0) <= peso_0_v;
    pesos_i(1) <= peso_1_v;
    pesos_i(2) <= peso_2_v;
    pesos_i(3) <= peso_3_v;
    pesos_i(4) <= peso_4_v;
    pesos_i(5) <= peso_5_v;

    input_0_v <= b"0000000000000000_0000000000000010_0000000000000000_0000000000000000"; -- 2
    input_1_v <= b"1111111111111111_1111111111111111_0000000000000000_0000000000000000"; -- -1

    inputs_i(0) <= input_0_v;
    inputs_i(1) <= input_1_v;

	clr_i <= '1', '0' after 200 ms;
	enable_i <= '0', '1' after 300 ms;

	uut1 : entity work.perceptron
    generic map(N => N)
	port map (clock_i => clock_i,
		  clr_i => clr_i,
		  peso_i => pesos_i(1 downto 0),
		  input_i => inputs_i,
		  enable_i => enable_i,
		  output_o => output_1
		  );


	uut2 : entity work.perceptron
    generic map(N => N)
	port map (clock_i => clock_i,
		  clr_i => clr_i,
		  peso_i => pesos_i(3 downto 2),
		  input_i => inputs_i,
		  enable_i => enable_i,
		  output_o => output_2
		  );


    second_layer_input <= output_2 & output_1;

	uut3 : entity work.perceptron
    generic map(N => N)
	port map (clock_i => clock_i,
		  clr_i => clr_i,
		  peso_i => pesos_i(5 downto 4),
		  input_i => second_layer_input,
		  enable_i => enable_i,
		  output_o => output_o
		  );

end architecture;
