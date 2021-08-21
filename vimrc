" 让配置变更立即生效
autocmd BufWritePost vimrc source vimrc

" 重新打开回到上次所编辑文件的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"our <leader> will be the space key 空格键
let mapleader=' '

" 暂时不需要localleader
" our <localleader> will be the '-' key
" let maplocalleader='-'

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'endel/vim-github-colorscheme'
Plug 'luochen1990/rainbow'

"按照缩进显示竖线，但是在终端中显示的效果并不太好，只能做到相邻的竖线采用不同颜色，但是看起来也很费力
"Plug 'nathanaelkane/vim-indent-guides'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Plug 'LucHermitte/lh-vim-lib'
"Plug 'LucHermitte/VimFold4C'

"Plug 'inkarkat/vim-LogViewer' 
"Plug 'inkarkat/vim-ingo-library'
Plug 'mtdl9/vim-log-highlighting'

" File navigation
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ctrlpvim/ctrlp.vim'

" A Vim plugin which shows a git diff in the sign column.
Plug 'airblade/vim-gitgutter'

" Comment functions so powerful—no comment necessary.
Plug 'preservim/nerdcommenter', { 'on': 'NERDCommenterToggle' }

" Taglist
Plug 'majutsushi/tagbar', { 'on': 'TagbarOpenAutoClose' }

" Markdown
" vim版本需要大于8.1或者使用neovim，先暂时留在这里
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync()}, 'for' :['markdown', 'vim-plug'] }
" 自动粘贴MD文件中的图片，但是在WSL下剪贴板不能正常访问，无法正常使用
Plug 'ferrine/md-img-paste.vim'
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
" there are some defaults for image directory and image name, you can change them
" let g:mdip_imgdir = 'img'
" let g:mdip_imgname = 'image'

"Plug 'prettier/vim-prettier', {
"  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json',
"  \ 'graphql', 'markdown', 'vue', 'yaml', 'html', 'kml'] }
Plug 'prettier/vim-prettier'
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }

"Adds file type icons to Vim plugins such as: NERDTree, vim-airline, CtrlP,
"unite, Denite, lightline, vim-startify and many more
"Always load the vim-devicons as the very last one.
Plug 'ryanoasis/vim-devicons'

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

let g:prettier#config#parser = 'babylon'

call plug#end()

"文件类型检测
filetype on                  " required
filetype plugin on
filetype indent on
filetype plugin indent on    " required

set nocompatible              " be iMproved, required
"语言设置
set langmenu=zh_CN.UTF-8
set helplang=cn
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

"使用系统剪贴板
set clipboard=unnamed

"显示
set number 
syntax on 
colorscheme onedark
"colorscheme solarized
"colorscheme molokai
"colorscheme github
"set background=light
set scrolloff=5 

"When you make a change to a file tracked by git, the diff markers should
"appear automatically. The delay is governed by vim's updatetime option; the
"default value is 4000, i.e. 4 seconds, but I suggest reducing it to around
"100ms (add set updatetime=100 to your vimrc).
set updatetime=200 " 默认值为4000ms，

"防止重载终端程序的背景,必须要放在有效的colorscheme后面
highlight Normal ctermbg=none 
highlight NonText ctermbg=none

set showcmd         " 输入的命令显示出来，看的清楚些  
"set statusline=[%p%%]\ [POS=%l,%v]\ [TYPE=%Y]\ [FORMAT=%{&ff}]\ %F%m%r%h%w\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容  
"set laststatus=2    " 启动显示状态行(1),总是显示状态行(2)  
set ruler                   " 打开状态栏标尺
set t_Co=256

"光标设置
"高亮光标所在行和列
set cursorline
"光标在不同模式下的状态
if &term == 'win32'
        let &t_ti.=" \e[1 q"
        let &t_SI.=" \e[5 q-- INSERT --"
        let &t_EI.=" \e[1 q"
        let &t_te.=" \e[0 q"
else
        let &t_ti.="\e[1 q"
        let &t_SI.="\e[5 q"
        let &t_EI.="\e[1 q"
        let &t_te.="\e[0 q"
endif

set history=1000 " 历史记录数

" 设置文件备份相关设置
" 不需要备份文件
set nobackup    
" 记录撤销更改的文件统一存放
set undodir='$VIM/undodir/'

"设置文内智能搜索提示  
" 高亮search命中的文本。  
set hlsearch            
" 搜索时忽略大小写  
set ignorecase  
" 随着键入即时搜索  
set incsearch  
" 有一个或以上大写字母时仍大小写敏感  
set smartcase  
" 当光标一段时间保持不动了，就禁用高亮
autocmd cursorhold * set nohlsearch
" 当输入查找命令时，再启用高亮
noremap n :set hlsearch<cr>n
noremap N :set hlsearch<cr>N
noremap / :set hlsearch<cr>/
noremap ? :set hlsearch<cr>?
noremap * *:set hlsearch<cr>

"设定tab宽度为4个字符
set tabstop=4
"设定tab用space代替
set expandtab
"设定自动缩进为4个字符
set shiftwidth=4

"设定list模式，即显示空格,TAB,行尾等特殊字符
set list
set listchars=space:·

"折叠方法syntax
set foldmethod=syntax
"打开文件是默认不折叠代码
set foldlevelstart=99

"在获得焦点事件时自动检查文件时间戳. 如果在vim外被修改, 则提示用户. 可以选择重载或者继续编辑
"FocusGained  When Vim got input focus.  Only for the GUI version and a few console versions where this can be detected.
"发现只有在鼠标点击回来时才会触发，上面有解释，看来并不是一个好的方法。
autocmd FocusGained * :checktime
"如果发现文件在vim外被修改, 在vim内没有修改, 则自动重载, 而不是提示用户
set autoread

"快捷键修改
imap jj <Esc>
nnoremap zz :q<CR>
"Ctrl+s默认为锁定屏幕，解锁屏幕为Ctrl+q
"映射Ctrl+s为保存，但是并不生效
"imap <C-s> :w<CR>
"
" ===
" === NERDTree
" ===
map tt :NERDTreeToggle<CR>
"let NERDTreeMapOpenExpl = ""
"let NERDTreeMapUpdir = ""
"let NERDTreeMapUpdirKeepOpen = "l"
"let NERDTreeMapOpenSplit = ""
"let NERDTreeOpenVSplit = ""
"let NERDTreeMapActivateNode = "i"
"let NERDTreeMapOpenInTab = "o"
"let NERDTreeMapPreview = ""
"let NERDTreeMapCloseDir = "n"
"let NERDTreeMapChangeRoot = "y"

" ===
" === Taglist
" ===
map <silent> T :TagbarOpenAutoClose<CR>

" ===
" === NerdCommenter,Toggle是最常用的功能了，因此使用<leader>cc最快速
" ===
map <leader>cc <plug>NERDCommenterToggle

"airline配置
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#formatter = 'jsformatter'
let g:airline#extensions#tabline#fnamemod = ':p:~'
"function! AirlineInit()
"    let g:airline_section_c = airline#section#create(['%p'])
"endfunction
"autocmd VimEnter * call AirlineInit()
let g:airline_powerline_fonts = 1

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
