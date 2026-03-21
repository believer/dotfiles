---@diagnostic disable: undefined-global

local regular_snippets = {
	s({
		trig = "clog",
		name = "fmt.Println",
		dscr = "fmt",
	}, fmt("fmt.Println({})", { i(0, "data") })),
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
