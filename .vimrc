if &compatible
    set nocompatible
endif

let s:dein_path = expand('~/.vim/dein')
let s:dein_repo_path = s:dein_path . '/repos/github.com/Shougo/dein.vim'

" deinなかったらcloneでもってくる
if !isdirectory(s:dein_repo_path)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_path
endif

execute 'set runtimepath^=' . s:dein_repo_path

" let g:dein#install_progress_type = 'title'
let g:dein#enable_notification = 1

call dein#begin(s:dein_path)
call dein#load_toml('~/.vim/dein/dein.toml', {'lazy': 0})
call dein#load_toml('~/.vim/dein/dein-lazy.toml', {'lazy': 1})
call dein#end()

if dein#check_install()
    call dein#install()
endif
" プラグイン以外のその他設定が続く
" :
" 改行時に自動でインデントを行なう
set autoindent
"カラー有効
syntax on
" ファイルが外部で変更された際に自動で読み込む
set autoread

" バックスペースの影響範囲を設定する
set backspace=indent,eol,start

" OSとクリップボードを共有する
set clipboard=unnamed,autoselect

" 強調表示する列を設定する
set colorcolumn=80

" 未保存ファイルの終了時に保存確認を行なう
set confirm

" カーソル行を強調表示する
set cursorline

" 文字コードを設定する
set encoding=utf8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis

" タブの代わりにスペースを挿入する
set expandtab

" ファイル変更中に他のファイルを表示可能にする
set hidden

" コマンドラインモードで保存する履歴数を設定する
set history=1000

" 検索結果をハイライト表示する
set hlsearch

" 大文字と小文字を区別せず検索する
set ignorecase

" インクリメンタルサーチを有効にする
set incsearch

" ステータスバーを常に表示する
set laststatus=2

" 不可視文字を表示する
set list

" 不可視文字の表示方法を設定する
set listchars=eol:¬

" マウスを有効にする
set mouse=a

" ファイル上書き時にバックアップをとらない
set nobackup
set nowritebackup

" スワップファイルを作成しない
set noswapfile

" 行番号を表示する
set number

" ルーラーを表示する
set ruler

" カーソル行の上下へのオフセットを設定する
set scrolloff=4

" インデントでずれる幅を設定する
set shiftwidth=4

" 入力中のコマンドを表示する
set showcmd

" 対応するカッコを強調表示する
set showmatch

" タブバーを常に表示する
set showtabline=2

" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase

" 改行入力行の末尾にあわせてインデントを増減する
set smartindent

" コンテキストに応じたタブの処理を行なう
set smarttab

" タブやバックスペースで処理するスペースの数を設定する
set softtabstop=4

" 新しいウィンドウを下/右に開く
set splitbelow
set splitright

" タブ幅を設定する
set tabstop=4

" 編集中のファイル名を表示する
set title

" ビープを無効にする
set visualbell t_vb=

" 行頭・行末の左右移動で行を移動する
set whichwrap=b,s,h,l,<,>,[,]

" コマンドラインモードでの補完を有効にする
set wildmenu

" コマンドラインモードでの補完方法を設定する
set wildmode=list:longest,full

" 行を折り返す
set wrap

" 検索時に最後まで移動したら最初に戻る
set wrapscan
