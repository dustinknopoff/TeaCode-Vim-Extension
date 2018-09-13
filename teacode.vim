function! TeaCodeExpand()
	" Collect data
	let trigger  = getline( '.' )
	let line     = line( '.' )
	let filetype = &filetype
	let cursor = getpos('.')
    execute "normal! dd"
	" Run expand function and store the results in ob
	let ob = system( "sh ./expand.sh -e ". filetype ." -t '". trigger ."'" )
	" Convert command response to an object by running eval function
	let object = js_decode( ob )
	let s:result = object.text
	" report install TeaCode if error.
	if s:result ==? 'null'
        echo "Could not run TeaCode. Please make sure it's installed. You can download the app from https://www.apptorium.com/teacode"
    endif
	execute "normal! i". s:result
python << EOF
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
EOF
	" Set the cursor position
	" [bufnum, lnum, col, off]
	let newline = line + l+1
	let newcol = cursor[2] + c - 1
	call setpos( '.', [0, newline, newcol, 0] )
endfunction

imap <C-e> <C-O>:call TeaCodeExpand()<CR>