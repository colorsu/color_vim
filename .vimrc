"""normal form{{{
set foldmethod=marker
set nu
set tabstop=4       " tab width
set expandtab
set softtabstop=4   " backspace
set shiftwidth=4    " indent width
set laststatus=2
syntax on
"""}}}

""" VUNDLE"""{{{
set nocompatible              " be iMproved, required
filetype off                  " required
"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
	Plugin 'VundleVim/Vundle.vim'
	Plugin 'scrooloose/nerdtree'
	Plugin 'vim-scripts/indentpython'
	Plugin 'bitc/vim-bad-whitespace'
	Plugin 'kien/ctrlp.vim'
	Plugin 'taglist.vim'
	Plugin 'trinity.vim'
	Plugin 'w0rp/ale'
	Plugin 'vim-airline/vim-airline'
call vundle#end()            " required
filetype plugin indent on    " required
"""}}}

"""FILE Tile{{{
"新建.c,.h,.sh,.java文件，自动插入文件头
filetype on                  " required

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()

    "如果文件类型为.sh文件

    if &filetype == 'sh'
        call setline(1,          "\#########################################################################")
        call append(line("."),   "\# File Name:	".expand("%"))
        call append(line(".")+1, "\# Author: color")
        call append(line(".")+2, "\# mail: colorsu1922@163.com")
        call append(line(".")+3, "\# Created Time:	".strftime("%c"))
        call append(line(".")+4, "\#########################################################################")
        call append(line(".")+5, "\#!/bin/bash")
        call append(line(".")+6, "")
	else
        call setline(1,          "/*************************************************************************")
        call append(line("."),   "    > File Name: ".expand("%"))
        call append(line(".")+1, "    > Author: color")
        call append(line(".")+2, "    > mail: colorsu1922@163.com")
        call append(line(".")+3, "    > Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif

    if &filetype == 'c'
        call append(line(".")+6, "#include <stdio.h>")
        call append(line(".")+8, "")
    endif

    "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
	normal G
	normal o
endfunc

autocmd bufnewfile *.py call HeaderPython()
function HeaderPython()
	call setline(1, "#!/usr/bin/env python")
	call append(1,  "#-*- coding:utf8 -*-")
	call append(2,  "# Power by color" . strftime('%Y-%m-%d %T', localtime()))
	call append(3,  "# Mail: colorsu1922@163.com")
	normal G
	normal o
	normal o
endfunc

"""}}}

"""Asynchronous Lint Engine"""{{{
"ale
set rtp+=~/.vim/bundle/ale
"始终开启标志列
let g:ale_sign_column_always = 0
let g:ale_set_highlights = 0
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
"nmap <Leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>
"""状态栏现实的内容
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}\ %{ALEGetStatusLine()}
"对C/C++使用Clang进行语法检查
let g:ale_linters = {'c': 'clang'}
let g:ale_linters = {'c++': 'clang++'}
""文件内容发生变化时不进行检查
let g:ale_lint_on_text_changed = 1
"打开文件时不进行检查
let g:ale_lint_on_enter = 1
"""}}}

""" YouCompleteMe{{{
set runtimepath+=~/.vim/bundle/YouCompleteMe
let g:ycm_collect_identifiers_from_tags_files = 1           " 开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_comments_and_strings = 1 " 注释与字符串中的内容也用于补全
"let g:syntastic_ignore_files=[".*\.py$"]
let g:ycm_seed_identifiers_with_syntax = 1                  " 语法关键字补全
let g:ycm_complete_in_comments = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']  " 映射按键, 没有这个会拦截掉tab, 导致其他插件的tab不能用.
let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
let g:ycm_complete_in_comments = 1                          " 在注释输入中也能补全
let g:ycm_complete_in_strings = 1                           " 在字符串输入中也能补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1 " 注释和字符串中的文字也会被收入补全
let g:ycm_global_ycm_extra_conf='/home/color/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
"let g:ycm_show_diagnostics_ui = 1                           " 禁用语法检查
let g:ycm_min_num_of_chars_for_completion=2                 " 从第2个键入字符就开始罗列匹配项
let g:ycm_path_to_python_interpreter='/usr/bin/python'
"""}}}

""" NERDTree{{{
"nnoremap <silent> <F5> :NERDTree<CR>
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeWinPos=1
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
"""}}}

"Taglist{{{
let Tlist_Show_One_File=1     "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow=1   "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Ctags_Cmd="/usr/local/bin/ctags" "将taglist与ctags关联
"map <F2> <Esc>:TlistToggle<CR>
"}}}

"SrcExpl{{{
" // The switch of the Source Explorer
"nmap <F8> :SrcExplToggle<CR>

" // Set the height of Source Explorer window
let g:SrcExpl_winHeight = 8

" // Set 100 ms for refreshing the Source Explorer
let g:SrcExpl_refreshTime = 100

" // Set "Enter" key to jump into the exact definition context
let g:SrcExpl_jumpKey = "<ENTER>"

" // Set "Space" key for back from the definition context
let g:SrcExpl_gobackKey = "<SPACE>"

" // In order to avoid conflicts, the Source Explorer should know what plugins except
" // itself are using buffers. And you need add their buffer names into below list
" // according to the command ":buffers!"
let g:SrcExpl_pluginList = [
        \ "__Tag_List__",
        \ "_NERD_tree_",
        \ "Source_Explorer"
    \ ]

" // The color schemes used by Source Explorer. There are five color schemes
" // supported for now - Red, Cyan, Green, Yellow and Magenta. Source Explorer
" // will pick up one of them randomly when initialization.
let g:SrcExpl_colorSchemeList = [
        \ "Red",
        \ "Cyan",
        \ "Green",
        \ "Yellow",
        \ "Magenta"
    \ ]

" // Enable/Disable the local definition searching, and note that this is not
" // guaranteed to work, the Source Explorer doesn't check the syntax for now.
" // It only searches for a match with the keyword according to command 'gd'
let g:SrcExpl_searchLocalDef = 1

" // Workaround for Vim bug @https://goo.gl/TLPK4K as any plugins using autocmd for
" // BufReadPre might have conflicts with Source Explorer. e.g. YCM, Syntastic etc.
let g:SrcExpl_nestedAutoCmd = 1

" // Do not let the Source Explorer update the tags file when opening
let g:SrcExpl_isUpdateTags = 0

" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to
" // create/update the tags file
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ."

" // Set "<F12>" key for updating the tags file artificially
let g:SrcExpl_updateTagsKey = "<F12>"

" // Set "<F3>" key for displaying the previous definition in the jump list
let g:SrcExpl_prevDefKey = "<F3>"

" // Set "<F4>" key for displaying the next definition in the jump list
let g:SrcExpl_nextDefKey = "<F4>"
"}}}

"Trinity{{{
" Open and close all the three plugins on the same time
nmap <F6>  :TrinityToggleAll<CR>

" Open and close the Source Explorer separately
nmap <F7>  :TrinityToggleSourceExplorer<CR>

" Open and close the Taglist separately
nmap <F8> :TrinityToggleTagList<CR>

" Open and close the NERD Tree separately
nmap <F9> :TrinityToggleNERDTree<CR>
"}}}

"cscope{{{
if has("cscope")

    if filereadable("cscope.out")

        cs add cscope.out

    endif

endif
"
"}}}
