call plug#begin()
Plug 'ThePrimeagen/vim-be-good'
Plug 'arzg/vim-corvine'
Plug 'cocopon/iceberg.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ervandew/supertab'
Plug 'jiangmiao/auto-pairs'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'prettier/vim-prettier'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'xuyuanp/nerdtree-git-plugin'
call plug#end()

syntax on

set number
set relativenumber
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab
set ignorecase
set smartcase
set hidden
set incsearch

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['python']
let g:syntastic_cpp_checkers = ['clang_check', 'gcc']
let g:syntastic_java_checkers = ['checkstyle', 'javac']
let g:syntastic_ignore_files = []
let g:syntastic_mode_map = {
            \ "mode": "active",
            \ "active_filetypes": [],
            \ "passive_filetypes": ['sh'] }

let g:vimsence_editing_state = 1
let g:vimsence_editing_details = 1

unlet g:vimsence_editing_state
unlet g:vimsence_editing_details
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1

map <C-h> :wincmd h<CR>
map <C-j> :wincmd j<CR>
map <C-k> :wincmd k<CR>
map <C-l> :wincmd l<CR>
map <C-n> :NERDTreeToggle<CR>
map <C-f> :Prettier<CR>

set background=dark
colorscheme iceberg
let g:airline_theme='iceberg'

