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

@theta_dealer = (latex, step) ->
	step += 5
	return box_boy("%28theta%29", step)


@to_dealer = (latex, step) ->
	step += 2
	return box_boy("+to+", step)
