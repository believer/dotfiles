local regular_snippets = {
	s({
		trig = "clog",
		name = "Console log",
		dscr = "Console log",
	}, fmt('println!("{{}}", {});', { i(0, "data") })),
}

return regular_snippets
