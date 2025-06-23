return {
  'lervag/wiki.vim',
  config = function()
    vim.cmd([[
    let g:wiki_root = '~/Documents/Notes/zk'
    let g:wiki_link_creation = {
          \ 'md': {
          \   'link_type': 'wiki',
          \   'url_extension': '.md',
          \   'url_transform': { x ->
          \     wiki#url#utils#url_encode_specific(x, '()') },
          \   'link_text': { url -> wiki#toc#get_page_title(url) },
          \ },
          \ 'org': {
          \   'link_type': 'org',
          \   'url_extension': '.org',
          \ },
          \ 'adoc': {
          \   'link_type': 'adoc_xref_bracket',
          \   'url_extension': '',
          \ },
          \ '_': {
          \   'link_type': 'wiki',
          \   'url_extension': '',
          \ },
          \}

   " " Regular encoder and markdown links.
   " let g:wiki_link_creation = {
   "       \ 'md': {
   "       \   'link_type': 'md',
   "       \   'url_extension': '.md',
   "       \   'url_transform': { x ->
   "       \     wiki#url#utils#url_encode(x) },
   "       \   'link_text': { url -> wiki#toc#get_page_title(url) },
   "       \ },
   "       \ 'org': {
   "       \   'link_type': 'org',
   "       \   'url_extension': '.org',
   "       \ },
   "       \ 'adoc': {
   "       \   'link_type': 'adoc_xref_bracket',
   "       \   'url_extension': '',
   "       \ },
   "       \ '_': {
   "       \   'link_type': 'wiki',
   "       \   'url_extension': '',
   "       \ },
   "       \}

   " " Custom encoder and markdown links.
   " function! Url_encode_custom(str) abort
   "   return substitute(
   "         \ a:str,
   "         \ '[^A-Za-z0-9_.~-’]',
   "         \ '\="%".printf("%02X",char2nr(submatch(0)))',
   "         \ 'g'
   "         \)
   " endfunction

   " let g:wiki_link_creation = {
   "       \ 'md': {
   "       \   'link_type': 'md',
   "       \   'url_extension': '.md',
   "       \   'url_transform': { x ->
   "       \     Url_encode_custom(x) },
   "       \   'link_text': { url -> wiki#toc#get_page_title(url) },
   "       \ },
   "       \ 'org': {
   "       \   'link_type': 'org',
   "       \   'url_extension': '.org',
   "       \ },
   "       \ 'adoc': {
   "       \   'link_type': 'adoc_xref_bracket',
   "       \   'url_extension': '',
   "       \ },
   "       \ '_': {
   "       \   'link_type': 'wiki',
   "       \   'url_extension': '',
   "       \ },
   "       \}
    ]])
  end,
}
