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
	val = "+%28" + args[0] + ",+" + args[1] + "%29+"
	step -= 1
	return box_boy(val, step)