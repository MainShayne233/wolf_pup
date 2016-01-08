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
	val = "%28" + args[0] + 'th+root+of+%28' + args[1] + "%29%29"
	return box_boy(val, step)