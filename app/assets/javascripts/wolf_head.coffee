@wolfram = () ->
	url_base = 'http://www.wolframalpha.com/input/?i='
	latex = getLatex()
	url_tail = wolf_parse(latex)
	OpenNewTab(url_base+url_tail)
	

@OpenNewTab = (url) ->
	win = window.open(url, '_blank')
	win.focus()

@hello = () ->
	alert('hello')

@append = () ->
	#$('#input').mathquill('write','\\int_a^b dx')
	str = 'he'
	this[str+'llo']()