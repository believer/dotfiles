local regular_snippets = {
	s("today", {
		f(function()
			return os.date("[%Y-%m-%d %a %H:%M]")
		end, {}),
	}),

	s("header", {
		t("#+TITLE: "),
		i(1, "Title"),
		t({ "", "#+AUTHOR: Rickard Natt och Dag" }),
		t({ "", "#+CREATED: " }),
		f(function()
			return os.date("[%Y-%m-%d %a %H:%M]")
		end),
	}),

	s("quote", {
		t({ "#+begin_quote", "" }),
		i(1, "Enter quote text..."),
		t({ "", "#+end_quote" }),
	}),

	s("src", {
		t("#+begin_src "),
		i(1, "language"), -- Cursor starts here, type your language
		t({ "", "" }),
		i(2, "  "), -- Press tab again to jump here for the code
		t({ "", "#+end_src" }),
	}),
}

return regular_snippets
