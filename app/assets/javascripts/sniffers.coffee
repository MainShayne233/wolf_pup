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