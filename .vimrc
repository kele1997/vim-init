let mapleader = "\<Space>"
nnoremap <SPACE> <Nop>

let g:go_echo_go_info = 0
let g:go_list_type = ""
set smartindent
set splitright
set splitbelow

" 关闭响铃
" set visualbell
set noeb vb t_vb=

map <silent> <Leader>mdi :ALEDisableBuffer \| DIstart<CR>
map <silent> <Leader>mds :ALEEnableBuffer \| DIstop<CR>
" let g:ale_c_parse_makefile = 1


let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'


" let g:airline_solarized_normal_green = 1

source ~/.vim/vim-init/init.vim

" colorscheme molokai
colorscheme peaksea



" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


nnoremap <silent><leader>w :w<CR>



nnoremap <leader>a :Ack!<Space>


" let $GTAGSLABEL = 'native-pygments'
" let $GTAGSCONF = '/etc/gtags/gtags.conf'
"
function! CompileAndRun()
  let l:cmd = {
        \ 'c'      : "gcc -lpthread % -o %<; time ./%<",
        \ 'sh'     : "time bash %",
        \ 'go'     : "go run %",
        \ 'cpp'    : "g++ -g -std=c++11 % -o %<; time ./%<",
        \ 'ruby'   : "time ruby %",
        \ 'java'   : "javac %; time java %<",
        \ 'rust'   : "rustc % -o %<; time ./%<",
        \ 'python' : "time python %",
        \ 'haskell': "ghc % -o %< && ./%<",
        \ 'lua': "lua %",
        \ 'javascript' : "js %",
        \}
  let l:ft = &filetype
  if has_key(l:cmd, l:ft)
    exec 'w'
    exec "AsyncRun! -raw ".l:cmd[l:ft]
    " exec "AsyncRun! -mode=term -raw ".l:cmd[l:ft]
  else
	echo "err"
  endif
endfunction


" :command -nargs=* Bash : AsyncRun! -raw -mode=term  -pos=right -cols=50 "<q-args>"
:command -nargs=* Bash : AsyncRun! -raw -mode=term -rows=8 "<q-args>"

nnoremap <leader>rr :call CompileAndRun()<CR>
" nnoremap ,r :AsyncRun -mode=term -raw 
nnoremap <silent> <leader>s :AsyncStop!<CR>
nnoremap <leader>bb :cclose<CR>
nnoremap <leader>b :Bash<Space> 


" let g:Lf_WindowPosition = 'popup'

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


nmap <leader>ah :AddMinHeader<CR>

"call plug#begin(get(g:, 'bundle_home', '~/.vim/bundles'))
"Plug 'plasticboy/vim-markdown'
"call plug#end()

set wrap

let g:go_fmt_autosave = 1
let g:go_imports_autosave = 1
"
map <silent> <leader>f :LeaderfFile<CR>
" let g:coc_filetype_map = {
" 	\	'markdown': 'md',	
" 	\}
"
let vim_markdown_folding_disabled = 1


inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"



nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction


autocmd CursorHold * silent call CocActionAsync('highlight')



" imap <C-l> <Plug>(coc-snippets-expand)

let s:bgenabled = 0
function! Nobg() 
	if ! s:bgenabled
		hi Normal guibg=NONE ctermbg=NONE
		hi NonText guibg=NONE ctermbg=NONE
		let g:indentLine_bgcolor_term = 60
		let s:bgenabled = 1
	else
		" noh Normal guibg=NONE ctermbg=NONE
		" noh NonText guibg=NONE ctermbg=NONE
		" TODO
		" should restore the origin color 
		hi Normal  ctermfg=252 ctermbg=234 guifg=#d0d0d0 guibg=#202020
		hi NonText  term=bold ctermfg=69 ctermbg=233 guifg=#6080f0 guibg=#101010
		let g:indentLine_bgcolor_term = 0
		let s:bgenabled = 0
	endif
endfunction

map <leader>nbg :call Nobg()<CR>
map <leader>cw :cclose<CR>


set shortmess=atI

" map <c-j> <down>
" map <c-k> <up>
"
" boright termianl  or bo term
cabbrev bterm bo term

