@is_brack = (str) ->
	str in ['{', '}']

@is_backslash = (str) ->
	str == "\\"

@is_norm = (str) ->
	array = ['0'..'9']
	array += "abcdefghijklmnopqrstuvwxyz".split ''
	array += ['-', '.']
	array += ['[', ']']
	str in array

@is_special = (str) ->
	array = ['+', '=', '<', '>', ',', '[', ']', '(', ')']
	str in array

@is_space = (str) ->
	str == ' '

@is_expo = (str) ->
	str == '^'