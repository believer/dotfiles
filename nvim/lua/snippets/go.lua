---@diagnostic disable: undefined-global

local regular_snippets = {
	s({ trig = "clog", name = "fmt.Println", dscr = "Log" }, fmt("fmt.Println({})", { i(0, "data") })),
	s({ trig = "fn", name = "function", dscr = "Function call" }, fmt("func {}(){{ {} }}", { i(1), i(2) })),
}

local auto_snippets = {
	s(
		"enil",
		fmt(
			[[if err != nil {{
    return err
  }}]],
			{}
		)
	),
}

return regular_snippets, auto_snippets
