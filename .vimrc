set nocompatible
set t_Co=256 "Active le mode 256 couleurs
set autoread
set title

syntax on
colorscheme glade

filetype indent plugin on
set backspace=indent,eol,start

if has('gui_running')
    set guioptions=haMR
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 13
    set sessionoptions+=resize
    colorscheme wombat256
end

" Div {{{
set number
set wildignore=*.o,*.obj,*.bak,*.exe
set showmatch "Affiche les paires de parenthèses
set nostartofline
"set shortmess=aOstT
set shell=zsh
set mouse=a
set sessionoptions+=buffers,curdir

" Options pour le mode diff
set diffopt=filler,iwhite,vertical

" Mode turbo
set ttyfast
set showcmd
set noswapfile

" Silence
set visualbell
set t_vb=

" Ligne suivante/précédente ssi flèches droite/gauche en bout de ligne
set whichwrap=<,>,[,]

" Backup
set backup
set backupdir=$HOME/.vim/backup
" }}}

" StatusLine {{{
set laststatus=2
set statusline=                                 " clear
set statusline+=%-3.3n\                         " nombre buffer
set statusline+=%f\                             " nom fichier
set statusline+=%h%m%r%w                        " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},     " type fichier
set statusline+=%{strlen(&fenc)?&fenc:&enc},    " encodage
set statusline+=%{&fileformat}]                 " format fichier
set statusline+=%#warningmsg#                   " Syntastic
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%=                              " alignement droite
set statusline+=%-14.(%l,%c%V%)\ %<%P           " offset
" }}}

" Recherche {{{
"Affiche le premier resultat
set incsearch
"Souligne les resultats
set hlsearch
"Recherche intelligente
set smartcase
" }}}

" Indentation {{{
"set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
"set smartindent
"set cindent

"En mode visuel conserve le bloc indenté
:vnoremap < <gv
:vnoremap > >gv
" }}}

" Afficher les tabs / espaces inutiles {{{
if (&termencoding ==# "utf-8") || has("gui_running")
   set list listchars=tab:»·,trail:·,extends:…,nbsp:‗
else
   set list listchars=tab:>-,trail:.,extends:>,nbsp:_
endif " }}}

" Onglets {{{
nmap <C-t> :tabnew<CR>
nmap <C-w> :tabclose<CR>
nmap <S-Right> :tabnext<CR>
nmap <S-Left> :tabprevious<CR>
set showtabline=2
" }}}

" Spell {{{
if has("spell")
   if !filewritable($HOME."/.vim/spell")
       call mkdir($HOME."/.vim/spell", "p")
   endif
   set spellsuggest=10 "10 suggestions
   " On règle les touches d'activation manuelle de la correction orthographique
   noremap ,sf :setlocal spell spelllang=fr <CR>
   noremap ,se :setlocal spell spelllang=en <CR>
   noremap ,sn :setlocal nospell <CR>
endif
" }}}

" PHP {{{
function OpenPhpManual(keyword)
   let web = 'lynx -accept_all_cookies -nopause'
   let url = 'http://php.net/' . a:keyword
   exec '!' . web . ' "' . url . '"'
endfunction

"Colore le html et sql
let php_sql_query = 1
let php_htmlInStrings = 1

noremap gd :call OpenPhpManual(expand('<cword>'))<CR>
" }}}

" Python {{{
"autocmd FileType python set ft=python.django " For SnipMate
"autocmd FileType html set ft=html.django_template " For SnipMate
let python_highlight_numbers = 1
let python_highlight_exceptions = 1
" }}}

" Folding {{{
set foldenable
set foldmethod=marker
set foldmarker={,}
set foldlevel=100

" Sauve et charge automatiquement les folds
autocmd BufWinLeave * if expand("%") != "" | mkview | endif
autocmd BufWinEnter * if expand("%") != "" | loadview | endif
" }}}

" Map {{{
" Fold Toogle
inoremap <F1> <C-O>za
nnoremap <F1> za
onoremap <F1> <C-C>za
vnoremap <F1> zf

inoremap jj <ESC>
" Formate paragraphe
nmap Q gqap

set pastetoggle=<F2>

" Supprime les lignes successives identiques
map <F3> <CR>:%s/^\(.*\)\n\(\1\n\)*/\1\r/<CR>:nohlsearch<CR>

" Raccourcis clavier pour la sauvegarde/restauration des sessions
nnoremap <F4> :mksession! ~/.vim/sessions/
nnoremap <F5> :so ~/.vim/sessions/

" ,id insère la date
imap ,id <C-R>=strftime("%c")<CR>
" }}}

" Plugin {{{
" Completition
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

"Syntastic
let g:syntastic_enable_signs=1
" }}}
