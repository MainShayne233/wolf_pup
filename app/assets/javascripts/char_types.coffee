@is_brack = (str) ->
	str in ['{', '}']

@is_backslash = (str) ->
	str == "\\"

@is_norm = (str) ->
	array = ['0'..'9'] + ["a".."z"] 
	array += ['+', '-', '=', '<', '>', '.', ',']
	array += ['[', ']']
	str in array

@is_space = (str) ->
	str == ' '

@is_expo = (str) ->
	str == '^'