" https://vi.stackexchange.com/questions/18353/how-to-conceal-filename-and-line-number-in-quickfix-window
" TODO: Only do this when we are showing backlinks
"syntax match ConcealedDetails /\v^[^|]*\|[^|]*\| / conceal

function! BacklinksFormat()
	" Taken from syntax/qf.vim
	syn match	qfFileName	"^[^|]*" nextgroup=qfSeparator conceal
	syn match	qfSeparator	"|" nextgroup=qfLineNr contained conceal
	syn match	qfLineNr	"[^|]*" contained contains=qfError conceal
	syn match	qfError		"error" contained

	"setlocal conceallevel=2
	setlocal concealcursor=nvic
	setlocal wrap

endfunction
command BacklinksFormat call BacklinksFormat()

" DONE: Wrap output in quickfix window
" https://vi.stackexchange.com/questions/2843/how-to-automatically-set-wrapping-for-quickfix-window

" TODO: Highlight header levels in qf-window
