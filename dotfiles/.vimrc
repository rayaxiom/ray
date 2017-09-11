" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible
set nocompatible               " be iMproved

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
"if has("syntax")
syntax on
"endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"if has("autocmd")
    " When editing a file, always jump to the last cursor position
    "   autocmd BufReadPost *
"    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
"    \   exe "normal g'\"" |
"    \ endif
"endif


"make vim save and load the folding of the document each time it loads
"also places the cursor in the last place that it was left.
"au BufWinLeave ?* mkview 1
"au BufWinEnter ?* silent loadview 1

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
filetype plugin indent on " moved to vundle section
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set hlsearch " Highlight search.
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

"set smartindent
set tabstop=2 " Number of spaces that a tab in a file counts for.
set shiftwidth=2 "Number of spaces to use for each step of (auto)indent. 
set expandtab " In Insert mode: Use the appropriate number of spaces to insert a <Tab>.

set number " Show line number

set cursorline " Show cursor line
set cursorcolumn " Show cursor column

" my attemp to do GNU-style indentation. It failed.
"function! GnuIndent()
"  setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
"  setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
"  setlocal shiftwidth=2
"  setlocal tabstop=2
"endfunction
"au FileType c,cpp,cc call GnuIndent() 



"2match ErrorMsg /\%>79v.\+/ " Highlight chars if col > 79
3match errorMsg /[^\t]\zs\t\+/ " Highlight tabs which are not at the beginning of a line.

"if exists('+colorcolumn')
 set colorcolumn=79
"else
"  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>78v.\+', -1)
"endif


autocmd FileType tex set tw=0
autocmd FileType tex set wm=0
autocmd FileType tex set nowrap

"set tw=77
"set formatoptions+=t

set spell spelllang=en_gb
setlocal spell spelllang=en_gb

set spellfile+=~/.vim/spell/en.utf-8.add
set spellfile+=oneoff.utf-8.add
let g:tex_comment_nospell=1

"setlocal spellfile+=~/.vim/spell/en.utf-8.add
"setlocal spellfile+=oneoff.utf-8.add

" Map primary clipboard to y and clipboard to capital Y, etc...
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

" A somewhat more informative status line.
" Name of the file that I am editing
" Format of the file that I am editing (DOS, Unix)
" File type as recognized by Vim for the current file
" ASCII and hex value for the character under the cursor
" Position in the document as row and column number
" % down the file from the start of the file (based on line number)
" Length of the file (line count)
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\[HEX=\%02.2B]\ [POS=%04l,%04v]\ [%p%%]\ [LEN=%L]
set laststatus=2 " Show the status line.

set tabpagemax=100

" New stuff from Hacking Vim 7.2

" Ctrl+F2 to toggle the menu and toolbar in Gvim p28
map <silent> <C-F2> :if &guioptions =~# 'T' <Bar>
                         \set guioptions-=T <Bar>
                         \set guioptions-=m <bar>
                    \else <Bar>
                         \set guioptions+=T <Bar>
                         \set guioptions+=m <Bar>
                    \endif<CR>

" p30 Tabs
amenu &Tabs.&Next <ESC>:tabnext<cr>
amenu &Tabs.&Delete :confirm tabclose<cr>
amenu &Tabs.&Alternate :confirm tabn #<cr>
amenu Tabs.-SEP- :<cr>
amenu <silent> Tabs.&Next :tabnext<cr>
amenu <silent>Tabs.&Previous :tabprevious<cr>


" make the keys 'kl' to escape to improve efficiency.
imap ;' <Esc>
vmap ;' <Esc>

" make the keys 'kl' to escape to improve efficiency.
"imap kl <Esc>
"vmap kl <Esc>

" make the keys 'kk' to escape, save and quit.
"imap \kl <Esc>:w<cr>
"vmap \kl <Esc>:w<cr>
"nmap \kl <Esc>:w<cr>

" make the keys 'kk' to escape, save and quit.
"imap \kk <Esc>:wq<cr>
"vmap \kk <Esc>:wq<cr>
"nmap \kk <Esc>:wq<cr>


"nmap \kl :w<cr>:!./lll %<cr>
"nmap \ll <Esc> :w<cr>:! lll <cr>
"imap \ll <Esc> :w<cr>:! lll <cr>
"vmap \ll <Esc> :w<cr>:! lll <cr>


"nmap \kk This will be used for compiling c++ file on this computer. Not on a
"server

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif




"vundle start"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'


" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
"Plugin 'scrooloose/syntastic'



" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
Plugin 'c.vim'
"Plugin 'taglist.vim'
Plugin 'snipMate'
Plugin 'FuzzyFinder'




" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
Plugin 'LaTeX-Box-Team/LaTeX-Box'



" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


""""""""""""""""" Old vundle stuff

" original repos on github
"Bundle 'tpope/vim-fugitive'
"Bundle 'Lokaltog/vim-easymotion'
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"Bundle 'tpope/vim-rails.git'
"Bundle 'LaTeX-Box-Team/LaTeX-Box'
"Bundle 'mivok/vimtodo'

" vim-scripts repos

" non github repos
"Bundle 'git://git.wincent.com/command-t.git'
"Bundle 'https://github.com/LaTeX-Box-Team/LaTeX-Box.git'
"Bundle 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'

" ...


"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

"vundle end"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"vim-latex start""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let g:LatexBox_latexmk_options = "-pdfps --shell-escape"

"""let g:LatexBox_latexmk_options = -pdflatex='pdflatex -synctex=1 \%O \%S'"
"""let g:LatexBox_latexmk_options = -pdflatex='pdflatex -synctex=1 -interaction=nonstopmode --shell-escape %O %S'"
let g:LatexBox_latexmk_async=1
let g:LatexBox_latexmk_preview_continuously=1

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
"set shellslash
"
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
"set grepprg=grep\ -nH\ $*
"
" OPTIONAL: This enables automatic indentation as you type.
filetype indent on
"
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
"let g:tex_flavor='latex'



"vim-latex end""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Look in the current directory for tags, work up the tree towards root until one is found.
set tags=./tags;/

"C-\ - Open the definition in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
"A-] - Open the definition in a vertical split
map <A-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" search and replace highlighted text
" By pressing ctrl + r in the visual mode you will be prompted to 
" enter text to replace with. 
" Press enter and then confirm each change you agree with 'y' or 
" decline with 'n'.
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
vnoremap <C-t> "hy:%s/<C-r>h/\\ctt{<C-r>h}/gc<left><left><left>

:set dictionary-=/usr/share/dict/words dictionary+=/usr/share/dict/words
:set complete-=k complete+=k


" ------------------------------------------------
"
"
"
"
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"let g:syntastic_text_checkers = ['language_check']
"let g:syntastic_text_language_check_args = '--language=en-UK'





