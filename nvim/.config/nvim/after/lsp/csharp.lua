return {
	cmd = {
		"roslyn-language-server",
		"--stdio",
	},
	settings = {
		["csharp|background_analysis"] = {
			dotnet_analyzer_diagnostics_scope = "fullSolution",
			dotnet_compiler_diagnostics_scope = "fullSolution",
		},

		-- Fine-grained Inlay Hints (avoids visual clutter while keeping key types clear)
		["csharp|inlay_hints"] = {
			csharp_enable_inlay_hints_for_implicit_object_creation = true,
			csharp_enable_inlay_hints_for_implicit_variable_types = true,
			csharp_enable_inlay_hints_for_lambda_parameter_types = true,
			csharp_enable_inlay_hints_for_types = true,
			dotnet_enable_inlay_hints_for_indexer_parameters = true,
			dotnet_enable_inlay_hints_for_literal_parameters = true,
			dotnet_enable_inlay_hints_for_object_creation_parameters = true,
			dotnet_enable_inlay_hints_for_other_parameters = true,
			dotnet_enable_inlay_hints_for_parameters = true,
			-- Suppress obvious hints so your buffer doesn't feel congested
			dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
			dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
			dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
		},

		-- IntelliSense & Completion
		["csharp|completion"] = {
			-- Auto-imports: suggest types/extension methods not yet imported via 'using'
			dotnet_show_completion_items_from_unimported_namespaces = true,
			-- Suggests variable names matching the assigned type (e.g., `UserService userService`)
			dotnet_show_name_completion_suggestions = true,
			-- Rich regex syntax completion inside Regex patterns
			dotnet_provide_regex_completions = true,
		},

		-- CodeLens (shows reference counts & unit test runners above symbols)
		["csharp|code_lens"] = {
			dotnet_enable_references_code_lens = true,
			dotnet_enable_tests_code_lens = true,
		},

		-- Workspace Symbol Search (Telescope / Fzf-Lua workspace_symbols)
		["csharp|symbol_search"] = {
			-- Look up symbols in external NuGet packages and runtime assemblies
			dotnet_search_reference_assemblies = true,
		},

		-- Formatting Rules
		["csharp|formatting"] = {
			-- Automatically sorts 'using' statements when formatting
			dotnet_organize_imports_on_format = true,
		},
	},
}
