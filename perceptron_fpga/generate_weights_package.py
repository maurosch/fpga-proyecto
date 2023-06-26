import sys
from get_number import get_number_line

def write_weights_to_file(weights_str, total_weights, package_name, output_file):
    file_str = (
f'''
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.perceptron_package.perceptron_input;

package {package_name} is
    function GetWeights(Dummy: natural)
    return perceptron_input;
end package {package_name};

package body {package_name} is
    function GetWeights(Dummy: natural) return perceptron_input is
        variable pesos_i : perceptron_input({total_weights-1} downto 0);
    begin
{weights_str}
    return pesos_i;
    end function;
end package body {package_name};
    ''')
    vhdl_file = open(f"{output_file}", "w")
    vhdl_file.write(file_str)
    vhdl_file.close()

'''
Trade offer:
    You give me: 
        * the name of the package you want to create.
        * A file with 1 weight per line
        * An output file
    You receive:
        * The necessary code for getting the weights from the desired package written in the ouput file
'''
if __name__ == '__main__':
    package_name = sys.argv[1]
    weights_file = sys.argv[2]
    output_file = sys.argv[3]


    
    weights_str = ""
    total_weights = 0
    with open(weights_file) as file:
        for weight in file:
            if weight.isspace():
                continue
            weights_str += get_number_line("pesos_i", total_weights, weight)
            total_weights += 1

    write_weights_to_file(weights_str, total_weights, package_name, output_file)
