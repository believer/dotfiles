local ls = require 'luasnip'

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- All buffers
ls.add_snippets('all', {
  -- Console.log
  s('clog', { t('console.log('), i(1, 'data'), t(')') })
})
