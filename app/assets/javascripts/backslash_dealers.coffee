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