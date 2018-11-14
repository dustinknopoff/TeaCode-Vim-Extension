import vim
string = vim.eval("s:result")
line = 0
column = 0
vim.command("let l=%d"% line)
vim.command("let c=%d"% column)
for i in string:
	if i is '\n':
		line+=1
		column = 0
	else:
		column += 1
