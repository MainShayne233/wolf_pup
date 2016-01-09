@backslash_dealer = (latex, step) ->
	types = ['frac', 'comb', 'root', 'int', 'pi']
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
	arg = ""
	step += 1
	if latex[step] == '{'
		while latex[step] != '}'
			box = ups_guy(latex, step)
			val = box.val
			if val != ')'
				arg += val if val != '('
				step = box.step
			step += 1
	else
		arg = latex[step]
	val = '%5E'+'%28'+arg+'%29'
	return box_boy(val, step)

@space_dealer = (latex, step) ->
	return box_boy('', step)