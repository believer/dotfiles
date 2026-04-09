-- Regular

local regular = {
	s({
		trig = "clog",
		name = "Console.log",
		dscr = "A simple console log",
		condition = conds.line_begin,
	}, fmt("console.log({})", { i(0, "data") })),
	s(
		"t",
		fmt(
			[[
type {} = {{
  {}
}}
      ]],
			{ i(1, "T"), i(2) }
		)
	),
	s(
		{ trig = "fn", condition = conds.line_begin },
		fmt(
			[[
function {name}() {{
  {content}
}}
  ]],
			{ name = i(1), content = i(2) }
		)
	),
	s(
		{ trig = "efn", condition = conds.line_begin },
		fmt(
			[[
export function {}() {{
  {}
}}
  ]],
			{ i(1), i(2) }
		)
	),
}

-- Auto

local auto = {}

return regular, auto
