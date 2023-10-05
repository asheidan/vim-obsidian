
if exists("current_compiler")
	finish
endif

let current_compiler = "vim-obsidian"

CompilerSet errorformat=%+P#\ %f,%l:%m,%Q
" TODO: Use the quickfix-directory-stack to list backlinks in Dailies
" TODO: Use lmake to populate backlinks

CompilerSet makeprg=~/Documents/Projects/vim-roam/filter.py
