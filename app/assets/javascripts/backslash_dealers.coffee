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
	val = '%28integral' + lims + '+%28' + arg + '%29%29'
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
		arg = ''
		while step < latex.length
			box = ups_guy(latex, step)
			arg += box.val
			step = box.step
			step += 1
	val = "%28lim+" + lim + arg + "%29"
	return box_boy(val, step)


@pi_dealer = (latex, step) ->
	step += 2
	val = 'pi'
	return box_boy(val, step)

@root_dealer = (latex, step) ->
	step += 5
	box = if latex[step] == "[" then nth_root_dealer(latex, step) else sqrt_dealer(latex, step)
	arg = box.val
	step = box.step
	return box_boy(arg, step)

@to_dealer = (latex, step) ->
	step += 2
	return box_boy("+to+", step)
