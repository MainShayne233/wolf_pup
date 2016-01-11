@box_boy = (val, step) ->
	box = {}
	box.val = val
	box.step = step
	box

@ups_guy = (latex, step) ->
	chr = latex[step]
	destinations = ['brack', 'backslash', 'expo', 'norm', 'space', 'special']
	for d in destinations
		if this['is_'+d](chr)
			return this[d+'_dealer'](latex, step)
	alert "ups guy didn't get correct address when latex[step] = " + latex[step] + " and step = " + step
	

@wolf_parse = (latex) ->
	latex = latex.split ""
	step = 0
	box = til_the_end_sniffer(latex, step)
	arg = box.val
	step = box.step
	document.getElementById('output2').innerHTML = arg
	return arg