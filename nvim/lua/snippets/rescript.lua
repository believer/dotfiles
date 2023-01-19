local regular_snippets = {
	s({
		trig = "clog",
		name = "Js.log",
		dscr = "Console log",
	}, fmt("Js.log({})", { i(0, "data") })),
}

return regular_snippets
