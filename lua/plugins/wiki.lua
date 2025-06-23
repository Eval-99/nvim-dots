return {
  'lervag/wiki.vim',
  config = function()
    vim.cmd([[
    let g:wiki_root = '~/Documents/Notes/zk'
    let g:wiki_link_creation = {
          \ 'md': {
          \   'link_type': 'md',
          \   'url_extension': '.md',
          \   'url_transform': { x ->
          \     wiki#url#utils#url_encode(x) },
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
    ]])
  end,
}
