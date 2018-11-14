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
		let script_path = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/python/teacode.py'
		if has('python') || has('python3')
    	execute (has('python3') ? 'py3file' : 'pyfile') script_path
		  " Loop through output text to determine final cursor line and column.
		  " Set the cursor position
		  " [bufnum, lnum, col, off]
		  let newline = line + l + 1 " add offset
		  let newcol = cursor[2] + c - 1
		  call setpos( '.', [0, newline, newcol, 0] )
    else
  		echo "Please re-compile vim with either python or python3"
			finish
		endif
	
 catch /.*/
    echo "Caught error: " . v:exception
 endtry
endfunction
