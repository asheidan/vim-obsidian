" https://vi.stackexchange.com/questions/18353/how-to-conceal-filename-and-line-number-in-quickfix-window
" TODO: Only do this when we are showing backlinks
"syntax match ConcealedDetails /\v^[^|]*\|[^|]*\| / conceal

function! BacklinksFormat()
	" Taken from syntax/qf.vim
	syn match	qfFileName	"^[^|]*" nextgroup=qfSeparator conceal
	syn match	qfSeparator	"|" nextgroup=qfLineNr contained conceal
	syn match	qfLineNr	"[^|]*" contained contains=qfError conceal
	syn match	qfError		"error" contained

	setlocal conceallevel=2
	setlocal concealcursor=nvic

	"syn region markdownH1 matchgroup=markdownH1Delimiter start=" #\s.*" end="#*\s*$" keepend oneline
	syn region markdownH1 matchgroup=markdownH1Delimiter start=" #\s" end="#*\s*$" keepend oneline
	syn region markdownH2 matchgroup=markdownH2Delimiter start=" ##\s" end="#*\s*$" keepend oneline
	syn region markdownH3 matchgroup=markdownH3Delimiter start=" ###\s" end="#*\s*$" keepend oneline
	syn region markdownH4 matchgroup=markdownH4Delimiter start=" ####\s" end="#*\s*$" keepend oneline
	syn region markdownH5 matchgroup=markdownH5Delimiter start=" #####\s" end="#*\s*$" keepend oneline
	syn region markdownH6 matchgroup=markdownH6Delimiter start=" ######\s" end="#*\s*$" keepend oneline

	hi def link markdownH1Delimiter           markdownHeadingDelimiter
	hi def link markdownH2Delimiter           markdownHeadingDelimiter
	hi def link markdownH3Delimiter           markdownHeadingDelimiter
	hi def link markdownH4Delimiter           markdownHeadingDelimiter
	hi def link markdownH5Delimiter           markdownHeadingDelimiter
	hi def link markdownH6Delimiter           markdownHeadingDelimiter
	hi def link markdownHeadingDelimiter      Delimiter

endfunction
command BacklinksFormat call BacklinksFormat()

" DONE: Wrap output in quickfix window
" https://vi.stackexchange.com/questions/2843/how-to-automatically-set-wrapping-for-quickfix-window

" TODO: Highlight header levels in qf-window
