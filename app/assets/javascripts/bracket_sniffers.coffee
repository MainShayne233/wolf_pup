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