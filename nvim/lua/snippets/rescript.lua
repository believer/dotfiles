local regular_snippets = {
	s({
		trig = "clog",
		name = "Js.log",
		dscr = "Console log",
	}, fmt("Js.log({})", { i(0, "data") })),

	s(
		{
			trig = "swc",
			name = "Switch case",
			dscr = "Adds a switch case statement",
		},
		fmt(
			[[
switch {} {{

}}
]],
			{ i(0, "data") }
		)
	),

	s(
		{
			trig = "swcr",
			name = "Switch case wrapped",
			dscr = "Adds a switch case statement for use in JSX",
		},
		fmt(
			[[
{{switch {} {{

}}}}
]],
			{ i(0, "data") }
		)
	),
}

return regular_snippets
