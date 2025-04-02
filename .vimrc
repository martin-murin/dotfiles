""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Martin Murin
" 
" VIM - Vi IMproved 9.1
" Install plugins with VimPlug:
" :source %
" :PlugInstall
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

"{{ Git }}
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
"{{ Productivity }}
Plug 'junegunn/vim-easy-align'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
"{{ Fuzzy find }}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"{{ Status line }}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"{{ Syntax highlighting }}
Plug 'scrooloose/syntastic'
Plug 'vim-python/python-syntax'
Plug 'othree/xml.vim'
"{{ Color themes }}
Plug 'morhetz/gruvbox'

call plug#end()

filetype plugin on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Commands and Aliases
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -nargs=* Fzf FZF<args>
cnoreabbrev fzf FZF
nnoremap <silent> <C-x> :FZF<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Color Theme and Highlighting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Make sure vim uses 256 colour terminal
if $TERM == "Xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
        set t_Co=256
endif

let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
set bg=dark
set termguicolors

"Enable all python syntax highlighting
let g:python_highlight_all = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Remap Keys
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Use \m to toggle mouse
:nmap \m :exec &mouse!=""? "set mouse=" : "set mouse=nv"<CR>

"Use \l to toggle line numbers on and off
:nmap \n :setlocal number!<CR>
:nmap \N :setlocal relativenumber!<CR>

"Use \o to enable paste mode
:nmap \o :setlocal paste!<CR>

"Map \c to clear the highlighting from hlsearch
:nmap \c :nohlsearch<CR>

"Make j/down and k/up move down/up one row instead of one line! Useful when one line spans ...multiplie rows.
:nmap j gj
:nmap k gk
:nmap <Down> gj
:nmap <Up> gk

"Move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Adjust split size
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

"Change 2 split windows from vert to horiz or horiz to vert
map <Leader>th <C-w>t<C-w>H
map <Leader>tk <C-w>t<C-w>K

"Use CTRL+T to open NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
"Uncomment to autostart the NERDTree
"autocmd vimenter * NERDTree

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Search, Spelling, Completion, Formatting,
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Search highlights for the current search
:set hlsearch
:highlight CurSearch term=reverse cterm=reverse ctermfg=208 ctermbg=234 gui=reverse guifg=#fe8019 guibg=#1d2021 

"Highlight text as you type when searching for text
:set incsearch

"Make searches case-insensitive
:set ignorecase

"Make searches case-sensitive if you use capital letters
:set smartcase

"Shows more information in the last line when a command is used
set showcmd

"Spell Checking. Use \s to switch it on
if version >= 700
        set spl=en spell
        set nospell
endif
:nmap \s :set spell!<CR>

"Activates tab completion for commands
set wildmenu
set wildmode=list:longest,full

"When a line exceeds the length of the screen and is continued on the next line,
"displacs a character to show the line has been continued
let &showbreak = '...'

"wrap long lines
set wrap
set cpo=n

"Copies indent from previous line
set autoindent

"adds a tab after certain characters (like {....)
set smartindent

"When pressing the tab key, uses multiple spaces
set expandtab
"set smarttab

"Reduce size of tabs from 8
set shiftwidth=4
set softtabstop=4

"Show current position
set ruler

"Fix backspace. ie., can backspace across lines and indents.
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

"Set legacy compatibility mode off
set nocp

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Status Line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Always show the status line
set laststatus=2

"Airline
let g:airline_theme='ayu_dark'
let g:airline#extensions#ale#enabled = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#searchcount#show_search_term = 0
let g:airline_section_c = '%{pathshorten(getcwd())} %t %m'
let g:airline_section_z='%p%% : %l/%L : %c'
