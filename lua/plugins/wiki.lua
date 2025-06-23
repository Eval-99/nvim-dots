return {
  'lervag/wiki.vim',
  config = function()
    vim.keymap.set('n', '<leader>wc', function()
      local line = vim.api.nvim_get_current_line()
      local states = { '[ ]', '[x]', '[>]', '[~]', '[!]' }
      local s, e = line:find('%[.?.?%]')

      if s and e then
        local current = line:sub(s, e)
        local next_state = '[ ]' -- default if not found

        for i, state in ipairs(states) do
          if state == current then
            next_state = states[(i % #states) + 1]
            break
          end
        end

        local new_line = line:sub(1, s - 1) .. next_state .. line:sub(e + 1)
        vim.api.nvim_set_current_line(new_line)
      end
    end)

    vim.cmd([[
    let g:wiki_root = '~/Documents/Notes/zk'

    " Custom encoder
    "function! Url_encode_custom(str) abort
    "  return substitute(
    "        \ a:str,
    "        \ '[^A-Za-z0-9_.~-’]',
    "        \ '\="%".printf("%02X",char2nr(submatch(0)))',
    "        \ 'g'
    "        \)
    "endfunction

    "\    Url_encode_custom(x) },
    "\    wiki#url#utils#url_encode(x) },
    "\    wiki#url#utils#url_encode_specific(x, '()') },

    let g:wiki_link_creation = {
          \ 'md': {
          \   'link_type': 'wiki',
          \   'url_extension': '.md',
          \   'url_transform': { x ->
          \    wiki#url#utils#url_encode_specific(x, '()') },
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
