"----------------------------------------
" パス設定
"----------------------------------------
"{{{
" Windows, unixでのruntimepathの違いを吸収するためのもの。
" $MY_VIMRUNTIMEはユーザーランタイムディレクトリを示す。
" :echo $MY_VIMRUNTIMEで実際のパスを確認できます。
if isdirectory($HOME . '/.vim')
  let $MY_VIMRUNTIME = $HOME.'/.vim'
elseif isdirectory($HOME . '\vimfiles')
  let $MY_VIMRUNTIME = $HOME.'\vimfiles'
elseif isdirectory($VIM . '\vimfiles')
  let $MY_VIMRUNTIME = $VIM.'\vimfiles'
endif
"}}}

"--------------------------------------------------
" 基本設定
"--------------------------------------------------
"{{{
set encoding=utf8                  " エンコーディング設定
set fileencoding=utf-8             " カレントバッファ内のファイルのエンコーディング設定
set scrolloff=5                    " カーソルの上下に表示する最小行数
set nowrap                         " 行の折り返しの禁止
set nobackup                       " バックアップの禁止
set autoread                       " 自動ロード
set noswapfile                     " swapファイルの生成禁止
set hidden                         " 未保存でのバッファの切り替えの有効化
set imdisable                      " ESCによるIMEの無効化
set title                          " 端末のタイトルをファイル名へ変更
set shortmess+=I                   " 各種メッセージを略称で表示
set showmode                       " モードの表示
set scrolloff=5                    " スクロール時の余白設定
set browsedir=buffer               " Exploreの初期ディレクトリ
set ruler                          " ルーラの表示
set laststatus=2                   " 常にステータスラインを表示
set showcmd                        " コマンドをステータスラインに表示
set tabstop=4 shiftwidth=4 softtabstop=0 " インデント設定
"set noexpandtab                   " タブのスペース変換の無効化
set expandtab                      " タブのスペース変換の有効化
set modelines=0                    " modelineの無効化
set clipboard+=unnamed             " クリップボードの使用
set autoindent                     " オートインデント
set smartindent                    " 新しい行のオートインデント
set guioptions-=m                  " メニューバーを削除
set guioptions-=T                  " ツールバーを削除
set nocompatible                   " タブ補完の有効化
set wildmenu                       " コマンド補完を強化
set wildchar=<tab>                 " コマンド補完を開始するキー
set wildmode=list:full             " リスト表示，最長マッチ
set history=1000                   " コマンド・検索パターンの履歴数
set complete+=k                    " 補完に辞書ファイル追加
set backspace=indent,eol,start     " バックスペースの設定

"}}}

"--------------------------------------------------
" 表示
"--------------------------------------------------
"{{{
syntax enable                      " ハイライト有効化
set cursorline                     " カーソルのハイライト
set showmatch                      " カッコの対応のハイライト
set number                         " 行番号の表示
set list                           " 不可視文字の表示
set listchars=tab:▸\ ,trail:_,extends:>,precedes:< " 不可視文字の表示形式
set display=uhex                   " 印字不可能文字を16進数で表示
let g:molokai_original = 1
:colorscheme molokai
"}}}

"--------------------------------------------------
" 検索設定
"--------------------------------------------------
"{{{
set wrapscan                       " 最後まで検索したら先頭へ戻る
set ignorecase                     " 大文字小文字無視
set smartcase                      " 検索文字列に大文字が含まれている場合は区別して検索する
set incsearch                      " インクリメンタルサーチ
set hlsearch                       " 検索文字をハイライト
" Escの2回押しでハイライト消去
nnoremap <buffer> <ESC><ESC> :nohlsearch<CR><ESC>
"}}}

"--------------------------------------------------
" キー設定
"--------------------------------------------------
"{{{
nnoremap h <Left>
nnoremap j gj
nnoremap k gk
nnoremap l <Right>
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap ;  <Nop>
xnoremap ;  <Nop>
nnoremap m  <Nop>
xnoremap m  <Nop>
nnoremap ,  <Nop>
xnoremap ,  <Nop>
"}}}

"--------------------------------------------------
" 折りたたみ設定
"--------------------------------------------------
"{{{
set foldmethod=syntax
let php_folding=1 
let xml_syntax_folding = 1

function! SetFoldMethod()
    if search("{{{") && search("}}}")
        set foldmethod=marker
    endif
endfunction

au BufRead *.* call SetFoldMethod()
"}}}

"--------------------------------------------------
" Windowの設定
"--------------------------------------------------
"{{{
nnoremap    [Window]   <Nop>
nmap    s [Window]
nnoremap <silent> [Window]p  :<C-u>split<CR>
nnoremap <silent> [Window]v  :<C-u>vsplit<CR>
nnoremap <silent> [Window]n  :<C-u>call <SID>split_nicely()<CR>
nnoremap <silent> [Window]c  :<C-u>call <sid>smart_close()<CR>
nnoremap <silent> [Window]o  :<C-u>only<CR>

nnoremap <silent> <Tab> :call <SID>NextWindow()<CR>
nnoremap <silent> <S-Tab> :call <SID>PreviousWindowOrTab()<CR>

function! s:smart_close()
    if winnr('$') != 1
        close
    endif
endfunction

function! s:NextWindow()
    if winnr('$') == 1
        silent! normal! ``z.
    else
        wincmd w
    endif
endfunction

function! s:NextWindowOrTab()
    if tabpagenr('$') == 1 && winnr('$') == 1
        call s:split_nicely()
    elseif winnr() < winnr("$")
        wincmd w
    else
        tabnext
        1wincmd w
    endif
endfunction

function! s:PreviousWindowOrTab()
    if winnr() > 1
        wincmd W
    else
        tabprevious
        execute winnr("$") . "wincmd w"
    endif
endfunction

function! s:split_nicely()
    " Split nicely.
    if winwidth(0) > 2 * &winwidth
        vsplit
    else
        split
    endif
    wincmd p
endfunction

"}}}

"--------------------------------------------------
" Tabの設定
"--------------------------------------------------
"{{{
"
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'

set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ
"
" カレントウインドウを新しいタブで開く
nnoremap <silent> [Tag]m :call OpenNewTab()<CR>
function! OpenNewTab()
    let f = expand("%:p")
    execute ":q"
    execute ":tabnew ".f
endfunction

"}}}

"--------------------------------------------------
" NeoBundleの設定
"--------------------------------------------------
"{{{
filetype plugin indent off
if has('vim_starting')
    set runtimepath+=$MY_VIMRUNTIME/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.bundle'))

NeoBundle 'Shougo/vimproc',{
      \   'build': {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin'  : 'make -f make_cygwin.mak',
      \     'mac'     : 'make -f make_mac.mak',
      \     'unix'    : 'make -f make_unix.mak',
      \   },
      \ }
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline', '', 'default'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'taichouchou2/vim-javascript'
NeoBundle 'briancollins/vim-jst'
NeoBundle 'glidenote/memolist.vim'
NeoBundle 'Shougo/vimfiler'

filetype plugin indent on
NeoBundleCheck
"}}}

"--------------------------------------------------
" NeoComplCacheの設定
"--------------------------------------------------
"{{{
" NeoComplCacheを有効にする
"let g:acp_enableAtStartup = 0
"let g:neocomplcache_enable_at_startup = 1
"" smarrt case有効化。 大文字が入力されるまで大文字小文字の区別を無視する
"let g:neocomplcache_enable_smart_case = 1
"" camle caseを有効化。大文字を区切りとしたワイルドカードのように振る舞う
"let g:neocomplcache_enable_camel_case_completion = 1
"" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1
"" Set minimum syntax keyword length.
"let g:neocomplcache_min_syntax_length = 2
"let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"" Enable omni completion.
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" Disable AutoComplPop. Comment out this line if AutoComplPop is not installed.
let g:acp_enableAtStartup = 0
" Launches neocomplcache automatically on vim startup.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underscore completion.
let g:neocomplcache_enable_underbar_completion = 1
" Sets minimum char length of syntax keyword.
let g:neocomplcache_min_syntax_length = 3
" buffer file name pattern that locks neocomplcache. e.g. ku.vim or fuzzyfinder 
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define file-type dependent dictionaries.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword, for minor languages
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion. Not required if they are already set elsewhere in .vimrc
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion, which require computational power and may stall the vim. 
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
"}}}

"--------------------------------------------------
" Uniteの設定
"--------------------------------------------------
"{{{

let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1

nnoremap    [unite]   <Nop>
xnoremap    [unite]   <Nop>
nmap    ;u [unite]
xmap    ;u [unite]

nnoremap [unite]u  q:Unite<Space>
nnoremap <silent> ;o
      \ :<C-u>Unite outline -start-insert -resume<CR>
nnoremap  [unite]f  :<C-u>Unite source<CR>
xnoremap <silent> ;r
      \ d:<C-u>Unite -buffer-name=register register history/yank<CR>
nnoremap <silent> ;w
      \ :<C-u>UniteWithCursorWord -buffer-name=register
      \ buffer file_mru bookmark file<CR>
nnoremap <silent> ;bw
      \ :<C-u>UniteWithBufferDir -buffer-name=register
      \ buffer file_mru bookmark file<CR>
nnoremap <silent> <C-k>
      \ :<C-u>Unite change jump<CR>
nnoremap <silent> ;g
      \ :<C-u>Unite grep -buffer-name=search -auto-preview<CR>
nnoremap <silent> ;r
      \ :<C-u>Unite -buffer-name=register register history/yank<CR>

" window
nnoremap <silent> [Window]s
            \ :<C-u>Unite -buffer-name=files -no-split -multi-line
            \ jump_point file_point buffer_tab
            \ file_rec/async:! file file/new file_mru<CR>
nnoremap <silent> [Window]bs
            \ :<C-u>UniteWithBufferDir -buffer-name=files -no-split -multi-line
            \ jump_point file_point buffer_tab
            \ file_rec/async:! file file/new file_mru<CR>
nnoremap <silent> [Window]w
            \ :<C-u>Unite window<CR>

" search
nnoremap <silent> /
            \ :<C-u>Unite -buffer-name=search -no-split -start-insert line<CR>
nnoremap <silent> ?
            \ :<C-u>Unite -buffer-name=search -auto-highlight -start-insert line:backward<CR>
nnoremap <silent> *
            \ :<C-u>UniteWithCursorWord -no-split -buffer-name=search line<CR>

nnoremap <silent> n
            \ :<C-u>UniteResume search -no-start-insert<CR>
"}}}

"--------------------------------------------------
" Memolistの設定
"--------------------------------------------------
"{{{
map <Leader>mn  :MemoNew<CR>
map <Leader>ml  :MemoList<CR>
map <Leader>mg  :MemoGrep<CR>
"}}}

"--------------------------------------------------
" vimfilerの設定
"--------------------------------------------------
" vimfiler.vim"{{{
"nmap    [Space]v   <Plug>(vimfiler_switch)
nmap  <Space>   [Space]
xmap  <Space>   [Space]
nnoremap  [Space]   <Nop>
xnoremap  [Space]   <Nop>
nnoremap <silent>   [Space]v   :<C-u>VimFiler -find<CR>
nnoremap    [Space]ff   :<C-u>VimFilerExplorer<CR>

let bundle = neobundle#get('vimfiler')
function! bundle.hooks.on_source(bundle)
  let g:vimfiler_enable_clipboard = 0
  let g:vimfiler_safe_mode_by_default = 0
  let g:vimfiler_as_default_explorer = 1
endfunction

unlet bundle
"}}}
