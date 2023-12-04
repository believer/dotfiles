local regular_snippets = {
	s({
		trig = "clog",
		name = "log.Println",
		dscr = "Log",
	}, fmt("log.Println({})", { i(0, "data") })),
}

local auto_snippets = {
	s(
		"enil",
		fmt(
			[[if err != nil {{
    log.Fatalln(err)
  }}]],
			{}
		)
	),
}

return regular_snippets, auto_snippets
