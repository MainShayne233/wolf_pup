@special_dealer = (latex, step) ->
	char = latex[step]
	switch
		when char == '+'
			arg = '%2B'
		when char =='='
			arg = '%3D'
		when char == '<'
			arg = '%3C'
		when char == '>'
			arg = '%3E'
		when char == ','
			arg = '%2C'
		when char == '['
			arg = '%5B'
		when char == ']'
			arg = '%5D'
		when char == '('
			arg = '%28'
		when char == ')'
			arg = '%29'
		else
			arg = ""
	return box_boy(arg, step)