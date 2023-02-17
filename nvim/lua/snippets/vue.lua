require("luasnip").filetype_extend("vue", { "typescript" })

local regular_snippets = {
	s(
		{
			trig = "vue",
			name = "Vue component",
			dscr = "A simple Vue SFC using TypeScript and script setup",
		},
		fmt(
			[[<template>
</template>

<script lang="ts" setup>
{}
</script>]],
			{ i(0) }
		)
	),
}

return regular_snippets
