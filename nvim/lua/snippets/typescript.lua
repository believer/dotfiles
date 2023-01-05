local filename = function()
	return f(function(_args, snip)
		local name = vim.split(snip.snippet.env.TM_FILENAME, ".", true)
		return name[1] or ""
	end)
end

-- Regular snippets available through completion menu
local regular_snippets = {
	-- Console log
	s("clog", fmt("console.log({})", { i(0, "data") })),

	-- Vue test
	s(
		"vtest",
		fmt(
			[[
import {{ render, screen, RenderResult }} from '@testing-library/vue'
import {filename} from '../{filename}.vue'

const setup = (customProps = {{}}): RenderResult => {{
	const props = {{
		...customProps
	}}

	return render({filename}, {{ props }})
}}

test('{test_name}', () => {{
	setup()

	screen.debug()
}})
  ]],
			{
				filename = filename(),
				test_name = i(0, "What does it test?"),
			}
		)
	),
}

-- These will expand automatically
local auto_snippets = {
	-- Testing
	s("expdoc", fmt("expect({}).toBeInTheDocument()", { i(0) })),
	s("expndoc", fmt("expect({}).not.toBeInTheDocument()", { i(0) })),

	-- Testing Library
	s("sdbg", t("screen.debug()")),
	s("sgbt", fmt("screen.getByText(/{name}/i)", { name = i(0) })),
	s("sgblt", fmt("screen.getByLabelText(/{name}/i)", { name = i(0) })),
	s("sqbt", fmt("screen.queryByText(/{name}/i)", { name = i(0) })),
	s("sgbr", fmt("screen.getByRole('{role}', {{ name: /{name}/i }})", { role = i(1, "button"), name = i(2, "name") })),
}

return regular_snippets, auto_snippets