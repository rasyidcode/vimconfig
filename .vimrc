" Vim plug
call plug#begin('~/.vim/plugged')

" Themes
Plug 'morhetz/gruvbox'

" Status Line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" Color stuff
set t_Co=256

" Disable swp file
set noswapfile

" Enable syntax highligthing
syntax enable

" For working with ASCII character set
set encoding=utf-8

" Disables vim backup files
set nobackup
set nowritebackup

" Dealing with tabs
set noexpandtab
set shiftwidth=4
set tabstop=4

" Set page number
set number

" CursorHold event wait time
set updatetime=300

" Show sign columns
set signcolumn=yes

" UI stuff
set background=dark
colorscheme gruvbox

" Set native status line
set laststatus=2
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
set statusline=%{StatusDiagnostic()}

function! StatusDiagnostic() abort
	let info = get(b:, 'coc_current_function', {})
	if empty(info) | return '' | endif
	let msgs = []
	if get(info, 'error', 0)
		call add(msgs, 'E' . info['error'])
	endif
	if get(info, 'warning', 0)
		call add(msgs, 'W' . info['warning'])
	endif
	return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

" Allow switching buffer without saving
" set hidden

" Tab to trigger autocompletion
inoremap <silent><expr> <TAB>
	\ coc#pum#visible() ? coc#pum#next(1) :
	\ CheckBackspace() ? "\<Tab>" :
	\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Trigger completion
inoremap <silent><expr> <c-@> coc#refresh()

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation() abort
	if (CocAction('hasProvider', 'hover'))
		call CocActionAsync('doHover')
	else
		call feedkeys('K', 'in')
	endif
endfunction

" Apply the most preferred quickfix action to fix diagnostic on the current
" line
nmap <space>qf <Plug>(coc-fix-current)

" Diagnostic navigation
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Show all diagnostic
nnoremap <silent><nowait> <space>a :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o :<C-u>CocList outline<cr>
" Search workspace symbol
nnoremap <silent><nowait> <space>s :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j :<C-u>CocNext<cr>
" Do default action for prev item
nnoremap <silent><nowait> <space>k :<C-u>CocPrev<cr>
" Resume latest coc list
nnoremap <silent><nowait> <space>p :<C-u>CocListResume<cr>

" Formatting
nnoremap <silent><C-S-I> :CocCommand prettier.formatFile<CR>

" Explorer
" nnoremap <space>e :CocCommand explorer<CR>

" Comment Uncomment

" NERDTree stuff
" nnoremap <space>e :NERDTreeToggle<CR>

" Autosave
" autocmd TextChanged,TextChangedI <buffer> silent write
autocmd InsertLeave * if &readonly==0 && filereadable(bufname('%')) | silent update | endif

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" buffer stuff 
nnoremap <C-h> :bprev<CR> 
nnoremap <C-l> :bnext<CR>
nnoremap <C-q> :bd<CR>
nnoremap <C-b> :ls<CR>

" Bufferline Config
let g:bufferline_echo = 0

" vim-airline/vim-airline config
let g:airline#extensions#tabline#enabled = 1


