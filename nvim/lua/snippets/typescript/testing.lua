local function exp1(trig, matcher)
	return s(trig, fmt("expect({}).to" .. matcher, { i(1) }))
end

local function exp2(trig, matcher)
	return s(trig, fmt("expect({}).to" .. matcher, { i(1), i(2) }))
end

local function expnot1(trig, matcher)
	return s(trig, fmt("expect({}).not.to" .. matcher, { i(1) }))
end

local function test_block(async)
	local prefix = async and "async " or ""
	return fmt(
		[[
test('{name}', {prefix}() => {{
  {content}
}})
        ]],
		{ name = i(1, "What does it test?"), prefix = t(prefix), content = i(2) }
	)
end

local function describe_block(async)
	local prefix = async and "async " or ""
	return fmt(
		[[
describe('{desc}', () => {{
  test('{name}', {prefix}() => {{
    {content}
  }})
}})
        ]],
		{
			desc = i(1, "What does it describe?"),
			name = i(2, "What does it test?"),
			prefix = t(prefix),
			content = i(3),
		}
	)
end

local function screen_query(trig, method, awaited)
	local prefix = awaited and "await " or ""
	return s(
		trig,
		fmt(prefix .. "screen.{method}(/{name}/i)", {
			method = t(method),
			name = i(1),
		})
	)
end

local function screen_role(trig, method)
	return s(
		trig,
		fmt("screen.{method}('{role}', {{ name: /{name}/i }})", {
			method = t(method),
			role = i(1, "button"),
			name = i(2, "name"),
		})
	)
end

-- Regular

local regular = {
	-- Assertions
	exp2("expe", "Equal({})"),
	exp2("snap", "MatchSnapshot({})"),
	exp1("expdoc", "BeInTheDocument()"),
	expnot1("expndoc", "BeInTheDocument()"),
	exp1("exps", "BeOnTheScreen()"),
	expnot1("expns", "BeOnTheScreen()"),
	exp2("thbcw", "HaveBeenCalledWith({})"),
	exp1("thbc", "HaveBeenCalled()"),
	expnot1("nthbc", "HaveBeenCalled()"),
	exp2("thbct", "HaveBeenCalledTimes({})"),

	-- Test setup
	s(
		"tsetup",
		fmt(
			[[import {{ screen, userEvent }} from '@testing-library/react-native'
import {{ settle }} from '#/test-setup/settle'
import {{ renderWithProviders }} from '#/test-setup/test-wrapper'

async function setup() {{
  const {{ queryClient }} = await renderWithProviders({component})
  await settle(queryClient)
}}

test('What does it test?', async () => {{
  {content} 
}})
    ]],
			{ component = i(1), content = i(2) }
		)
	),
	s(
		"desc",
		fmt([[describe('{name}', () => {{{content}}})]], { name = i(1, "What does it describe?"), content = i(2) })
	),
	s("test", test_block(false)),
	s("testa", test_block(true)),
	s("desct", describe_block(false)),
	s("descat", describe_block(true)),
	s(
		{ trig = "beach", condition = conds.line_begin },
		fmt(
			[[
beforeEach(() => {{
  {}
}})
  ]],
			{ i(1) }
		)
	),
	s(
		{ trig = "aeach", condition = conds.line_begin },
		fmt(
			[[
afterEach(() => {{
  {}
}})
  ]],
			{ i(1) }
		)
	),
	s(
		{ trig = "aall", condition = conds.line_begin },
		fmt(
			[[
afterAll(() => {{
  {}
}})
  ]],
			{ i(1) }
		)
	),

	-- Testing Library
	s("sdbg", t("screen.debug()")),
	screen_query("sgbt", "getByText", false),
	screen_query("sgabt", "getAllByText", false),
	screen_query("sgbti", "getByTestId", false),
	screen_query("sgabti", "getAllByTestId", false),
	screen_query("sfbt", "findByText", true),
	screen_query("sgblt", "getByLabelText", false),
	screen_query("sqbt", "queryByText", false),
	screen_query("sqbti", "queryByTestId", false),
	screen_role("sgbr", "getByRole"),
	screen_role("sqbr", "queryByRole"),

	s(
		"sus",
		fmt(
			[[
server.use(http.get(url({}), () => ok({})))
  ]],
			{ i(1), i(2) }
		)
	),
	s(
		"suse",
		fmt(
			[[
server.use(http.get(url({}), () => err({})))
  ]],
			{ i(1), i(2) }
		)
	),
	s(
		"isus",
		fmt(
			[[
import {{ http }} from 'msw'
import {{ err, ok, server, url }} from '#/test-setup/server-handlers'
  ]],
			{}
		)
	),
}

-- Auto

local auto = {}

return regular, auto
