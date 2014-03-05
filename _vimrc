" ==============================================================================
" ## Plugins
" echofunc           ����������ʾ
" taglist            ��ǩ
" winmanager         ���ڹ��� ��ݼ�wm
" bufexplore         ���ļ��༭������� ��ݼ�\be \bs \bv
" omnicppcomplete    C/C++�����Զ���ʾ
" colors/*           ����VIM����
" vim-markdown       Markdown�﷨���� https://github.com/plasticboy/vim-markdown
" NERDTree           �ļ������������
"
" ## Features
" 1. �������/�˵�����
" 2. ������״̬����Ĭ�����ع������Ͳ˵�����F2��ݼ��ɴ�
" 3. ��ݼ���Ctrl+]ִ��ctags��ת��Ctrl+T���أ�F12��ݼ��Զ�����/����tags�ļ�,
"    ��ͨģʽ��wm��VIM����wmmanager����
" 4. �Զ���ȫ([{������
" 5. �Զ�Ϊ.c.h�Ȳ����ļ�ͷע��
" 6. F3��ݼ��Զ����뺯��ע��
" 7. ������������Ϊ��Բ��Ӣ������ΪCourier New
" 8. �﷨����
" 9. omnicppcompleteʵ���Զ�C/C++���벹ȫ
" 10. ��ǰ�и���
" 11. ʹ��molokai����TextMate����
" 12. ʹ��vim-markdown���ʵ��Markdown�﷨������
" 13. Visualģʽ��ѡ��ע�ʹ���� \ccע�� \co��ע��
" 14. Visualģʽ��ѡ���ַ�����ʹ��#,*,gv��ݼ��ɿ���ʵ���ĵ��ڶ�ѡ���ַ����Ĳ���
" 15. ���NERDTree�������NERDTree���ɵ�winmanager������. ��ԭNERDTree�Ĵ��ļ���ݼ�O�޸�ΪEnter.
" 
" ## Key Mapping
" 1. F2                 �򿪹������Ͳ˵���
" 2. Ctrl+]             Ctags��ת 
" 3. Ctrl+T             Ctags����
" 4. F12                ���������tags�ļ�
" 5. wm                 ��winmanager��ർ������
" 6. F3                 ���뺯��ע��
" 7. \cc                ע�ʹ����
" 8. \co                ��ע�ʹ����
" 9. #,*                Visualģʽ�¶�ѡ���ַ�����
" 10.NERDTree/Enter:    ��NERDTree�д�ѡ���ļ�
" 
" Author: Zuoxin,Xiahou  (xiahouzuoxin@163.com)
" Copyright (c) MICL,USTB
" ==============================================================================


" ����ƽ̨��Ϣ
function! MySys()
  if has("win32")
    return "windows"
  else
    return "linux"
  endif
endfunction

" ����ϵͳĬ��vimrc����
source $VIMRUNTIME/vimrc_example.vim

" ------------------------------------------------------------------------------
" FOR GVIM in windows
" ------------------------------------------------------------------------------
if MySys() == 'windows'
source $VIMRUNTIME/mswin.vim
behave mswin

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
endif

" ------------------------------------------------------------------------------
" �������/�˵�����
" ------------------------------------------------------------------------------
"��������
set encoding=prc
set termencoding=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
"��������
set langmenu=zh_CN.UTF-8
set helplang=cn
" ����˵�����,set encoding=utf-8����ֲ˵����룬�������ÿɽ��
let $LANG = 'zh_CN.UTF-8'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim


" ------------------------------------------------------------------------------
" VIM���ڽ�������
" ------------------------------------------------------------------------------
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

" ------------------------------------------------------------------------------
" ����ı�������
" ------------------------------------------------------------------------------
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

" ------------------------------------------------------------------------------
" �Զ���ȫ��������
" ------------------------------------------------------------------------------
let g:CompleteBracket=1         "���Զ���ȫ���ű���
if g:CompleteBracket==1
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
endif
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

" ------------------------------------------------------------------------------
" �Զ������ļ�ͷ
" ------------------------------------------------------------------------------
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.v,*.m exec ":call SetTitle()" 
autocmd BufNewFile * normal G  "�½��ļ����Զ���λ���ļ�ĩβ
func SetTitle() " ���庯��SetTitle���Զ������ļ�ͷ  
    if &filetype == 'sh'  "����ļ�����Ϊ.sh�ļ� 
        call setline(1,"#########################################################################") 
        call append(line("."), "# FileName : ".expand("%")) 
        call append(line(".")+1, "# Author   : xiahouzuoxin @163.com") 
        call append(line(".")+2, "# Date     : ".strftime("%c")) 
        call append(line(".")+3, "#########################################################################") 
        call append(line(".")+4, "# ") 
        call append(line(".")+5, "#!/bin/bash") 
        call append(line(".")+6, "") 
    elseif &filetype == 'matlab' 
        call setline(1, "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%") 
        call append(line("."), "% FileName : ".expand("%")) 
        call append(line(".")+1, "% Author   : xiahouzuoxin @163.com") 
        call append(line(".")+2, "% Version  : v1.0") 
        call append(line(".")+3, "% Date     : ".strftime("%c")) 
        call append(line(".")+4, "% Brief    : ")
        call append(line(".")+5, "% ")
        call append(line(".")+6, "% Copyright (C) MICL,USTB") 
        call append(line(".")+7, "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%") 
        call append(line(".")+8, " ")
    else 
        call setline(1, "/*") 
        call append(line("."), " * FileName : ".expand("%")) 
        call append(line(".")+1, " * Author   : xiahouzuoxin @163.com") 
        call append(line(".")+2, " * Version  : v1.0") 
        call append(line(".")+3, " * Date     : ".strftime("%c")) 
        call append(line(".")+4, " * Brief    : ")
        call append(line(".")+5, " * ")
        call append(line(".")+6, " * Copyright (C) MICL,USTB") 
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
endfunc 

" ------------------------------------------------------------------------------
" F3�Զ����뺯��ע��
" ------------------------------------------------------------------------------
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

" ------------------------------------------------------------------------------
" ��������
" ------------------------------------------------------------------------------
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
set cindent                     "C���Ը�ʽ����
set smartindent                 "��������
set nu                          "�к���ʾ
colo molokai                    "�趨����,desert/lucius/molokai���ⶼ����
set tabstop=4                   "�趨tab���Ϊ4���ַ�
set shiftwidth=4                "�趨�Զ�����Ϊ4���ַ�
set expandtab                   "��space���tab������
set nobackup                    "�ޱ���
"set noswapfile                  "�޽����ļ�,ע�⣬�����˳����޷��ָ�
autocmd InsertLeave * se nocul  "��ǳɫ������ǰ��  
autocmd InsertEnter * se cul    "��ǳɫ������ǰ��
set completeopt=preview,menu    "���벹ȫ
"set foldenable                  "�����۵�  
"set foldmethod=indent           "�۵���ʽ,����indent,manual,marker�� 
let Tlist_Exit_OnlyWindow = 1   "���taglist���������һ�����ڣ����˳�VIM
set iskeyword+=_,$,@,%,#,-      "���������ŵĵ��ʲ�Ҫ�����зָ�
set noerrorbells                "��ֹ����������ʾ
set novisualbell                "�޴�����Ļ��˸��ʾ
set t_vb=                       "��մ��������ն˴���
set mouse=a                     "ʹ�����
" set lbr                         "��breakat�ַ������������һ���ַ�������
" set textwidth=82                "��������������������Զ�����
" set fo+=m                       "���ֳ�����������Զ�����
" set cc=82                       "��cc�м�������������
set so=5                        "��������������ٱ�������Ļ����scrolloff
set cmdheight=1                 "�����и߶�����
set hlsearch                    "�������ַ�����

" ��82��������»���
au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 82 . 'v.\+', -1)


"����ļ��ⲿ�ı䣬�Զ�����
if exists("&autoread")
    set autoread
endif

"�´ο���VIM���Զ�����궨λ���رյ�λ��
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" ------------------------------------------------------------------------------
" vim-markdown�������
" ------------------------------------------------------------------------------
"]]: go to next header.
"[[: go to previous header. Contrast with ]c.
"][: go to next sibling header if any.
"[]: go to previous sibling header if any.
"]c: go to Current header.
"]u: go to parent header (Up).
let g:vim_markdown_folding_disable=1    "��ֹmd�ļ����۵�����
let g:vim_markdown_initial_foldlevel=1  "�۵��������ã��迪��vim_markdown_folding_disable

" ------------------------------------------------------------------------------
" Ctags��Taglist����
" ------------------------------------------------------------------------------
"���ctags��gvim����ͬһĿ¼��������ctags·��
"let Tlist_Ctags_Cmd = 'D:\ctags58\ctags.exe'

"Taglist��ת��ݼ�
nmap <c-]> g<c-]>               "��Ctrl+]��ݼ�ӳ�䵽g Ctrl+]

let Tlist_Show_One_File=1       "��ͬʱ��ʾ����ļ��� tag ��ֻ��ʾ��ǰ�ļ���

"F12����/����tags�ļ� 
set tags=tags 
set autochdir
function! UpdateTagsFile() 
    silent !ctags -R --c++-kinds=+p --fields=+ianS --extra=+q 
endfunction 
nmap <F12> :call UpdateTagsFile()<CR>

" ------------------------------------------------------------------------------
" NERDTree����
" ------------------------------------------------------------------------------
let g:NERDTree_title="[NERDTree]"
function! NERDTree_Start()  
    exec 'NERDTree'  
endfunction  
  
function! NERDTree_IsValid()  
    return 1  
endfunction 

"let NERDTreeChDirMode=2         "ѡ��root������Ϊ��ǰĿ¼
let NERDTreeShowBookmarks=1     "��ʾ��ǩ
"let NERDTreeMinimalUI=1         "����ʾ�������
let NERDTreeDirArrows=0         "Ŀ¼��ͷ 1 ��ʾ��ͷ  0��ͳ+-|��
let NERDTreeMouseMode=2         "����ʹ�������ļ�

" ------------------------------------------------------------------------------
" winmanager����
" ------------------------------------------------------------------------------
"let g:winManagerWindowLayout="FileExplorer|TagList,BufExplorer"  "����wm����ָ�
let g:winManagerWindowLayout="NERDTree|TagList,BufExplorer"  "����wm����ָ�: NERDTree�滻FileExplorer
let g:AutoOpenWinManager=0      "��Ϊ1���ڽ���vimʱ�Զ���winmanager
let g:winManagerWidth = 30      "����winmanager���
nmap wm :WMToggle<cr>           "wm��ݼ����ڴ�winmanager

" ------------------------------------------------------------------------------
" Visualģʽ�¿���ע�ʹ����
" Refrence to comment.vim, version 1.0
" jerome.plut at normalesup dot org
" ��ݼ���\ccע�ͣ�\co��ע��
" ------------------------------------------------------------------------------
function! CommentStyle(s)
  if match (a:s, '@') >= 0
  let str1 = substitute (a:s, '@.*$', '', '')
    let str2 = substitute (a:s, '^.*@', '', '')
  else
    let str1 = a:s. ' '
    let str2 = ''
  endif
  let pat1 = substitute (str1, '[][*^.$~]', '\\&', 'g')
  let pat1 = substitute (pat1, '\s*$', '\\s*', '')
  let str1 = substitute (str1, '&', '\\&', 'g')
  if str2 == ''
    " s:l1 contains the computed patterns to comment, s:l2 those to
    " uncomment
    let s:l1 = [ 'sm@^@'.str1.'@e' ]
    let s:l2 = [ 'sm@^\s*'.pat1.'@@e' ]
  else
    let pat2 = substitute (str2, '[][*^.$~]', '\\&', 'g')
    let pat2 = substitute (pat2, '^\s*', '\\s*', '')
    let str2 = substitute (str2, '&', '\\&', 'g')
    " protect any comment that becomes nested
    " with non-ASCII chars, to avoid collisions
    let s:l1 = ['sm@?��@?���@ge', 'sm@'.pat1.'@?��?@ge', 'sm@^@'.str1.'@e']
    let s:l1+= ['sm@��?@���?@ge', 'sm@'.pat2.'@?��?@ge', 'sm@$@'.str2.'@e']
    let s:l2 = ['sm@^\s*'.pat1.'@@e', 'sm@?��?@'.str1.'@ge', 'sm@?���@?��@ge']
    let s:l2+= ['sm@'.pat2.'\s*$@@e', 'sm@?��?@'.str2.'@ge', 'sm@���?@��?@ge']
  endif
endfunction

function! Comment() range
  for s in s:l1
    execute ':sil '.a:firstline.','.a:lastline.s
  endfor
endfunction

function! UnComment() range
  let pre = ':sil '.a:firstline.','.a:lastline
  for s in s:l2
    execute ':sil '.a:firstline.','.a:lastline.s
  endfor
endfunction

command! -nargs=1 CommentStyle call CommentStyle (<f-args>)

map <silent> \cc :call Comment()<CR>
map <silent> \co :call UnComment()<CR>
map =c :CommentStyle<Space>

"��ͬ�����ļ�ʹ�ò�ͬ��ע�ͷ���
au FileType * CommentStyle #
au FileType vim CommentStyle "
au FileType c,cpp,h,verilog CommentStyle //
au FileType html CommentStyle <!-- @ -->
au FileType python CommentStyle """ @ """
" This makes quotes in emails
au FileType mail CommentStyle >

" ------------------------------------------------------------------------------
" Visualģʽ��ѡ����ң��ǳ����Ĳ���
" - Using the "*" key while in visual mode searches for the current selection (forwards)
" - Using the "#" key while in visual mode searches for the current selection (backwards)
" - Pressing "gv" will vimgrep the current selection
" ------------------------------------------------------------------------------
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"Basically you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>
vnoremap <silent> gv :call VisualSearch('gv')<CR>

" ------------------------------------------------------------------------------
" ����tags
" ------------------------------------------------------------------------------
" Linux Kernel Tags
set tags+=E:\LinuxKernel\linux-3.13\tags

