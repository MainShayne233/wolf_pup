@type_latex = (type) ->
	if type == 'frac'
		return '\\frac{}{}'
	if type == 'expo'
		return '^{}'
	if type == 'sqrt'
		return '\\sqrt{}'
	if type == 'nthroot'
		return '\\sqrt[]{}'
	if type == 'lim'
		return '\\lim_{x\\to\\infty}'
	if type == 'sum'
		return '\\sum_{n=0}^{\\infty}'
	if type == 'indef_int'
		return '\\int dx'
	if type == 'def_int'
		return '\\int_{}^{} dx'
		
@wolf_write = (type) ->
	latex = type_latex(type)
	$('#input').mathquill('write', latex)