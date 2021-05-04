module main

import os

fn print_usage() {
	println('USAGE: eify [input]')
}

fn eefy(input []string) string {
	mut output := []string{}
	mut e := ''
	mut big_e := 0
	for keyword in input {
		if e.len >= 37 {
			big_e++
			e = ''
		}
		if big_e <= e.len {
			e += 'e'
			output << '#define $e $keyword\n'
			continue
		}
		e += 'E'
		output << '#define $e $keyword\n'
	}
	return output.join('')
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
