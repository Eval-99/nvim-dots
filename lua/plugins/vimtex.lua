return {
  'lervag/vimtex',
  config = function()
    vim.cmd([[

let g:vimtex_view_method = 'zathura'
set formatoptions=tcroqln
au BufRead,BufNewFile *.tex set comments+=b:\\item
au BufRead,BufNewFile *.tex set comments+=b:\\item[]
inoremap <expr> <CR> getline('.') =~ '\item $' ? '<c-w><c-w>' : '<CR>'
inoremap <expr> <CR> getline('.') =~ '\item[] $' ? '<c-w><c-w>' : '<CR>'
let g:vimtex_compiler_latexmk_engines = {
    \ '_'                : '-lualatex',
    \}

let g:vimtex_quickfix_ignore_filters = [
  \ 'LaTeX Warning: Command \\under\(bar\|line\)  has changed.',
  \]

]])
  end,
}
