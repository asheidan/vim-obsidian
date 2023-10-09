" Title:       Vim Obsidian
" Description: A plugin to mimic some behaviours of Obsidian


if exists("g:loaded_obsidian")
	finish
endif
let g:loaded_obsidian = 1

let s:plugin_folder = expand('<sfile>:p:h:h')

let g:obsidian_filter_path = s:plugin_folder . '/bin/filter.py'
