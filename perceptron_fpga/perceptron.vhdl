library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package my_package is
    type perceptron_input is array (natural range <>) of std_logic_vector(63 downto 0);
end package;

use work.my_package.all;

entity perceptron is
generic (
    N: natural := 1 -- cantidad de entradas del perceptron
);
port (
    peso_i : in perceptron_input(N-1 downto 0);
    input : in perceptron_input(N-1 downto 0);
	clock_i : in std_logic;
	clr_i : in std_logic;
	enable_i : in std_logic;
    output : out std_logic_vector(63 downto 0)
);
end entity;

architecture logic of perceptron is 
    signal input_pesado : signed(63 downto 0);
begin
	PERCEPTRON_PROC: process(clock_i, enable_i)
	begin
		if rising_edge(clock_i) then
            if clr_i = '1' then
--                peso_i <= (others => '0');
--                input <= (others => '0');
                input_pesado <= (others => '0');
            end if;
			if enable_i = '1' then
                input_pesado <= signed(input(0)) * signed(peso_i(0));
                if input_pesado(127) = '1' then
                    -- input_pesado negativo
                    output <= (others => '0');
                else
                    output <= std_logic_vector(input_pesado);
                end if;
			end if;
		end if;
	end process;
end architecture;

entity sum_mul is 
port (
    input : in std_logic_vector(63 downto 0);
    multiplier: in std_logic_vector(63 downto 0);
    accum: in std_logic_vector(63 downto 0);
	clock_i : in std_logic;
	clr_i : in std_logic;
	enable_i : in std_logic;
    output : out std_logic_vector(63 downto 0);
);
end entity;


architecture logic of sum_mul is
begin
    SUM_MUL_PROC: process(clock_i, enable_i) 
    begin
        if rising_edge(clock_i)
            output <= signed(input(0)) * signed(peso_i(0)) + signed(accum(0));
        end if;
    end process;
end architecture;