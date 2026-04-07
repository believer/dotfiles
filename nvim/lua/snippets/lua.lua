---@diagnostic disable: undefined-global

local regular_snippets = {
	s({ trig = "fn" }, fmt("function() {} end", { i(0) })),
	s(
		{ trig = "map" },
		fmt('map("n", "{from}", "{to}")', {
			from = i(1),
			to = i(2),
		})
	),
}

return regular_snippets
