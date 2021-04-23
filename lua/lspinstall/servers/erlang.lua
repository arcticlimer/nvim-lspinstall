local config = require'lspconfig'.erlangls.document_config
require'lspconfig/configs'.erlangls = nil -- important, immediately unset the loaded config again
config.default_config.cmd = { "./erlang-ls/erlang_ls" }

return vim.tbl_extend('error', config, {
  install_script = [[
    rm -rf erlang-ls
    curl -fL -o erlang-ls.zip $(curl -s https://api.github.com/repos/erlang-ls/erlang_ls/releases/latest \
      | grep "zipball_url" \
      | cut -d : -f 2,3 \
      | tr -d \" \
      | tr -d ,)

    unzip erlang-ls.zip -d erlang-ls
    (cd erlang-ls/erlang* && make && mv _build/*/bin/* ..)
    rm erlang-ls.zip
  ]],
})
