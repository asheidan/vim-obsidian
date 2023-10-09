
if exists("current_compiler")
	finish
endif

let current_compiler = "obsidian"

CompilerSet errorformat=%+P#\ %f,%l:%m,%Q
" TODO: Use the quickfix-directory-stack to list backlinks in Dailies
" TODO: Use lmake to populate backlinks

execute 'CompilerSet' 'makeprg=' . g:obsidian_filter_path
