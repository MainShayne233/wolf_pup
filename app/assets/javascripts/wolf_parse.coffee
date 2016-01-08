@box_boy = (val, step) ->
	box = {}
	box.val = val
	box.step = step
	box

@ups_guy = (latex, step) ->
	chr = latex[step]
	destinations = ['brack', 'backslash', 'expo', 'norm', 'space']
	for d in destinations
		if this['is_'+d](chr)
			return this[d+'_dealer'](latex, step)
	alert "ups guy didn't get correct address when latex[step] = " + latex[step] + " and step = " + step
	

@wolf_parse = (latex) ->
	args = []
	latex = latex.split ""
	step = 0
	while step < latex.length
		box = ups_guy(latex, step)
		args.push box.val
		step = box.step
		step += 1
	tail = args.join ''
	document.getElementById('output2').innerHTML = tail
	tail