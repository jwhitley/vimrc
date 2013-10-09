" Override .md in favor of markdown vs Modula-2
au BufNewFile,BufRead *.md set filetype=markdown

" Add Puppetfile to the ruby filetype
au BufNewFile,BufRead Puppetfile set filetype=ruby
