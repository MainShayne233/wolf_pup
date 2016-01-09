@is_comb = (latex, step) ->
	(latex[step+1..step+5].join '') == "binom"

@is_frac = (latex, step) ->
	(latex[step+1..step+4].join '') == 'frac'

@is_geq = (latex, step) ->
	(latex[step+1..step+3].join '') == 'geq'

@is_int = (latex, step) ->
	(latex[step+1..step+3].join '') == 'int'

@is_leq = (latex, step) ->
	(latex[step+1..step+3].join '') == 'leq'

@is_lpar = (latex, step) ->
	(latex[step+1..step+5].join '') == 'lpar'

@is_lim = (latex, step) ->
	(latex[step+1..step+3].join '') == 'lim'

@is_multiply = (latex, step) ->
	(latex[step+1..step+4].join '') == 'cdot'

@is_nthroot = (latex, step) ->
	(latex[step+1..step+7].join '') == 'nthroot'

@is_pi = (latex, step) ->
	(latex[step+1..step+2].join '') == 'pi'

@is_prod = (latex, step) ->
	(latex[step+1..step+4].join '') == 'prod'

@is_rpar = (latex, step) ->
	(latex[step+1..step+5].join '') == 'right'

@is_root = (latex, step) ->
	(latex[step+1..step+4].join '') == 'sqrt'

@is_sum = (latex, step) ->
	(latex[step+1..step+3].join '') == 'sum'

@is_text = (latex, step) ->
	(latex[step+1..step+4].join '') == 'text'

@is_to = (latex, step) ->
	(latex[step+1..step+2].join '') == 'to'