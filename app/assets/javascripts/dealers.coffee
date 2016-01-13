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