import sys


def print_usage():
    print('USAGE: eify [input]')
    exit(0)


def eefy(lines):
    output = ''
    e = ''
    for line in lines:
        e += 'e'
        output += f'#define {e} {line}'
    return output


if len(sys.argv[:1]) == 0:
    if sys.stdin.isatty():
        print_usage()
    with open(sys.stdin) as stdin:
        print(eefy(stdin.readlines()))
with open(sys.argv[:1]) as file:
    print(eefy(file.readlines()))
