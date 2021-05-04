module main

import os

fn print_usage() {
	println('USAGE: eify [input]')
}

fn eefy(input []string) string {
	mut output := ''
	mut e := ''
	for keyword in input {
		e += 'e'
		output += '#define $e $keyword\n'
	}
	return output
}

fn main() {
	args := os.args[1..]
	if os.is_atty(os.stdin().fd) < 1 {
		print(eefy(os.get_lines()))
		return
	}
	if args.len != 1 {
		print_usage()
		return
	}
	lines := os.read_lines(args[0]) or {
		eprintln(err)
		return
	}
	print(eefy(lines))
	return
}
