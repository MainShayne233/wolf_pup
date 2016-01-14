@cdot_dealer = (latex, step) ->
	step += 4
	val = "*"
	return box_boy(val, step)

@comb_dealer = (latex, step) ->
	args = []
	args[0] = ""
	args[1] = ""
	step += 6
	for i in [0..1]
		step += 1
		box = bracket_sniffer(latex, step)
		args[i] = box.val
		step = box.step
	val = "%28%28" + args[0] + "%29+choose+%28" + args[1] + "%29%29"
	return box_boy(val, step)

@frac_dealer = (latex, step) ->
	args = []
	args[0] = ""
	step += 5
	rbrack_cnt = 0
	while rbrack_cnt < 2
		step += 1
		box = ups_guy(latex, step)
		val = box.val
		if val == ")"
			rbrack_cnt += 1
			args[rbrack_cnt] = "" if rbrack_cnt < 2
		else if !is_brack(val)
			args[rbrack_cnt] += val if val != "("
			step = box.step
	args = args.map (i) -> "%28" + i + "%29"
	args = '%28'+args.join("%2F")+'%29'
	return box_boy(args, step)

@ge_dealer = (latex, step) ->
	step += 2
	val = '%3E%3D'
	return box_boy(val, step)

@infty_dealer = (latex, step) ->
	step += 5
	val = 'infinity'
	return box_boy(val, step)

@int_dealer = (latex, step) ->
	step += 4
	lims = ''
	if latex[step] in ['^','_']
		box = top_and_sub_sniffer(latex, step)
		lims = box.val
		step = box.step
	box = int_sniffer(latex, step)
	arg = box.val
	step = box.step
	box = ups_guy(latex, step)
	step = box.step
	val = '%28integral' + lims + arg + '%29'
	return box_boy(val, step)

@lbrack_dealer = (latex, step) ->
	step += 5
	step += 1 if latex[step] == '\\'
	val = '%28' if latex[step] == '('
	val = '%5B' if latex[step] == '['
	val = '%7B' if latex[step] == '{'
	return box_boy(val, step)

@le_dealer = (latex, step) ->
	step += 2
	val = '%3C%3D'
	return box_boy(val, step)


@lim_dealer = (latex, step) ->
	step += 4
	lim = ''
	if latex[step] == '_'
		step += 1
		box = lim_script_sniffer(latex, step)
		lim = box.val
		step = box.step
		step += 1
	if latex[step] == '{'
		box = bracket_sniffer(latex, step)
		arg = box.val
		step = box.step
	else
		box = til_the_end_sniffer(latex, step)
		arg = box.val
		step = box.step
	val = "%28lim+" + lim + arg + "%29"
	return box_boy(val, step)

@log_dealer = (latex, step) ->
	step += 3
	base = ''
	if latex[step+1] == '_'
		step += 2
		if latex[step] == '{'
			box = bracket_sniffer(latex, step)
			base = box.val
			step = box.step
		else
			base = latex[step]
			#step +=1
	val = 'log' + base + "+"
	return box_boy(val, step)

@ln_dealer = (latex, step) ->
	step += 2
	return box_boy('ln', step)


@pi_dealer = (latex, step) ->
	step += 2
	val = '%28pi%29'
	return box_boy(val, step)

@rbrack_dealer = (latex, step) ->
	step += 6
	step += 1 if latex[step] == '\\'
	val = '%29' if latex[step] == ')'
	val = '%5D' if latex[step] == ']'
	val = '%7D' if latex[step] == '}'
	return box_boy(val, step)

@root_dealer = (latex, step) ->
	step += 5
	box = if latex[step] == "[" then nth_root_dealer(latex, step) else sqrt_dealer(latex, step)
	arg = box.val
	step = box.step
	return box_boy(arg, step)

@sumprod_dealer = (latex, step) ->
	if (latex[step+1..step+3].join '') == 'sum'
		f = 'sum'
		step += 4
	else if (latex[step+1..step+4].join '') == 'prod'
		f = 'product'
		step += 5
	lims = ''
	if latex[step] in ['^','_']
		box = top_and_sub_sniffer(latex, step)
		lims = box.val
		step = box.step
	if (latex[step+1..step+4].join '') == 'left'
		box = paren_sniffer(latex, step)
		arg = box.val
		step = box.step
	else
		box = til_the_end_sniffer(latex, step)
		arg = box.val
		step = box.step
	val = "%28" + f + "+" + lims + arg + "%29"
	return box_boy(val, step)

@tau_dealer = (latex, step) ->
	step += 3
	val = '%28tau%29'
	return box_boy(val, step)

@theta_dealer = (latex, step) ->
	step += 5
	return box_boy("%28theta%29", step)


@to_dealer = (latex, step) ->
	step += 2
	return box_boy("+to+", step)

@is_cdot = (latex, step) ->
	(latex[step+1..step+4].join '') == "cdot"

@is_comb = (latex, step) ->
	(latex[step+1..step+5].join '') == "binom"

@is_frac = (latex, step) ->
	(latex[step+1..step+4].join '') == 'frac'

@is_ge = (latex, step) ->
	(latex[step+1..step+2].join '') == 'ge'

@is_infty = (latex, step) ->
	(latex[step+1..step+5].join '') == 'infty'

@is_int = (latex, step) ->
	(latex[step+1..step+3].join '') == 'int'

@is_lbrack = (latex, step) ->
	(latex[step+1..step+4].join '') == 'left'

@is_le = (latex, step) ->
	(latex[step+1..step+2].join '') == 'le'

@is_lpar = (latex, step) ->
	(latex[step+1..step+5].join '') == 'lpar'

@is_lim = (latex, step) ->
	(latex[step+1..step+3].join '') == 'lim'

@is_log = (latex, step) ->
	(latex[step+1..step+3].join '') == 'log'

@is_ln = (latex, step) ->
	(latex[step+1..step+2].join '') == 'ln'

@is_multiply = (latex, step) ->
	(latex[step+1..step+4].join '') == 'cdot'

@is_nthroot = (latex, step) ->
	(latex[step+1..step+7].join '') == 'nthroot'

@is_pi = (latex, step) ->
	(latex[step+1..step+2].join '') == 'pi'

@is_prod = (latex, step) ->
	(latex[step+1..step+4].join '') == 'prod'

@is_rbrack = (latex, step) ->
	(latex[step+1..step+5].join '') == 'right'

@is_rpar = (latex, step) ->
	(latex[step+1..step+5].join '') == 'right'

@is_root = (latex, step) ->
	(latex[step+1..step+4].join '') == 'sqrt'

@is_sumprod = (latex, step) ->
	(latex[step+1..step+3].join '') == 'sum' or (latex[step+1..step+4].join '') == 'prod' 

@is_tau = (latex, step) ->
	(latex[step+1..step+3].join '') == 'tau'

@is_text = (latex, step) ->
	(latex[step+1..step+4].join '') == 'text'

@is_theta = (latex, step) ->
	(latex[step+1..step+5].join '') == 'theta'

@is_to = (latex, step) ->
	(latex[step+1..step+2].join '') == 'to'

@is_brack = (str) ->
	str in ['{', '}']

@is_backslash = (str) ->
	str == "\\"

@is_norm = (str) ->
	array = ['0'..'9']
	array += "abcdefghijklmnopqrstuvwxyz".split ''
	array += ['-', '.']
	array += ['[', ']']
	array += ['!']
	str in array

@is_special = (str) ->
	array = ['+', '=', '<', '>', ',', '[', ']', '(', ')']
	str in array

@is_space = (str) ->
	str == ' '

@is_expo = (str) ->
	str == '^'

@backslash_dealer = (latex, step) ->
	types = ['cdot', 'comb', 'frac', 'ge', 'infty', 'int', 'lbrack', 'le', 'lim', 'log', 'ln', 'pi', 'rbrack', 'root', 'sumprod', 'tau', 'to', 'theta']
	for t in types
		if this["is_#{t}"](latex, step)
			return this["#{t}_dealer"](latex, step)

@brack_dealer = (latex, step) ->
	val = if latex[step] == "{" then "(" else ")"
	return box_boy(val, step)

@norm_dealer = (latex, step) ->
	val = latex[step]
	return box_boy(val, step)

@expo_dealer = (latex, step) ->
	step += 1
	if latex[step] == '{'
		box = bracket_sniffer(latex, step)
		arg = box.val
		step = box.step
	else
		arg = latex[step]
	val = '%5E'+'%28'+arg+'%29'
	return box_boy(val, step)

@space_dealer = (latex, step) ->
	return box_boy('', step)

@int_sniffer = (latex, step) ->
	arg = ''
	while latex[step] != 'd'
		box = ups_guy(latex,step)
		if box.val != 'd'
			arg += box.val
			step = box.step
		step += 1
	step += 1
	return box_boy(arg, step)

@sqrt_dealer = (latex, step) ->
	box = bracket_sniffer(latex, step)
	arg = box.val
	val = '%28sqrt%28' + arg + '%29%29'
	step = box.step
	return box_boy(val,step)

@nth_root_dealer = (latex, step) ->
	args = []
	box = square_bracket_sniffer(latex, step)
	args[0] = box.val
	step = box.step
	step+=1
	box = bracket_sniffer(latex, step)
	args[1] = box.val
	step = box.step
	val = "%28" + args[1] + "^%281%2F" + args[0] + "%29%29"
	return box_boy(val, step)

@bracket_sniffer = (latex, step) ->
	arg = ''
	while true
		box = ups_guy(latex,step)
		break if box.val == ')'
		step = box.step
		arg += box.val if box.val != '('
		step += 1
	return box_boy(arg, step)

@square_bracket_sniffer = (latex, step) ->
	arg = ''
	while true
			box = ups_guy(latex,step)
			break if box.val == ']'
			step = box.step
			arg += box.val if box.val != '[' and box.val != ']'
			step += 1
	return box_boy(arg, step)

@lim_script_sniffer = (latex, step) ->
	step += 1
	box = bracket_sniffer(latex, step)
	val = "%28"+box.val+"%29+"
	step = box.step
	return box_boy(val, step)

@paren_sniffer = (latex, step) ->
	arg = ''
	while true
		box = ups_guy(latex, step)
		break if box.val == '%29'
		step = box.step
		arg += box.val
		step += 1
	step += 6
	val = '%28'+arg+'%29'
	return box_boy(arg, step)


@til_the_end_sniffer = (latex, step) ->
	arg = ''
	while step < latex.length
		box = ups_guy(latex, step)
		arg += box.val
		step = box.step
		step += 1
	return box_boy(arg, step)


@top_and_sub_sniffer = (latex, step) ->
	args = ['','']
	flip = latex[step] == '^'
	step += 1
	for i in [0..1]
		if latex[step] == '{'
			box = bracket_sniffer(latex, step)
			args[i] = box.val
			step = box.step
			step += 2
		else
			args[i] = latex[step]
			step += 2
	args.reverse() if flip
	val = "+%28" + args[0] + "+to+" + args[1] + "%29+"
	step -= 1
	return box_boy(val, step)

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

@wolfram = () ->
	url_base = 'http://www.wolframalpha.com/input/?i='
	latex = getLatex()
	url_tail = wolf_parse(latex)
	OpenNewTab(url_base+url_tail)
	

@OpenNewTab = (url) ->
	win = window.open(url, '_blank')
	win.focus()

@append = () ->
	str = 'he'
	this[str+'llo']()

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
	#document.getElementById('output2').innerHTML = arg
	return arg

@wolf_write = (latex) ->
	$('#input').mathquill('write', latex)