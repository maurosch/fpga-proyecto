import sys

def negative_str(input):
    return bin(input & 0xFFFF_FFFF_FFFF_FFFF)[2:]

def positive_str(input):
    return f"{input:064b}"

def add_underscores(my_str, group=16, char='_'):
    return char.join(my_str[i:i+group] for i in range(0, len(my_str), group))

'''
Use: python get_number.py <number>

Prints that number in 64 bits binary. You can just copy and paste the output to the VHDL file.
It also adds a comment at the end of the line with the number asked because I am a great person :)
'''
if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Give me a number bro!")
        sys.exit(1)

    number = int(sys.argv[1])<<32
    if number < 0:
        binary_str = negative_str(number)
    else:
        binary_str = positive_str(number)
    number_with_underscores = add_underscores(binary_str)
    print(f"b\"{number_with_underscores}\"; -- {sys.argv[1]}")
