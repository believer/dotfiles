local filename = function()
	return f(function(_args, snip)
		local name = vim.split(snip.snippet.env.TM_FILENAME, ".", true)
		return name[1] or ""
	end)
end

-- Regular snippets available through completion menu
local regular_snippets = {
	s({
		trig = "clog",
		name = "Console.log",
		dscr = "A simple console log",
	}, fmt("console.log({})", { i(0, "data") })),

	-- Assertions
	s("expe", fmt("expect({}).toEqual({})", { i(1), i(2) })),

	s("snap", fmt("expect({}).toMatchSnapshot()", { i(0) })),

	-- create a `describe` block
	s(
		"desc",
		fmt(
			[[
  describe('{test_name}', () => {{
    {content}
  }})
  ]],
			{
				test_name = i(1, "What does it describe?"),
				content = i(2),
			}
		)
	),

	-- Create a `test` block
	s(
		"test",
		fmt(
			[[
    test('{test_name}', () => {{
      {content}
    }})
  ]],
			{ test_name = i(1, "What does it test?"), content = i(2) }
		)
	),

	-- Create an async `test` block
	s(
		"testa",
		fmt(
			[[
    test('{test_name}', async () => {{
      {content}
    }})
  ]],
			{ test_name = i(1, "What does it test?"), content = i(2) }
		)
	),

	-- Create a vitest mock
	s(
		"vmock",
		fmt(
			[[
      vi.mock('{name}', () => {{
        {content}
      }})
    ]],
			{ name = i(1, "What does it mock?"), content = i(2) }
		)
	),
}

-- These will expand automatically
local auto_snippets = {
	-- Assertions
	s("asmock", fmt("asMock({}).mockResolvedValue({})", { i(1), i(2) })),
	s("expdoc", fmt("expect({}).toBeInTheDocument()", { i(0) })),
	s("expndoc", fmt("expect({}).not.toBeInTheDocument()", { i(0) })),
	s("exps", fmt("expect({}).toBeOnTheScreen()", { i(0) })),
	s("expns", fmt("expect({}).not.toBeOnTheScreen()", { i(0) })),
	s("thbcw", fmt("expect({}).toHaveBeenCalledWith({})", { i(1), i(2) })),
	s("thbct", fmt("expect({}).toHaveBeenCalledTimes({})", { i(1), i(2) })),

	-- Create a `describe` block and a `test` block
	s(
		"desct",
		fmt(
			[[
  describe('{describe_name}', () => {{
    test('{test_name}', () => {{
      {content}
    }})
  }})
  ]],
			{
				describe_name = i(1, "What does it describe?"),
				test_name = i(2, "What does it test?"),
				content = i(3),
			}
		)
	),

	-- Testing Library
	s("sdbg", t("screen.debug()")),
	s("sgbt", fmt("screen.getByText(/{name}/i)", { name = i(0) })),
	s("sfbt", fmt("await screen.findByText(/{name}/i)", { name = i(0) })),
	s("sgblt", fmt("screen.getByLabelText(/{name}/i)", { name = i(0) })),
	s("sqbt", fmt("screen.queryByText(/{name}/i)", { name = i(0) })),
	s("sgbr", fmt("screen.getByRole('{role}', {{ name: /{name}/i }})", { role = i(1, "button"), name = i(2, "name") })),
	s(
		"sqbr",
		fmt("screen.queryByRole('{role}', {{ name: /{name}/i }})", { role = i(1, "button"), name = i(2, "name") })
	),

	-- React Native
	s(
		"rncmp",
		fmt(
			[[
import {{ Text, View }} from 'react-native'

type {filename}Props = {{
 
}}

export function {filename} ({{}}: {filename}Props) {{
  return (
    <View>
      <Text>{filename}</Text>
    </View>
  )
}}
  ]],
			{
				filename = filename(),
			}
		)
	),

	-- UI components
	s(
		"rnth",
		fmt([[<T.Heading>{text}</T.Heading>]], {
			text = i(1, "Text"),
		})
	),
	s(
		"rntd",
		fmt([[<T.Detail>{text}</T.Detail>]], {
			text = i(1, "Text"),
		})
	),
	s(
		"rntb",
		fmt([[<T.Body>{text}</T.Body>]], {
			text = i(1, "Text"),
		})
	),
	s(
		"rntr",
		fmt([[<Trans>{text}</Trans>]], {
			text = i(1, "Text"),
		})
	),
	s("usel", fmt([[const {{ _ }} = useLingui()]], {})),
	s("imtl", fmt([[import {{ screen, userEvent }} from '@testing-library/react-native']], {})),
}

return regular_snippets, auto_snippets
