" https://vi.stackexchange.com/questions/18353/how-to-conceal-filename-and-line-number-in-quickfix-window
" TODO: Only do this when we are showing backlinks
syntax match ConcealedDetails /\v^[^|]*\|[^|]*\| / conceal
setlocal conceallevel=2
setlocal concealcursor=nvic

" TODO: Wrap output in quickfix window
" https://vi.stackexchange.com/questions/2843/how-to-automatically-set-wrapping-for-quickfix-window
