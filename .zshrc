" Basic settings
syntax enable
set encoding=utf-8
set fileencodings=utf-8
set background=dark
set signcolumn=yes
set updatetime=100
autocmd ColorScheme *
    \ hi CocUnusedHighlight cterm=underline gui=underline guifg=#808080
" for plugins
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    "    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" plugins
call plug#begin('~/.vim/plugged')
" lsp config
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'mbbill/undotree'
    Plug 'luochen1990/rainbow'
    Plug 'tpope/vim-commentary'
    Plug 'sheerun/vim-polyglot'
    Plug 'liuchengxu/space-vim-theme'
call plug#end()
" checks to see if the terminal has the colors
if (has("termguicolors"))
 set termguicolors
endif
" set color scheme of text and airline
colorscheme space_vim_theme
let g:airline_theme="sol"
highlight SignColumn ctermbg=NONE guibg=NONE
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight StatusLine ctermbg=NONE guibg=NONE
highlight StatusLineNC ctermbg=NONE guibg=NONE

" set error line stuff
highlight CocErrorHighlight ctermfg=red guifg=red cterm=underline gui=underline
highlight CocErrorSign ctermfg=red guifg=red cterm=underline gui=underline
highlight CocErrorVirtualText ctermfg=red guifg=red cterm=underline gui=underline
" Change only underline colors for better visibility

" Leader key
let mapleader = " "

" General editing settings
set autoindent
set smartindent
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set nowrap
set number
set relativenumber
set scrolloff=6
set cursorline
set noerrorbells
set visualbell
set t_vb=
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set ignorecase
set smartcase
set incsearch
set hlsearch
set textwidth=80
set colorcolumn=80

" Autocmd settings for various file types custom indents
augroup FiletypeSettings
  autocmd!
  autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.html,*.json,*.yml,*.yaml,*.sql,*.css,*.jsx setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.rs,*.java setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.js,*.ts,*.tsx setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" Key mappings
" Clipboard operations need to install vim that has clipboard enabled
" sudo apt-get install vim-gtk3
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <Leader>Y "+Y

" remove highlighting after finding search within file
nnoremap <CR> :noh<CR><CR>:<backspace>

" replacement remap 
noremap S :%s//g<Left><Left>

" source current file
nmap <Leader>, :w<CR>:so %<CR>

" open netrw
nmap <Leader><Leader> :Ex<CR>

" Move selected lines down in Visual mode
vmap J :m '>+1<CR>gv=gv

" Move selected lines up in Visual mode
vmap K :m '<-2<CR>gv=gv

" enable mouse
set mouse=a

" joins lines and return to same position
nnoremap J mzJ`z

" centering screen after scrolling down or up
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" go to last search spot
nnoremap N Nzzzv

" Completion navigation these are with the base key maps defined
" inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "\<C-n>"
" inoremap <silent><expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<C-p>"

" Trigger completion manually with Ctrl-Space
inoremap <silent><expr> <c-@> coc#refresh()

" Confirm completion with Ctrl-y
" inoremap <silent><expr> <C-y> coc#pum#confirm()


" LSP key mappings
" jumps to the definition of the symbol
nmap <silent> gd <Plug>(coc-definition)
" shows references to symbol
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" rename symbol
nmap <leader>rn <Plug>(coc-rename)

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

vmap <C-i> <Plug>(coc-snippets-select)

" Use <C-i> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-i>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" install Coc extensions
" CocInstall coc-snippets coc-vimlsp coc-sh coc-clangd coc-tailwindcss3 coc-html coc-java coc-tsserver coc-json coc-pyright coc-rust-analyzer coc-tabnine

" install all treesitter languages 
" TSInstall vim bash c cpp css html java typescript javascript json python rust 

" Show all diagnostics all errors in the file and what line they are in
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>

" Show server commands that can apply to file or project linting formatting etc
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>

" Force filetype for specific extensions
autocmd BufRead,BufNewFile *.jsx set filetype=javascriptreact
autocmd BufRead,BufNewFile *.tsx set filetype=typescriptreact

" comments out code
nnoremap <leader>c :Commentary<cr>
vnoremap <leader>c :Commentary<cr>

" shows undotree
nnoremap <leader>u :UndotreeToggle<cr>

