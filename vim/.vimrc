set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'derekwyatt/vim-scala'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-fugitive'
Plugin 'fatih/vim-go'
Plugin 'SirVer/ultisnips'
Plugin 'FooSoft/vim-argwrap'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on
set t_Co=16
let g:solarized_termcolors=16
let g:solarized_termtrans = 1
set background=light
colorscheme solarized

"------------------------------------------------------------------------------
" general.
"------------------------------------------------------------------------------"

set undolevels=200      " Number of undo levels.
set scrolloff=10        " Keep a context (rows) when scrolling vertically.
set sidescroll=5        " Keep a context (columns) when scrolling horizontally.
set tabpagemax=1000     " Maximum number of tabs to open by the -p argument.
set esckeys             " Cursor keys in insert mode.
set ttyfast             " Improves redrawing for newer computers.
set lazyredraw          " Don't redraw during complex operations (e.g. macros).
set autowrite           " Automatically save before :next, :make etc.
set confirm             " Ask to save file before operations like :q or :e fail.
set magic               " Use 'magic' patterns (extended regular expressions).
set hidden              " Allow switching edited buffers without saving.
set nostartofline       " Keep the cursor in the current column with page cmds.
set nojoinspaces        " Insert just one space joining lines with J.
set showcmd             " Show (partial) command in the status line.
set noshowmatch         " Don't show matching brackets when typing them.
set showmode            " Show the current mode.
set shortmess+=aIoOtT   " Abbreviation of messages (avoids 'hit enter ...').
set path=$PWD/**        " Include everything under $PWD into the path.
set nrformats-=octal    " Make incrementing 007 result into 008 rather than 010.

" Backup and swap files.
set nobackup            " Disable backup files.
set noswapfile          " Disable swap files.
set nowritebackup       " Disable auto backup before overwriting a file.

" History
set history=1000        " Number of lines of command line history.
set viminfo='100,\"500,r/mnt,r~/mnt,r/media " Read/write a .viminfo file.
set viminfo+=h          " Do not store searches.

" Line numbers.
set number              " Show line numbers.

" Splitting.
set splitright          " Open new vertical panes in the right rather than left.
set splitbelow          " Open new horizontal panes in the bottom rather than top.

" Security.
set secure              " Forbid loading of .vimrc under $PWD.
set nomodeline          " Modelines have been a source of vulnerabilities.

" Indention and formatting.
"set autoindent          " Indent a new line according to the previous one.
"set copyindent          " Copy (exact) indention from the previous line.
"set nopreserveindent    " Do not try to preserve indention when indenting.
"set nosmartindent       " Turn off smartindent.
"set nocindent           " Turn off C-style indent.
"set fo+=q               " Allow formatting of comments with "gq".
"set fo-=r fo-=o         " Turn off automatic insertion of comment characters.
"set fo+=j               " Remove a comment leader when joining comment lines.
"filetype indent off     " Turn off indention by filetype.
" Override the previous settings for all file types (some filetype plugins set
" these options to different values, which is really annoying).
"au FileType * set autoindent nosmartindent nocindent fo+=q fo-=r fo-=o fo+=j

" Whitespace.
set tabstop=2           " Number of spaces a tab counts for.
set shiftwidth=2        " Number of spaces to use for each step of indent.
"set shiftround          " Round indent to multiple of shiftwidth.

" Wrapping.
set wrap                " Enable text wrapping.
set linebreak           " Break after words only.
set display+=lastline   " Show as much as possible from the last shown line.
set textwidth=0         " Don't automatically wrap lines.
" Disable automatic wrapping for all files (some filetype plugins set this to
" a different value, which is really annoying).
au FileType * set textwidth=0

let mapleader=","
inoremap jk <esc>
cmap w!! w !sudo tee > /dev/null %

nmap <Space><Space> :b#<cr>

set pastetoggle=<F3>

nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>t :CtrlP<CR>
nmap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>

" Statusline.
set laststatus=2        " Always display a statusline.
set noruler             " Since I'm using a statusline, disable ruler.
set statusline=%<%f                          " Path to the file in the buffer.
set statusline+=\ %h%w%m%r%k                 " Flags (e.g. [+], [RO]).
set statusline+=\ [%{(&fenc\ ==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")},%{&ff}] " Encoding and line endings.
set statusline+=\ %y                         " File type.
" go command status (requires vim-go)
set statusline+=%#goStatuslineColor#
set statusline+=%{go#statusline#Show()}
set statusline+=%*

" Tell Vim which characters to show for expanded tabs, trailing whitespace,
" ends of lines, and non-breakable space.
set listchars=tab:>-,trail:#,eol:$,nbsp:~,extends:>,precedes:<

" Searching.
set hlsearch            " Highlight search matches.
set incsearch           " Incremental search.
" Case-smart searching (make /-style searches case-sensitive only if there is
" a capital letter in the search expression).
set ignorecase
set smartcase

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

"------------------------------------------------------------------------------
" Colors.
"------------------------------------------------------------------------------

"augroup colors_and_highlighting
"au!
"" Highlight mixture of spaces and tabs.
"au BufEnter * hi SpacesTabsMixtureGroup guibg=gray19 guifg=red ctermbg=236 ctermfg=red
"" Highlight mixtures only when there are at least two successive spaces to
"" prevent highlighting of false positives (e.g. in git diffs, which may begin
"" with a space).
"au BufEnter * match SpacesTabsMixtureGroup /^  \+\t\+[\t ]*\|^\t\+  \+[\t ]*/
"
"" Statusline.
"au BufEnter * hi StatusLine guibg=black guifg=white ctermbg=black ctermfg=white
"au BufEnter * hi StatusLineNC guibg=black guifg=gray70 ctermbg=black ctermfg=gray
"
"" Characters exceeding textwidth or 80 characters.
"au BufEnter * hi ExceedCharsGroup guibg=darkblue guifg=white ctermbg=darkblue ctermfg=white
"
"" Wild menu.
"au BufEnter * hi Pmenu guibg=gray30 guifg=white ctermbg=darkgray ctermfg=white
"au BufEnter * hi PmenuSel guibg=white guifg=black ctermbg=white ctermfg=black
"
"" Folds.
"au BufEnter * hi Folded guibg=gray30 guifg=white ctermbg=darkgray ctermfg=white
"au BufEnter * hi FoldColumn guibg=gray30 guifg=white ctermbg=darkgray ctermfg=white
"
"" Tab colors.
"au BufEnter * hi TabLine guibg=black guifg=gray ctermbg=black ctermfg=gray
"au BufEnter * hi TabLineSel guibg=black guifg=white ctermbg=black ctermfg=white
"au BufEnter * hi TabLineFill guibg=black guifg=black ctermbg=black ctermfg=black
"
"" Colorcolumn.
"au BufEnter * hi ColorColumn guibg=gray19 guifg=white ctermbg=236 ctermfg=white
"
"" Messages.
"au BufEnter * hi MoreMsg guibg=black guifg=green1 ctermbg=black ctermfg=46
"
"" Splits.
"au BufEnter * hi VertSplit guibg=white guifg=black ctermbg=white ctermfg=black
"
"" Cursor.
"au BufEnter * hi Cursor guibg=white guifg=bg
"
"" Visual selection.
"au BufEnter * hi Visual guibg=black guifg=gray ctermfg=gray
"
"" Use the same color in the sign column as it is used in the numbers column.
"au BufEnter * hi clear SignColumn
"augroup end

" Make Ctrl-e jump to the end of the current line in the insert mode. This is
" " handy when you are in the middle of a line and would like to go to its end
" " without switching to the normal mode.
inoremap <C-e> <C-o>$

" Allows you to easily replace the current word and all its occurrences.
nnoremap <Leader>rc :%s/\<<C-r><C-w>\>/
cnoremap <Leader>rc y:%s/<C-r>"/

" Allows you to easily change the current word and all occurrences to
" something else. The difference between this and the previous mapping is that the
" mapping below pre-fills the current word for you to change.
nnoremap <Leader>cc :%s/\<<C-r><C-w>\>/<C-r><C-w>
vnoremap <Leader>cc y:%s/<C-r>"/<C-r>"

" Quickly select the text that was just pasted. This allows you to, e.g.,
" indent it after pasting.
noremap gV `[v`]

" Stay in visual mode when indenting. You will never have to run gv after
" performing an indentation.
vnoremap < <gv
vnoremap > >gv

" Make Y yank everything from the cursor to the end of the line. This makes Y
" act more like C or D because by default, Y yanks the current line (i.e. the
" same as yy).
noremap Y y$

" Replace tabs with four spaces. Make sure that there is a tab character between
" the first pair of slashes when you copy this mapping into your .vimrc!
nnoremap <Leader>rts :%s/	/    /g<CR>

nnoremap <silent> <leader>aw :ArgWrap<CR>

" Git leader commands.
" They require https://github.com/tpope/vim-fugitive.
noremap <Leader>gbl :Gblame<CR>
noremap <Leader>gwb :Gbrowse<CR>

" Opening files in tabs.
nnoremap <Leader>sni :exec 'tabe ~/.vim/snippets/' . &filetype . '.snippets'<CR>
nnoremap <Leader>zsh :tabe ~/.zshrc<CR>
nnoremap <Leader>vim :tabe ~/.vimrc<CR>

" Make j and k move by virtual lines instead of physical lines, but only when
" not used in the count mode (e.g. 3j). This is great when 'wrap' and
" 'relativenumber' are used.
" Based on http://stackoverflow.com/a/21000307/2580955
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Jump to the previous/next tab.
noremap <silent> J gT
noremap <silent> K gt

" Join lines by <Leader>+j because I use J to go to the previous tab.
noremap <Leader>j J

" Join lines without producing any spaces. It works like gJ, but does not keep
" the indentation whitespace.
" Based on http://vi.stackexchange.com/a/440.
function! s:JoinWithoutSpaces()
	normal! gJ
	" Remove any whitespace.
	if matchstr(getline('.'), '\%' . col('.') . 'c.') =~ '\s'
		normal! dw
	endif
endfunction
noremap <silent> <Leader>J :call <SID>JoinWithoutSpaces()<CR>

" Path/file/command completion.
set wildmenu
set wildchar=<Tab>
set wildmode=list:longest
set wildignore+=*.o,*.obj,*.pyc,*.aux,*.bbl,*.blg,.git,.svn,.hg,.class,.iml,vendor/**
" Suffixes that get lower priority when doing tab completion for filenames.
" These files are less likely to be edited.
set suffixes=.bak,~,.swp,.o,.info,.aux,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Code completion.
set completeopt=longest,menuone
" Do not search in included/imported files (it slows down completion, mostly
" on network filesystems).
set complete-=i
" Enable omni completion.
set omnifunc=syntaxcomplete#Complete
" set tags=./tags,./TAGS,tags,TAGS

"------------------------------------
" vim-grepper: Helps you win at grep.
"------------------------------------
let g:grepper={}
" Use the quickfix window.
let g:grepper.quickfix=1
" Open the quickfix window after the search finishes.
let g:grepper.open=1
" Switch to the quickfix window after the search finishes.
let g:grepper.switch=1
" Show the prompt by default.
let g:grepper.prompt=1
" Supported tools (use 'git' before 'ag').
let g:grepper.tools=['git', 'ag', 'ack', 'grep', 'findstr', 'sift', 'pt']
" Works like /, but uses vim-grepper to do the searching.
nnoremap <Leader>/ :Grepper<CR>
" Works like *, but uses vim-grepper to do the searching.
nnoremap <Leader>* :Grepper -cword -noprompt<CR>

augroup file_types
au!
au BufNewFile,BufRead *.php[0-9a-zA-Z] setl ft=php
au BufNewFile,BufRead *.sql setl ft=mysql
au BufNewFile,BufRead *.scala setl ft=scala
au BufNewFile,BufRead *.go setl ft=go
augroup end

" PHP
augroup php
	au!
	" Use <Leader>man to display manual pages for the function under cursor in a browser.
	au FileType php nnoremap <buffer> <silent> <Leader>man :call <SID>OpenLink('http://php.net/'.expand('<cword>'))<CR>
	" Make "gq" on comments work properly.
	au FileType php setl comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:///,O://,:#
augroup end

" Scala
augroup scala
au!
	" The following settings are based on these guidelines:
	"  - python.org/dev/peps/pep-0008
	au FileType scala setl expandtab     " Use spaces instead of tabs.
	au FileType scala setl tabstop=2     " A tab counts for 4 spaces.
	au FileType scala setl softtabstop=2 " Causes backspace to delete 4 spaces.
	au FileType scala setl shiftwidth=2  " Shift by 4 spaces.
	" Go to imports.
	au FileType scala nnoremap <buffer> <Leader>im /^\(from\\|import\) <CR>:nohlsearch<CR>:echo<CR>
	au FileType scala nnoremap <Leader>sim :SortScalaImports<CR>
augroup end

" vim-go
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>


augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  au FileType go nmap <leader>gr <Plug>(go-run)
  au FileType go nmap <leader>gg <Plug>(go-build)
  au FileType go nmap <leader>gt <Plug>(go-test)
  au FileType go nmap <leader>gc <Plug>(go-coverage)
  au FileType go nmap <Leader>ds <Plug>(go-def-split)
  au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
  au FileType go nmap <Leader>dt <Plug>(go-def-tab)
  au FileType go nmap <Leader>gd <Plug>(go-doc)
  au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
  au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
  au FileType go nmap <Leader>gs <Plug>(go-implements)
  au FileType go nmap <Leader>gi <Plug>(go-info)
  au FileType go nmap <Leader>ge <Plug>(go-rename)

  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
