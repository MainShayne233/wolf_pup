function getLatex(){

	input = document.getElementById('input');

	latex = $(input).mathquill('latex');

	//output = document.getElementById('output1');

	//$(output).mathquill('redraw');

	//output.innerHTML = latex;

	return latex;

}
