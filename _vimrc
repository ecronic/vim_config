" ==> Add plugins
" echofunc           ����������ʾ
" taglist            ��ǩ
" winmanager         ���ڹ��� ��ݼ�wm
" bufexplore         ���ļ��༭������� ��ݼ�\be \bs \bv
" omnicppcomplete    C/C++�����Զ���ʾ
" colors/*           ����VIM����
" vim-markdown       Markdown�﷨���� https://github.com/plasticboy/vim-markdown
"


"Ĭ��vimrc����
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

""""""""""""""""""""""""""""""""""""""""""""""""""
" ԭgvim�Դ�������
""""""""""""""""""""""""""""""""""""""""""""""""""
set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""
" �������/�˵�����
""""""""""""""""""""""""""""""""""""""""""""""""""
"��������
set encoding=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
"��������
set langmenu=zh_CN.UTF-8
set helplang=cn
" ����˵�����,set encoding=utf-8����ֲ˵����룬�������ÿɽ��
let $LANG = 'zh_CN.UTF-8'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim


""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM���ڽ�������
""""""""""""""""""""""""""""""""""""""""""""""""""
au GUIEnter * simalt ~x         "���������
let g:winManagerWindowLayout='FileExplorer|TagList'  "������ർ������
" �ҵ�״̬����ʾ�����ݣ������ļ����ͺͽ��룩
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
set laststatus=2                " ������ʾ״̬��(1),������ʾ״̬��(2)
set guioptions-=m               " ���ع�����
set guioptions-=T               " ���ز˵���
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" ��ݼ�ӳ��
""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <c-]> g<c-]>      " ��Ctrl+]��ݼ�ӳ�䵽g Ctrl+]
nmap wm :WMToggle<cr>  " wm��ݼ����ڴ�FileExplorer

""""""""""""""""""""""""""""""""""""""""""""""""""
" ����ı�������
""""""""""""""""""""""""""""""""""""""""""""""""""
"C��C++ ��F5��������
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!./%<"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!java %<"
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc
"C,C++�ĵ���
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""
" �Զ���ȫ��������
""""""""""""""""""""""""""""""""""""""""""""""""""
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""
" �Զ������ļ�ͷ
""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.v,*.m exec ":call SetTitle()" 
func SetTitle() " ���庯��SetTitle���Զ������ļ�ͷ  
    if &filetype == 'sh'  "����ļ�����Ϊ.sh�ļ� 
        call setline(1,"#########################################################################") 
        call append(line("."), "# FileName : ".expand("%")) 
        call append(line(".")+1, "# Author   : xiahouzuoxin @163.com") 
        call append(line(".")+2, "# Date     : ".strftime("%c")) 
        call append(line(".")+3, "#########################################################################") 
        call append(line(".")+4, "") 
        call append(line(".")+5, "#!/bin/bash") 
        call append(line(".")+6, "") 
    elseif &filetype == 'matlab' 
        call setline(1, "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%") 
        call append(line("."), "% FileName : ".expand("%")) 
        call append(line(".")+1, "% Author   : xiahouzuoxin @163.com") 
        call append(line(".")+2, "% Version  : v1.0") 
        call append(line(".")+3, "% Date     : ".strftime("%c")) 
        call append(line(".")+4, "% Brief    : ")
        call append(line(".")+5, "")
        call append(line(".")+6, "% Copyright (C) USTB") 
        call append(line(".")+7, "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%") 
        call append(line(".")+8, " ")
    else 
        call setline(1, "/*") 
        call append(line("."), " * FileName : ".expand("%")) 
        call append(line(".")+1, " * Author   : xiahouzuoxin @163.com") 
        call append(line(".")+2, " * Version  : v1.0") 
        call append(line(".")+3, " * Date     : ".strftime("%c")) 
        call append(line(".")+4, " * Brief    : ")
        call append(line(".")+5, "")
        call append(line(".")+6, " * Copyright (C) USTB") 
        call append(line(".")+7, " */") 
        call append(line(".")+8, " ")
    endif
    " include in .c and .cpp
    " if &filetype == 'cpp'
    "     call append(line(".")+9, "#include<iostream>")
    "     call append(line(".")+10, "using namespace std;")
    "     call append(line(".")+11, "")
    " endif
    " if &filetype == 'c'
    "     call append(line(".")+9, "#include<stdio.h>")
    "     call append(line(".")+10, "")
    " endif
    "�½��ļ����Զ���λ���ļ�ĩβ
    autocmd BufNewFile * normal G
endfunc 

""""""""""""""""""""""""""""""""""""""""""""""""""
" F3�Զ����뺯��ע��
""""""""""""""""""""""""""""""""""""""""""""""""""
map <F3> :call SetFuncNotes()<CR>
func SetFuncNotes()
    if &filetype == 'sh'
        call append(line("."), "# @brief   ") 
        call append(line(".")+1, "# @inputs  ") 
        call append(line(".")+2, "# @outputs ") 
        call append(line(".")+3, "# @retval  ") 
    elseif &filetype == 'matlab'
        call append(line("."), "% @brief   ") 
        call append(line(".")+1, "% @inputs  ") 
        call append(line(".")+2, "% @outputs ") 
        call append(line(".")+3, "% @retval  ") 
    else
        call append(line("."), "/*") 
        call append(line(".")+1, " * @brief   ") 
        call append(line(".")+2, " * @inputs  ") 
        call append(line(".")+3, " * @outputs ") 
        call append(line(".")+4, " * @retval  ") 
        call append(line(".")+5, " */") 
    endif
endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""
" ��������
""""""""""""""""""""""""""""""""""""""""""""""""""
"set history=500                 "�趨��ʷ��¼����
set guifont=Courier\ New:h11    "Ӣ�����弰��С 
set gfw=��Բ:h10.5:cGB2312       "�������弰��С
set nocp                        "ȥ��viһ����ģʽ��������ǰ�汾��bug�;���
filetype plugin on              "������
filetype plugin indent on       "����
set completeopt=longest,menu    "���ļ����ͼ��, �������ſ��������ܲ�ȫ
set cursorline                  "ͻ����ʾ��ǰ��
syntax enable
syntax on                       "���Ը���
set cindent
set nu                          "�к���ʾ
colo molokai                    "�趨����,desert/lucius/molokai���ⶼ����
set tabstop=4                   "�趨tab���Ϊ4���ַ�
set shiftwidth=4                "�趨�Զ�����Ϊ4���ַ�
set expandtab                   "��space���tab������
set nobackup                    "�ޱ���
"set noswapfile                  "�޽����ļ�
autocmd InsertLeave * se nocul  "��ǳɫ������ǰ��  
autocmd InsertEnter * se cul    "��ǳɫ������ǰ��
set completeopt=preview,menu    "���벹ȫ
set foldenable                  "�����۵�  
set foldmethod=manual           "�ֶ��۵�  
let Tlist_Exit_OnlyWindow = 1   "���taglist���������һ�����ڣ����˳�VIM
set iskeyword+=_,$,@,%,#,-      "���������ŵĵ��ʲ�Ҫ�����зָ�
set noerrorbells                "��ֹ����������ʾ
set novisualbell                "�޴�����Ļ��˸��ʾ
"��մ��������ն˴���
set t_vb=
set mouse=a                     "ʹ�����

"����ļ��ⲿ�ı䣬�Զ�����
if exists("&autoread")
    set autoread
endif

"vim-markdown�������
"]]: go to next header.
"[[: go to previous header. Contrast with ]c.
"][: go to next sibling header if any.
"[]: go to previous sibling header if any.
"]c: go to Current header.
"]u: go to parent header (Up).
let g:vim_markdown_folding_disable=1    "��ֹmd�ļ����۵�����
let g:vim_markdown_initial_foldlevel=1  "�۵��������ã��迪��vim_markdown_folding_disable

""""""""""""""""""""""""""""""""""""""""""""""""""
" ����tags
""""""""""""""""""""""""""""""""""""""""""""""""""
" Linux Kernel Tags
set tags+=E:\LinuxKernel\linux-3.13\tags

