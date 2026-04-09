local function pascal_case_filename()
	local name = vim.fn.expand("%:t:r") -- filename without extension
	local parts = vim.split(name, "-", { plain = true })
	for i, part in ipairs(parts) do
		parts[i] = part:sub(1, 1):upper() .. part:sub(2)
	end
	return table.concat(parts)
end

local function capitalize(args)
	local text = args[1][1] or ""
	return text:gsub("^%l", string.upper)
end

-- Regular

local regular = {
	s(
		"uses",
		fmt(
			"const [{name},set{capitalized}] = React.useState({value})",
			{ name = i(1), capitalized = f(capitalize, { 1 }), value = i(2) }
		)
	),
	s(
		{
			trig = "style",
		},
		fmt(
			[[
  const {} = StyleSheet.create((theme) => ({{
    {}
  }}))
  ]],
			{ i(1, "styles"), i(2) }
		)
	),
	s({ trig = "istyle" }, fmt("import {{ StyleSheet }} from 'react-native-unistyles'", {})),
	s({ trig = "st" }, fmt("style={{{{{}}}}}", { i(1) })),
	s({ trig = "color" }, fmt("theme.color.{},", { i(1) })),
	s({ trig = "space" }, fmt("theme.space.{},", { i(1) })),
	s(
		{ trig = "unip" },
		fmt(
			[[
uniProps={{(theme) => ({{
  {}
}})}}
]],
			{ i(0) }
		)
	),
}

-- Auto

local auto = {
	s(
		"rncmp",
		fmt(
			[[
import {{ Text, View }} from 'react-native'

type {filename}Props = {{

}}

export function {filename}({{}}: {filename}Props) {{
  return (
    <View>
      <Text>{filename}</Text>
    </View>
  )
}}
  ]],
			{
				filename = f(pascal_case_filename),
			}
		)
	),

	-- UI components
	s("rnth", fmt([[<T.Heading>{text}</T.Heading>]], { text = i(1, "Text") })),
	s("rntd", fmt([[<T.Detail>{text}</T.Detail>]], { text = i(1, "Text") })),
	s("rntb", fmt([[<T.Body>{text}</T.Body>]], { text = i(1, "Text") })),
	s("rntr", fmt([[<Trans>{text}</Trans>]], { text = i(1, "Text") })),
	s("rntt", fmt([[<T.{type}>{text}</T.{type}>]], { type = i(1, ""), text = i(2, "Text") })),
	s("usel", fmt([[const {{ _ }} = useLingui()]], {})),
	s("imtl", fmt([[import {{ screen, userEvent }} from '@testing-library/react-native']], {})),
}

return regular, auto
