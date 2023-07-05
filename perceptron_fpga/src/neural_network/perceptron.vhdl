library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.perceptron_package.perceptron_input;

entity perceptron is
generic (
    N: natural := 1 -- cantidad de entradas del perceptron
);
port (
    peso_i : in perceptron_input(N-1 downto 0);
    input_i : in perceptron_input(N-1 downto 0);
    bias_i : in std_logic_vector(63 downto 0);
	clock_i : in std_logic;
	clr_i : in std_logic;
	enable_i : in std_logic;
    output_o : out std_logic_vector(63 downto 0)
);
end entity;

architecture logic of perceptron is 
begin
	PERCEPTRON_PROC: process(clock_i, enable_i)
	variable vacc : signed(63 downto 0) := to_signed(0, 64);
    variable aux : signed(127 downto 0) := to_signed(0, 128);
    constant DECIMALS : natural := 32;
    begin
        
		if rising_edge(clock_i) then
            if clr_i = '1' then
                output_o <= (others => '0');
            end if;

			if enable_i = '1' then
                l_acc : for k in 0 to peso_i'length-1 loop
                    aux := signed(input_i(k)) * signed(peso_i(k));
                    vacc := vacc + aux(63 + DECIMALS downto DECIMALS);
                end loop l_acc;

                vacc := vacc + signed(bias_i);

                -- Asumimos funcion de activacion identidad
                --output_o <= std_logic_vector(vacc(63 + DECIMALS downto DECIMALS));
                output_o <= std_logic_vector(vacc);
                vacc := to_signed(0, 64);
			end if;
		end if;
	end process;
end architecture;
