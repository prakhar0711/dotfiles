" Set leader to comma
let mapleader = " "

" Yank to system clipboard with <leader>y (e.g., \y)
nnoremap <leader>y "+y
vnoremap <leader>y "+y

" Paste from system clipboard with <leader>p
nnoremap <leader>p "+p
nnoremap <leader>P "+P

set clipboard=unnamedplus

set number
set relativenumber
syntax on
filetype plugin indent on

" ---------------------------------------------
" Dave Eddy's vimrc
" dave@daveeddy.com
" License MIT
"
" Credits
"   https://github.com/Happy-Dude/
" ---------------------------------------------
set nocompatible		" Disable VI Compatibility

" ---------------------------------------------
" Init - plugins
" ---------------------------------------------
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'

Plug 'rust-lang/rust.vim'
Plug 'dense-analysis/ale'
call plug#end()

" ---------------------------------------------
" Vim Options
" ---------------------------------------------
set autoindent			" Default to indenting files
set backspace=indent,eol,start	" Backspace all characters
set formatoptions-=t		" Don't add line-breaks for lines over 'textwidth' characters
set hlsearch			" Highlight search results
set nonumber			" Disable line numbers
set nostartofline		" Do not jump to first character with page commands
set ruler			" Enable the ruler
set showmatch			" Show matching brackets.
set showmode			" Show the current mode in status line
set showcmd			" Show partial command in status line
set tabstop=8			" Number of spaces <tab> counts for
set textwidth=80		" 80 columns
set title			" Set the title

" ---------------------------------------------
" Theme / Color Scheme
" ---------------------------------------------
set background=light            " Light background is best
hi Comment ctermfg=63		" Brighten up comment colors


" ---------------------------------------------
" File/Indenting and Syntax Highlighting
" ---------------------------------------------
if has("autocmd")
	filetype plugin indent on

	" Jump to previous cursor location, unless it's a commit message
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
	autocmd BufReadPost COMMIT_EDITMSG exe "normal! gg"

	" Chef/Ruby
	autocmd BufNewFile,BufRead                  *.rb setlocal filetype=ruby
	autocmd FileType                            ruby setlocal sw=2 sts=2 et

	" Yaml
	autocmd BufNewFile,BufRead                  *.yaml,*.yml setlocal filetype=yaml
	autocmd FileType                            yaml         setlocal sw=2 sts=2 et

	" JavaScript files
	autocmd BufNewFile,BufReadPre,FileReadPre   *.js        setlocal filetype=javascript
	autocmd FileType                            javascript  setlocal sw=4 sts=4 et

	" JSON files
	autocmd BufNewFile,BufReadPre,FileReadPre   *.json setlocal filetype=json
	autocmd FileType                            json   setlocal sw=2 sts=2 et

	" Objective C / C++
	autocmd BufNewFile,BufReadPre,FileReadPre   *.m    setlocal filetype=objc
	autocmd FileType                            objc   setlocal sw=4 sts=4 et
	autocmd BufNewFile,BufReadPre,FileReadPre   *.mm   setlocal filetype=objcpp
	autocmd FileType                            objcpp setlocal sw=4 sts=4 et

	" Rust files
	" autocmd BufNewFile,BufReadPre,FileReadPre   *.rs   setlocal filetype=rust
	autocmd FileType                            rust   setlocal sw=4 sts=4 et textwidth=80

	" Python files
	autocmd BufNewFile,BufReadPre,FileReadPre   *.py   setlocal filetype=python
	autocmd FileType                            python setlocal sw=4 sts=4 et

	" Markdown files
	autocmd BufNewFile,BufRead,FileReadPre      *.md,*.markdown setlocal filetype=markdown
	autocmd FileType                            markdown      setlocal sw=4 sts=4 et spell
	" Jekyll posts ignore yaml headers
	autocmd BufNewFile,BufRead                  */_posts/*.md syntax match Comment /\%^---\_.\{-}---$/
	autocmd BufNewFile,BufRead                  */_posts/*.md syntax region lqdHighlight start=/^{%\s*highlight\(\s\+\w\+\)\{0,1}\s*%}$/ end=/{%\s*endhighlight\s*%}/

	" EJS javascript templates
	autocmd BufNewFile,BufRead,FileReadPre      *.ejs setlocal filetype=html

	" TXT files
	autocmd FileType                            text setlocal spell
endif

" ---------------------------------------------
" Highlight Unwanted Whitespace
" ---------------------------------------------
highlight RedundantWhitespace ctermbg=green guibg=green
match RedundantWhitespace /\s\+$\| \+\ze\t/

" ---------------------------------------------
" Spell Check Settings
" ---------------------------------------------
set spelllang=en
highlight clear SpellBad
highlight SpellBad term=standout cterm=underline ctermfg=red
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

" ---------------------------------------------
" Plugins
" ---------------------------------------------
let g:airline_powerline_fonts = 0
let g:airline_theme = "deus"
let g:rust_recommended_style = 1
let g:ale_linters = {
\  'bash': [],
\  'sh': [],
\  'c': ['clangd'],
\  'cpp': ['clangd'],
\  'rust': ['analyzer'],
\}
let g:ale_completion_enabled = 0
let g:vim_markdown_folding_disabled = 1

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm(): "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <c-@> coc#refresh()
" ---------------------------------------------
" Source local config
" ---------------------------------------------
if filereadable(expand("~/.vimrc.local"))
	source ~/.vimrc.local
endif
if filereadable(expand("~/.vimrc.indent"))
	source ~/.vimrc.indent
endif
set t_Co=256

" Rose Pine Dawn palette
let s:bg        = "#faf4ed"
let s:fg        = "#575279"
let s:rose      = "#b4637a"
let s:pine      = "#286983"
let s:gold      = "#d7827e"
let s:surf      = "#908caa"
let s:highlight = "#56949f"

" Normal text
execute 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
execute 'hi CursorLine guibg=#f2ede9'
execute 'hi Visual guibg=#e6e1dc'

" CoC Completion Menu
execute 'hi Pmenu guifg=' . s:fg . ' guibg=#f2ede9'
execute 'hi PmenuSel guifg=#faf4ed guibg=' . s:highlight
execute 'hi PmenuThumb guibg=' . s:pine

" CoC Floating Windows
execute 'hi CocFloating guifg=' . s:fg . ' guibg=#f2ede9'
execute 'hi CocFloatingBorder guifg=' . s:surf . ' guibg=#f2ede9'

" CoC Diagnostics
execute 'hi CocError guifg=' . s:rose
execute 'hi CocWarning guifg=' . s:gold
execute 'hi CocInfo guifg=' . s:pine
execute 'hi CocHint guifg=' . s:highlight

" Signs in sign column
execute 'hi CocErrorSign guifg=' . s:rose
execute 'hi CocWarningSign guifg=' . s:gold
execute 'hi CocInfoSign guifg=' . s:pine
execute 'hi CocHintSign guifg=' . s:highlight

" Status messages
execute 'hi CocStatusLine guifg=' . s:fg . ' guibg=#f2ede9'
execute 'hi CocStatusLineNC guifg=' . s:surf . ' guibg=#f2ede9'

