call plug#begin()
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'romainl/vim-qf'
"Plug 'morhetz/gruvbox'
Plug 'tpope/vim-rsi'
Plug 'ludovicchabant/vim-gutentags'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'neomake/neomake'
Plug 'tpope/vim-sensible'
Plug 'MattesGroeger/vim-bookmarks'
call plug#end()

" ZSH!
set shell=/usr/bin/zsh

" Set a more convenient leader key on an AZERTY layout than the default backslash
let mapleader = ","

" Display the line numbers.
set number

" Do not add newlines to EOF
set nofixendofline

" Turn sounds off.
set visualbell

" Activate highlighting search pattern matches & incremental search.
" Incremental search means your cursor will jump to the first match as you type.
set hlsearch

" Activate case-insensitive & smart case search (if a capital letter is used
" in your search query, Vim will search case-sensitive).
set ignorecase 
set smartcase

" Horizontal cursor line
set cursorline

" Turning on line wrapping and line-break for easy text-file editing.
set wrap

" Turn on ignore whitespace, filler, and vertical diff preferences
set diffopt=filler,iwhite,vertical

" Gutentags settings
let g:gutentags_ctags_executable="ctags"
let g:gutentags_ctags_extra_args=['regex-SQL=''/create procedure(.*)/\1/f/i''']
let g:gutentags_ctags_exclude=["*node_modules*","*generated*","*packages*","*HostedOps*","*karma*","*.git*", "*Web Reference*","Reference.cs"]
let g:gutentags_ctags_tagfile=".git/tags"
"let g:gutentags_enabled=0

" Set tabs to 4 characters and expand to spaces, activate smart indenation.
" See tabstop help for more info.
" Setting tabstop & softtabstop to the same value to avoid messy layout with mixed tabs & spaces.
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

" Set wildchar visual completion awesomeness.
" This is enhanced command line completion and it rocks.
set wildmode=longest,list,full

" Line-break wraps full words at the end of a sentence for readability.
set linebreak
set shiftround
set smartindent

" Activate syntax highlighting.
syntax enable
syntax on

" Set theme
" color gruvbox
" set background=dark

" Show matching parens
set showmatch

" Syntax highlighting tweaks
autocmd BufNewFile,BufReadPost *.config set filetype=xml
autocmd BufNewFile,BufReadPost *.csproj set filetype=xml
autocmd BufNewFile,BufReadPost *.tt set filetype=cs
autocmd BufNewFile,BufReadPost *.ttinclude set filetype=cs

" If you don't have this set already, then do so. It makes vim work like every other multiple-file editor on the planet. You can have edited buffers that aren't visible in a window somewhere.
set hidden

" Turn off backups
set nobackup
set noswapfile

" Make NERDTree wider
let g:NERDTreeWinSize=50
let g:NERDTreeWinPos="right"

" Fix :W mistake
command! WQ wq
command! Wq wq
command! W w
command! Q q

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*

let g:highlighting = 0
function! Highlighting()
  if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
    let g:highlighting = 0
    return ":silent nohlsearch\<CR>"
  endif
  let @/ = '\<'.expand('<cword>').'\>'
  let g:highlighting = 1
  return ":silent set hlsearch\<CR>"
endfunction

" Open the quick fix window with Ggrep
"autocmd QuickFixCmdPost *grep* cwindow

" Use ripgrep for grepping
set grepprg=rg\ --vimgrep

" Map leader q to switch to last buffer
function! s:buflisted()
  return filter(range(1, bufnr('$')), 'buflisted(v:val) && getbufvar(v:val, "&filetype") != "qf"')
endfunction

function! s:sort_buffers(...)
  let [b1, b2] = map(copy(a:000), 'get(g:fzf#vim#buffers, v:val, v:val)')
  " Using minus between a float and a number in a sort function causes an error
  return b1 < b2 ? 1 : -1
endfunction

function! s:buflisted_sorted()
  return sort(s:buflisted(), 's:sort_buffers')
endfunction

function! SwitchLastBuffer()
    let last_buffer = bufnr('#')
    if buflisted(last_buffer) == 1
        execute "b".last_buffer
    else
        let buffers = s:buflisted_sorted()
        let current_buffer = bufnr('%')

        let found_current_buffer = 0
        for buffer in buffers
            if found_current_buffer == 1
                execute "b".buffer
                break
            endif

            if buffer == current_buffer
                let found_current_buffer = 1
            endif
        endfor
    endif
endfunction

" Tagbar settings
let g:tagbar_width=100
let g:tagbar_autofocus=1

" Tags settings
set tags="./tags;,tags,~/src/panopto-core/.git/tags"

" Configure EasyMotion
" Plug 'easymotion/vim-easymotion'
" <Leader>f{char} to move to {char}
" map  <Leader>f <Plug>(easymotion-bd-f)
" nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
" map <Leader>s <Plug>(easymotion-overwin-f2)
" nmap <Leader>s <Plug>(easymotion-overwin-f2)

" Move to line
" map <Leader>e <Plug>(easymotion-bd-jk)
" nmap <Leader>e <Plug>(easymotion-overwin-line)

" Move to word
" map  <Leader>w <Plug>(easymotion-bd-w)
" nmap <Leader>w <Plug>(easymotion-overwin-w)

" Window split settings
highlight TermCursor ctermfg=red guifg=red
set splitbelow
set splitright

" This is only availale in the quickfix window, owing to the filetype
" restriction on the autocmd (see below).
"function! <SID>OpenQuickfix(new_split_cmd)
  " 1. the current line is the result idx as we are in the quickfix
"  let l:qf_idx = line('.')
  " 2. jump to the previous window
"  wincmd p
  " 3. switch to a new split (the new_split_cmd will be 'vnew' or 'split')
"  execute a:new_split_cmd
  " 4. open the 'current' item of the quickfix list in the newly created buffer
  "    (the current means, the one focused before switching to the new buffer)
"  execute l:qf_idx . 'cc'
"endfunction

"autocmd FileType qf nnoremap <buffer> <C-v> :call <SID>OpenQuickfix("vnew")<CR>
"autocmd FileType qf nnoremap <buffer> <C-x> :call <SID>OpenQuickfix("split")<CR>
"au FileType qf wincmd J

" Set the cursor
"set guicursor=n-v-c:block-Cursor/lCursor-blinkon1,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" let &t_SI .= "\<Esc>[6 q"
" let &t_SR .= "\<Esc>[4 q"
" let &t_EI .= "\<Esc>[2 q"

" Run SQL
function! RunSqlCmd(format, vert, line1, line2, ...)
    set filetype=sql
    let l:tempFile = tempname()

    exe a:line1 . "," . a:line2 . "y a"
    let l:no_line_breaks = split(@a, "\n")
    call writefile(l:no_line_breaks, l:tempFile)

    let l:opts = '-S "." -E -d "PanoptoDB_3"'

    if a:0 > 0 && strlen(a:1) > 0
        let l:opts = a:1
    endif

    let l:title = l:opts

    if l:opts !~ "-P " && l:opts !~ "-E "
        if !exists("g:sql_passwords")
            let g:sql_passwords = {}
        endif

        if has_key(g:sql_passwords, l:opts)
            let l:password = get(g:sql_passwords, l:opts)
        else
            call inputsave()
            let l:password = inputsecret('Enter password: ')
            call inputrestore()

            let g:sql_passwords[l:opts] = l:password
        endif

        let l:opts = l:opts . ' -P "' . l:password . '"'
    endif

    let l:separator = "\\t"
    if a:format == 1
        let l:separator = "$"
    endif

    if a:format == 1
        let l:sql_command = "/opt/mssql-tools/bin/sqlcmd " . l:opts . " -s '" . l:separator . "' -W -I -i " . l:tempFile
    else
        let l:sql_command = "/opt/mssql-tools/bin/sqlcmd " . l:opts . " -s '" . l:separator . "' -w 65535 -y 7999 -I -i " . l:tempFile
    endif

    let l:command = join(map(split(l:sql_command), 'v:val'))
    echom 'Execute ' . l:command . '...'

    let winnr = bufwinnr('^' . l:title . '$')

    if a:vert == 0
        silent! execute  winnr < 0 ? 'new'  : winnr . 'wincmd w'
    else
        silent! execute  winnr < 0 ? 'vertical new'  : winnr . 'wincmd w'
    endif

    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap nonumber

    silent! execute 'silent %!'. l:command
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    "silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . l:command . ''')<CR>:AnsiEsc<CR>'
    silent! execute 'nnoremap <silent> <buffer> q :q<CR>'
    silent! execute 'AnsiEsc'

    if a:format == 1
        silent! execute "%!column -s '$' -t"
    endif
    "silent! execute "res ".min([line('$'), 20])
endfunction

" Save and then run SqlCmd on the path of the file in the current buffer
command! -range=% -nargs=* Sql execute RunSqlCmd(1, 0, <line1>, <line2>, <q-args>)

" Save and then run SqlCmd on the path of the file in the current buffer
command! -range=% -nargs=* SqlNF execute RunSqlCmd(0, 0, <line1>, <line2>, <q-args>)

" Save and then run SqlCmd on the path of the file in the current buffer
command! -range=% -nargs=* SqlV execute RunSqlCmd(1, 1, <line1>, <line2>, <q-args>)

" Map BD to not close current split
command! -bang BD bp|bd<bang> #

" Pretty print XML
command! PrettyXML :set filetype=xml | %!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"

" Pretty print Json
command! PrettyJson :set filetype=json | %!python3 -m "json.tool"

" Find command
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" Airline settings
" let g:airline_section_b = ''
" let g:airline_section_c = '%f'
" let g:airline_section_warning = ''
let g:airline#extensions#neomake#enabled = 1

" Make
set makeprg=python3\ ~/git/cloud-dev/devbox.py

function! FindGlob(pattern, path)
    let fullpattern = a:path . "/" . a:pattern
    let result = glob(fullpattern)
    if strlen(result)
        return result
    else
        let parts = split(a:path, "/")
        if len(parts)
            let newpath = "/" . join(parts[0:-2], "/")
            return FindGlob(a:pattern, newpath)
        else
            return ""
        endif
    endif
endfunction

function! SetParameters(...) dict
    let maker = deepcopy(self)
    let l:filename = bufname(a:000[0].bufnr)
    let l:filepath = fnamemodify(l:filename, ":p:h")
    let l:projectpath = FindGlob("*.csproj", l:filepath)
    let l:projectname = fnamemodify(l:projectpath, ":t:r")

    if maker.name == 'test'
        let l:currentmethod = tagbar#currenttag('%s', '')
        let l:methodfilter = '"method == ' . substitute(l:currentmethod, '[()]', '', 'g') . '"'
        let maker.args = maker.args . ' -p ' . l:projectname . ' -f ' . l:methodfilter
    elseif maker.name =='msbuild'
        let maker.args = maker.args . ' -p ' . l:projectname
    elseif maker.name == 'msbuildConfigurable'
        let maker.args = maker.args . ' ' . g:msbuild_configuration
    endif
    return maker
endfunction

" Function to build a specific project
function! BuildProject(project_name)
    let g:msbuild_configuration = ' -p ' . a:project_name
    execute 'NeomakeCancelJobs'
    execute 'cexpr ["building ' . a:project_name . '..."]'
    execute 'Neomake! msbuildConfigurable'
    execute 'copen'
endfunction

function! Build()
    let g:msbuild_configuration = ''
    execute 'NeomakeCancelJobs'
    execute 'cexpr ["building everything..."]'
    execute 'Neomake! msbuildConfigurable'
    execute 'copen'
endfunction

function PostprocessFilenames(entry)
    let a:entry.type = 'W'
    endif
endfunction

call neomake#config#set('ft.cs.InitForJob', function('SetParameters'))

let g:neomake_cs_msbuild_maker = {
    \ 'exe': 'python3',
    \ 'args': '~/git/cloud-dev/devbox.py gitbuild ',
    \ 'append_file': 0,
    \ 'errorformat': '%f:%l:%c:%t:%m',
    \ 'mapexpr': 'substitute(substitute(v:val, "\\", "/", "g"), "c:/git/", "~/git/", "")'
    \ }

let g:neomake_cs_msbuildConfigurable_maker = {
    \ 'exe': 'python3',
    \ 'args': '~/git/cloud-dev/devbox.py gitbuild ',
    \ 'append_file': 0,
    \ 'errorformat': '%f:%l:%c:%t:%m',
    \ 'mapexpr': 'substitute(substitute(v:val, "\\", "/", "g"), "c:/git/", "~/git/", "")'
    \ }

let g:neomake_cs_test_maker = {
    \ 'exe': 'python3',
    \ 'args': '~/git/cloud-dev/devbox.py test ',
    \ 'append_file': 0,
    \ 'errorformat': '%m',
    \ 'mapexpr': 'substitute(substitute(v:val, "\\", "/", "g"), "c:/git/", "~/git/", "")'
    \ }

let g:neomake_cs_enabled_makers = ['msbuild']
let g:neomake_open_list = 0

"call neomake#configure#automake('w')

" Quickfix do not auto-open; makes Neomake chaos
let g:qf_auto_open_quickfix = 0
let g:qf_auto_open_loclist = 0

" Function to toggle on/off Gstatus pane
function! GstatusToggle()
    let l:fugitive = bufnr('.git/index')
    let l:isopen = l:fugitive > -1 && bufloaded(l:fugitive)
    if !l:isopen
        execute 'Git'
        execute "normal \<C-w>L"
        setlocal nonumber
        execute 'vertical res 50'
        execute 'set winfixwidth'
    else
        execute l:fugitive . 'bd'
    endif
endfunction

" Function to get visual selection
function! Get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

" Mappings!

" Terminal settings <leader>ESCp+
tmap <Leader><ESC> <C-\><C-n>
tmap <expr> <Leader>p '<C-\><C-N>"0pi'
tmap <expr> <Leader>+ '<C-\><C-N>"+pi'

" Navigation LHKJ
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map L <C-d>
map H <C-u>
map K [{
map J [}

" Text searching <leader>hjkl
nmap <leader>j :grep! "" \| cw<Left><Left><Left><Left><Left><Left>
nmap <leader>J :grep! "" "%:h" \| cw<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
nmap <leader>k :grep! "\b<cword>\b"<CR>:cw<CR>
nmap <leader>K :grep! "\b<cword>\b" "%:h" \| cw
nmap <leader>l :lvimgrepa! "\b<cword>\b"<CR>:cw<CR>
nmap <leader>L :lvimgrepa! -i "\b<cword>\b"<CR>:cw<CR>
vmap <leader>k :<C-U>execute('grep! "\b' . Get_visual_selection() . '\b"')<CR>:cw<CR>
vmap <leader>K :<C-U>execute('grep! "\b' . Get_visual_selection(o % . '\b" "%:h"') \| cw

" Text editing
map <leader>d "_d
noremap <leader>u J
inoremap <C-r> <C-g>u<C-r>
nmap <leader>h :noh<CR>
nnoremap <silent> <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" : Highlighting()
nnoremap <leader>. ;
nnoremap gp `[v`]

" Quickfix / loclist <leader>nm,.M<>
map <leader>n :cn<CR>
map <leader>m :if empty(filter(getwininfo(), 'v:val.quickfix')) \| copen \| else \| cclose \| endif<CR>
map <leader>N :ln<CR>
map <leader>M :if empty(filter(getwininfo(), 'v:val.quickfix')) \| lopen \| else \| lclose \| endif<CR>

" IDE <leader>ert
map <leader>t :NERDTreeToggle<CR>
map <leader>T :NERDTreeFind<CR>
map <leader>r :TagbarToggle<CR>
map <leader>e :call GstatusToggle()<CR>

" Tag jumping <leader>zxcvb
map <leader>z g<C-]>
map <leader>x <C-W>g}
map <leader>c :lt <cword> \| lopen<CR>
map <leader>V :tp<CR>
map <leader>v :tn<CR>

" Buffers <leader>qwQ
map <leader>q :call SwitchLastBuffer()<CR>
tmap <leader>q <C-\><C-n>:b#<CR>
map <leader>w :only<CR>
tmap <leader>w <C-\><C-n>:only<CR>
map <leader>W :close<CR>
tmap <leader>W <C-\><C-n>:close<CR>
map <leader>Q :term

" FZF <leader>asdfg
map  <Leader>a :BLines<CR>
tmap <Leader>a <C-\><C-n>:BLines<CR>
map  <Leader>s :BTags<CR>
tmap <Leader>s <C-\><C-n>:BTags<CR>
map  <Leader>b :Buffers<CR>
tmap <Leader>b <C-\><C-n>:Buffers<CR>
map  <Leader>f :Tags<CR>
tmap <Leader>f <C-\><C-n>:Tags<CR>
map  <Leader>g :Files<CR>
tmap <Leader>g <C-\><C-n>:Files<CR>

" Make nvr git integration work with wq
autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete

"command! MutliLineFunction execute 'normal ^y0f(a<CR><ESC>^"_d0Pi    <ESC>'

function! PInsert2(item)
	let @z=a:item
	norm "zp
	call feedkeys('a')
endfunction

function! CompleteInf()
	let nl=[]
	let l=complete_info()
	for k in l['items']
		call add(nl, k['word']. ' : ' .k['info'] . ' '. k['menu'] )
	endfor 
	call fzf#vim#complete(fzf#wrap({ 'source': nl,'reducer': { lines -> split(lines[0], '\zs :')[0] },'sink':function('PInsert2')}))
endfunction 

imap <C-t> <CMD>:call CompleteInf()<CR>

set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Color scheme
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
highlight clear SignColumn

" Disable bookmarks commands because they interfere with NERDTree
let g:bookmark_no_default_key_mappings = 1
