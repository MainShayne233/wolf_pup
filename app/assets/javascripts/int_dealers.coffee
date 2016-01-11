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