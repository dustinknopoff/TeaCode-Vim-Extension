function! TeaCodeExpand()
	" Collect data
	let trigger  = getline( '.' ) 
	let line     = line( '.' )

	" Gets the current line and column
	let cursor = getpos('.')

	" Remove line expander was called on
	execute "normal! dd"
  try
	  " Run expand function and store the results in ob
    let ob = system( "sh " . fnamemodify(resolve(expand('<sfile>:p')), ':h') . "/expand.sh -e ". &ft ." -t '". trigger ."'" )
    
    " Convert command response to an object by running eval function
	  let object = json_decode( ob )
	  let s:result = object.text

	  " Report install TeaCode if error.
  	if s:result ==? 'null'
	  	echo "Could not run TeaCode. Please make sure it's installed. You can download the app from https://www.apptorium.com/teacode"
	  endif

	  " write to screen
	  execute "normal! i". s:result

	  " Loop through output text to determine final cursor line and column.
    if has('python')
      python << EOF1
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
EOF1
   endif

   if has('python3')
python3 << EOF
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
    endif
  
	  " Set the cursor position
	  " [bufnum, lnum, col, off]
	  let newline = line + l + 1 " add offset
	  let newcol = cursor[2] + c - 1
	  call setpos( '.', [0, newline, newcol, 0] )
  catch /.*/
    echo "Caught error: " . v:exception
  endtry
endfunction
