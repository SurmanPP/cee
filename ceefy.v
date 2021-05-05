module main

import os
import cli

const (
	max_name_len = 37
)

fn header_from_keywords(ikeywords []string) string {
	mut keywords := ikeywords.clone()
	mut result := []string{}
	mut e := ''
	mut big_e := 0
	mut last_escaped := false
	mut last := ''
	for mut line in keywords {
		if last_escaped {
			line = line.add(last)
			last_escaped = false
		}
		if line.ends_with('\\') {
			last_escaped = true
			last = '$line'
			continue
		}
		if e.len >= max_name_len {
			big_e++
			e = ''
		}
		if big_e > e.len {
			e += 'E'
		} else {
			e += 'e'
		}
		result << '#define $e $line'
	}
	return result.join('\n')
}

fn write(cmd cli.Command, input string) ? {
	if cmd.flags.get_bool('to-stdout') ? {
		println(input)
		return
	}
	if cmd.flags.get_string('output') ? != '' {
		flag := cmd.flags.get_string('output') ?
		os.write_file('$flag', input)
		return
	}
	os.write_file(cmd.args[0].trim_suffix('.cefy').add('.h'), input)
}

fn main() {
	mut command := cli.Command{
		name: 'ceefy'
		description: 'ceefy your code'
		usage: 'ceefy [OPTIONS] <input>'
		version: '2.0.1'
		execute: fn (cmd cli.Command) ? {
			if cmd.args.len > 1 {
				return error('too many arguments: expected 1 got $cmd.args.len')
			}
			if os.is_atty(os.stdin().fd) != 1 {
				write(cmd, header_from_keywords(os.get_lines())) ?
				return
			}
			if cmd.args.len < 1 {
				return error('not enough arguments: exspected 1 got $cmd.args.len')
			}
			if !os.is_file(cmd.args[0]) {
				return error('file not found: ${cmd.args[0]}')
			}
			write(cmd, header_from_keywords(os.read_lines(cmd.args[0]) ?)) ?
		}
		flags: [
			cli.Flag{
				flag: .bool
				name: 'to-stdout'
				abbrev: 's'
				description: 'write to a file'
			},
			cli.Flag{
				flag: .string
				name: 'output'
				abbrev: 'o'
				description: 'define the output file'
			},
		]
		required_args: 0
	}
	command.parse(os.args)
}
