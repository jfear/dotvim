" -----------------------------------------------------------------
" Global Settings
" ----------------------------------------------------------------

set noswapfile
set nocompatible " Forget being compatible with good ol' vi
call pathogen#infect()

" Get that filetype stuff happening
filetype on
filetype plugin on
filetype indent on

syntax on           " Turn on that syntax highlighting
set hidden          " This allows you to leave a buffer with out saving you will be promted to save upon quit
set showmode        " At least let yourself know what mode you're in
set wildmenu        " Enable enhanced command-line completion. Presumes you have compiled with +wildmenu.  See :help 'wildmenu'
set smartindent     " This causes autoindent after certain marks such as '{'
set autoindent      " This will add an indention the same as the current line
set expandtab       " Replace tab with spaces
set tabstop=4       " Replace tab with 4 spaces
set softtabstop=4   " Replace tab with 4 spaces
set shiftwidth=4    " This is kind of like tabstop, except when you are in insert  mode you hit <C-D> or <C-T>
set nonumber          " This adds line numbers
"set tags=./tags,tags     " This adds it so tags looks in the current directory, then it works it way up one directory at a time, until a tags file is found.
set tags+=tags;/
set nospell
"hi clear SpellBad
"hi SpellBad cterm=underline,bold ctermfg=red guifg=red gui=underline,bold

set encoding=utf-8
set scrolloff=3
set showcmd
set wildmode=list:longest
set novisualbell
set nocursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

"let mapleader = ","
nnoremap ,<space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

colorscheme justin
"colorscheme desert2


" -----------------------------------------------------------------------
" Key Mappings
" -----------------------------------------------------------------------

" Let's make it easy to edit and source .vimrc
nmap <silent> ,ev :e $MYVIMRC<cr>
nmap <silent> ,sv :so $MYVIMRC<cr>

" Maps j and k to gj and gk so that when lines wrap you will move down one
" line at a time.
nmap j gj
nmap k gk

"Move the cursor in split mode
noremap <silent> ,h :wincmd h<cr>
noremap <silent> ,j :wincmd j<cr>
noremap <silent> ,k :wincmd k<cr>
noremap <silent> ,l :wincmd l<cr>

" Close different panes in split mode
noremap <silent> ,cj :wincmd j<cr>:close<cr>
noremap <silent> ,ck :wincmd k<cr>:close<cr>
noremap <silent> ,ch :wincmd h<cr>:close<cr>
noremap <silent> ,cl :wincmd l<cr>:close<cr>

" Close the current pane
noremap <silent> ,cc :close<cr>

" Move the current pane
noremap <silent> ,ml <C-W>L
noremap <silent> ,mk <C-W>K
noremap <silent> ,mh <C-W>H
noremap <silent> ,mj <C-W>J

" Map CTRL-E to do what ',' used to do
nnoremap <c-e> ,
vnoremap <c-e> ,
map <F1> <Esc>
imap jj <Esc>

" Add shortcut for spelling
nmap <F6> :setlocal spell! spelllang=en<CR>

" Add shortcut for wrapping
nmap <silent> ,w :set invwrap<CR>:set wrap?<CR>

" Add blank line below/above 
nnoremap + maO<esc>`a
noremap - mao<esc>`a

nmap <C-p> "+gP

" Insert Date
nnoremap <F5> "=strftime("%m/%d/%Y")<CR>P
inoremap <F5> <C-R>=strftime("%m/%d/%Y")<CR>

" -----------------------------------------------------------------------
" Buffer Settings 
" -----------------------------------------------------------------------

" This will make it so that folds are saved and loaded on startup
au BufWinLeave * mkview
au BufWinEnter *.* silent loadview

" automatically give executable permissions if file begins with #! and contains
" '/bin/' in the path
"au BufWritePost *.pl if getline(1) =~ "^#!/usr/bin/perl" | silent !chmod a+x <afile> | endif 

" Change to the current directory of the current file
autocmd BufEnter * lcd %:p:h

" -----------------------------------------------------------------------
" File Type Settings
" -----------------------------------------------------------------------

" Text
au BufRead,BufNewfile *.txt set formatoptions=want
au BufRead,BufNewfile *.txt set lbr 
au BufRead,BufNewfile *.txt set tw=80
au BufRead,BufNewfile *.txt set spell spelllang=en
au BufRead,BufNewfile *.txt set nonumber 

" Latex
au BufRead,BufNewfile *.tex set formatoptions=l
au BufRead,BufNewfile *.tex set nonumber
au BufRead,BufNewfile *.tex set lbr 
au BufRead,BufNewfile *.tex set tw=80
au BufRead,BufNewfile *.tex set spell spelllang=en

" Markdown
au BufRead,BufNewfile *.mkd set formatoptions=want
au BufRead,BufNewfile *.mkd set lbr 
au BufRead,BufNewfile *.mkd set tw=80
au BufRead,BufNewfile *.mkd set spell spelllang=en
au BufRead,BufNewfile *.mkd set nonumber 

" R
au BufRead,BufNewfile *.R set number 
au BufRead,BufNewfile *.r set number 

" BASH
au BufRead,BufNewfile *.sh set number 
au BufRead,BufNewfile *.qsub set number 

" IGV Genome Files
au BufReadCmd *.genome call zip#Browse(expand(""))

" -----------------------------------------------------------------------
" SAS Settings 
" -----------------------------------------------------------------------

" This adds the abbreviaton so that at the command-line if you type
" sas it will run sas on that file
cab _sas !sas % -noterminal

" vim thinks sas .lst files are assembly files.
au BufRead,BufNewFile *.lst set syntax=off
au BufRead,BufNewFile *.log set syntax=sas
au BufRead,BufNewFile *.sas set syntax=sas
au BufRead,BufNewFile *.sas set nospell

let Tlist_highlight_Tag_OnBufEnter = 1
let tlist_sas_settings = 'sas;r:proc;l:label'
let tlist_lst_settings = 'sasout;l:labels'

" Allows copying to X11 clipboard
:com -range Cz :silent :<line1>,<line2>w !xsel -i -b
:com -range Cx :silent :<line1>,<line2>w !xsel -i -p
:com -range Cv :silent :<line1>,<line2>w !xsel -i -s
:ca cv Cv
:ca cz Cz
:ca cx Cx

:com -range Pz :silent :r !xsel -o -b
:com -range Px :silent :r !xsel -o -p
:com -range Pv :silent :r !xsel -o -s

:ca pz Pz
:ca px Px
:ca pv Pv

" -----------------------------------------------------------------------
" Latex Settings
" -----------------------------------------------------------------------

let g:Tex_DefaultTargetFormat = 'pdf'

"-------------------------------------------------------------------------------
"  Perl Settings
"-------------------------------------------------------------------------------

let g:Perl_Debugger='ptkdb'
let perl_fold = 1
let perl_fold_blocks = 1
au BufRead,BufNewfile,BufEnter *.pl set foldmethod=syntax
au BufRead,BufNewfile,BufEnter *.pl set number

" ----------------------------------------------------------------------
" Gvim Settings
" ----------------------------------------------------------------------

if has("gui_running")
    au BufRead,BufNewfile *.*  set guifont=LiberationMono\ 10
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    colorscheme desert2
    set lines=30 columns=150
    set winaltkeys=no
endif

" ----------------------------------------------------------------------
" MISC Settings
" ----------------------------------------------------------------------
cab _gnumeric !gnumeric % &

"=============================================================================
"                                Plugins                                      
"=============================================================================

"-----------------------------------------------------------------------------
" Minibufexplorer Plugin Settings
"-----------------------------------------------------------------------------
let g:miniBufExplorerMoreThanOne=4

"-----------------------------------------------------------------------------
" Fugitive Plugin Settings
"-----------------------------------------------------------------------------
"set statusline+=%{fugitive#statusline()}

"-----------------------------------------------------------------------------
" NERD Tree Plugin Settings
"-----------------------------------------------------------------------------
" Toggle the NERD Tree on an off with F7
nmap <F7> :NERDTreeToggle<CR>

" Close the NERD Tree with Shift-F7
nmap <S-F7> :NERDTreeClose<CR>

" Store the bookmarks file in perforce
let NERDTreeBookmarksFile="~/.vim/NERDTreeBookmarks"

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.ncb$', '\.suo$', '\.vcproj\.RIMNET', '\.obj$', '\.ilk$', '^BuildLog.htm$', '\.pdb$', '\.idb$', '\.embed\.manifest$', '\.embed\.manifest.res$', '\.intermediate\.manifest$', '^mt.dep$' ]

"-----------------------------------------------------------------------------
" R Plugin Settings
"-----------------------------------------------------------------------------
let vimrplugin_screenplugin = 0
let vimrplugin_conqueplugin = 1
let g:vimrplugin_underscore = 0

"-----------------------------------------------------------------------------
" vim-rst-tables Plugin Settings
"-----------------------------------------------------------------------------
noremap <silent> ;;c : call ReformatTable()<CR>
noremap <silent> ;;f : call ReflowTable()<CR>

"-----------------------------------------------------------------------------
" SnipMate Plugin Settings
"-----------------------------------------------------------------------------
let g:snippets_dir = "~/.vim/snippets"
let g:snips_author = "Justin M Fear"
let g:snips_email = "jfear@ufl.edu"



"=============================================================================
"                                Functions                                      
"=============================================================================
function! VO2MD()
  let lines = []
  let was_body = 0
  for line in getline(1,'$')
    if line =~ '^\t*[^:\t]'
      let indent_level = len(matchstr(line, '^\t*'))
      if was_body " <= remove this line to have body lines separated
        call add(lines, '')
      endif " <= remove this line to have body lines separated
      call add(lines, substitute(line, '^\(\t*\)\([^:\t].*\)', '\=repeat("#", indent_level + 1)." ".submatch(2)', ''))
      call add(lines, '')
      let was_body = 0
    else
      call add(lines, substitute(line, '^\t*: ', '', ''))
      let was_body = 1
    endif
  endfor
  silent %d _
  call setline(1, lines)
endfunction

function! MD2VO()
  let lines = []
  for line in getline(1,'$')
    if line =~ '^\s*$'
      continue
    endif
    if line =~ '^#\+'
      let indent_level = len(matchstr(line, '^#\+')) - 1
      call add(lines, substitute(line, '^#\(#*\) ', repeat("\<Tab>", indent_level), ''))
    else
      call add(lines, substitute(line, '^', repeat("\<Tab>", indent_level) . ': ', ''))
    endif
  endfor
  silent %d _
  call setline(1, lines)
endfunction
