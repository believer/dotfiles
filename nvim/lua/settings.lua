local o = vim.opt

-- Close all buffers except the current one
vim.cmd([[command BufOnly silent! execute "%bd|e#|bd#"]])
