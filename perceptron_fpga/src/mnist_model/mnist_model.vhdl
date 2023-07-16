library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


use work.perceptron_package.perceptron_input;

entity mnist_model is
port (
	clock_i : in std_logic;
	clr_i : in std_logic;
	enable_i : in std_logic;
    inputs_i : in perceptron_input(63 downto 0);
    pesos_i : in perceptron_input(((64*128) + (128*128) + (128*10)) - 1 downto 0);
    biases_i : in perceptron_input((128 + 128 + 10) - 1 downto 0);
    mm : out std_logic_vector(3 downto 0);
    model_out : out perceptron_input(9 downto 0)
);
end entity;

architecture logic of mnist_model is 
    constant COLUMNS : natural := 4;
    constant ROWS_PER_COLUMN : natural := 128;
    constant MODEL_INPUTS : natural := 64;
    constant MODEL_OUTPUTS : natural := 10;
    constant INPUT_WEIGHTS: natural := ROWS_PER_COLUMN * MODEL_INPUTS;
    constant MIDDLE_WEIGHTS: natural := (COLUMNS-3) * (ROWS_PER_COLUMN * ROWS_PER_COLUMN);
    constant OUTPUT_WEIGHTS: natural := ROWS_PER_COLUMN * MODEL_OUTPUTS;
    constant TOTAL_WEIGHTS: natural := INPUT_WEIGHTS + MIDDLE_WEIGHTS + OUTPUT_WEIGHTS;
    signal network_output : perceptron_input(MODEL_OUTPUTS - 1 downto 0);
begin
    matrix: entity work.perceptron_matrix
    generic map (
        COLUMNS => COLUMNS,
        ROWS_PER_COLUMN => ROWS_PER_COLUMN,
        MATRIX_INPUTS => MODEL_INPUTS,
        MATRIX_OUTPUTS => MODEL_OUTPUTS
    )
    port map (
        clock_i => clock_i,
        clr_i => clr_i,
        enable_i => enable_i,
        inputs_i => inputs_i,
        pesos_in_i => pesos_i(INPUT_WEIGHTS-1 downto 0),
        pesos_i => pesos_i((MIDDLE_WEIGHTS+INPUT_WEIGHTS)-1 downto INPUT_WEIGHTS),
        pesos_out_i => pesos_i(TOTAL_WEIGHTS-1 downto MIDDLE_WEIGHTS + INPUT_WEIGHTS),
        biases_i => biases_i,
        outputs_o => model_out
    );
    out_to_bcd: entity work.output_to_digit
    port map (
        inputs_i => network_output,
        bcd_digit_o => mm
    );
end architecture;
