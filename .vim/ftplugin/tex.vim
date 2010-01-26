" PDFLaTeX
map <F4> <ESC>:w<CR>:!pdflatex %<.tex && xpdf %<.pdf<CR><CR>
imap <F4> <ESC>:w<CR>:!pdflatex %<.tex && xpdf %<.pdf<CR>a

map <F5> :!xpdf %<.pdf<CR><CR>
imap <F5> <ESC>:!xpdf %<.pdf<CR>a
