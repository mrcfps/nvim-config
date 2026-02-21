# AGENTS.md
Guidance for coding agents working in this Neovim config repository.

## Repository snapshot
- Language: Lua (`lua/user/**`).
- Entry point: `init.lua` requiring modules under `lua/user/`.
- Plugin manager: `lazy.nvim` (bootstrapped in `lua/user/plugins.lua`).
- LSP stack: `nvim-lspconfig`, `mason`, `none-ls`.
- Test UX in editor: `neotest` + `neotest-go`.
- Formatting baseline: `.stylua.toml` and `.editorconfig`.

## Rule file check (Cursor/Copilot)
- `.cursorrules`: not present.
- `.cursor/rules/`: not present.
- `.github/copilot-instructions.md`: not present.
- No extra Cursor/Copilot rule overrides currently apply.

## Important paths
- `init.lua`: top-level load order.
- `lua/user/plugins.lua`: plugin list and Lazy bootstrap.
- `lua/user/options.lua`: editor options.
- `lua/user/keymaps.lua`: global mappings.
- `lua/user/whichkey.lua`: `<leader>` groups, includes testing maps.
- `lua/user/lsp/init.lua`: LSP entry.
- `lua/user/lsp/configs.lua`: per-server registration.
- `lua/user/lsp/null-ls.lua`: formatting/diagnostic sources.
- `lua/user/lsp/settings/*.lua`: server-specific option tables.
- `lazy-lock.json`: pinned plugin revisions.

## Setup and bootstrap commands
Run from `/Users/mrc/.config/nvim`.

1) Sync/update plugins headlessly:
```bash
nvim --headless "+Lazy! sync" +qa
```

2) Smoke test startup with no UI:
```bash
nvim --headless +qa
```

3) Optional health report:
```bash
nvim --headless "+checkhealth" +qa
```

## Build / lint / test commands
This repo is a Neovim config, so there is no traditional build artifact.

### Formatting
- Format all Lua files:
```bash
stylua .
```
- Check formatting only (CI-friendly):
```bash
stylua --check .
```

### Linting and diagnostics
- No standalone linter config (`luacheck` / `selene`) is committed.
- Diagnostics are mainly provided by LSP and `none-ls` in-editor.
- Practical validation commands:
  - `stylua --check .`
  - `nvim --headless +qa`

### Testing
- No unit test suite exists for this Neovim config itself.
- Testing support in config is aimed at Go projects via `neotest-go`.

Shell commands for Go tests (outside Neovim):
- Run all tests:
```bash
go test ./...
```
- Run tests in one package:
```bash
go test ./path/to/pkg
```
- Run a single test (preferred pattern):
```bash
go test ./path/to/pkg -run '^TestName$' -count=1
```
- Run a single subtest:
```bash
go test ./path/to/pkg -run '^TestName$/^subtest_name$' -count=1
```

### In-editor test mappings (`which-key` group `<leader>u`)
- `<leader>u n`: run nearest test.
- `<leader>u u`: run all tests in current file.
- `<leader>u o`: toggle nearest test output panel.
- `<leader>u s`: toggle test summary panel.
- `<leader>u S`: stop current test run.

## Code style guidelines
Follow existing conventions in nearby files; prefer minimal, targeted edits.

### Formatting and whitespace
- 2-space indentation (`.editorconfig`, `.stylua.toml`).
- Unix line endings.
- 160 column width.
- Respect Stylua option `no_call_parentheses = true` where idiomatic.
- Do not introduce trailing whitespace.

### Imports and module loading
- Use `local x = require("module")` for required modules.
- Use guarded loads for optional plugins:
  - `local ok, mod = pcall(require, "module")`
  - `if not ok then return end`
- Keep `require` statements near top unless lazy/conditional load is intentional.

### Module structure
- Keep one responsibility per file (`options`, `keymaps`, `plugins`, etc.).
- Return tables from settings modules in `lua/user/lsp/settings/*.lua`.
- Use side-effect setup modules when the file is config-only.
- Keep namespace pattern `lua/user/<topic>.lua`.

### Naming conventions
- Prefer lowercase snake_case for files and locals.
- Keep common table names concise: `opts`, `setup`, `mappings`, `servers`.
- Use descriptive booleans: `status_ok`, `has_mason`, `has_custom_opts`.
- Preserve existing plugin file naming style (`nvim-tree.lua` is intentional).

### API usage patterns
- Prefer `vim.keymap.set` over legacy mapping APIs.
- Prefer `vim.api.nvim_create_autocmd`/`nvim_create_augroup` for new autocmds.
- Use table-driven configuration where practical.
- Merge nested options with `vim.tbl_deep_extend("force", ...)`.

### Types and table shape discipline
- Lua is dynamic; keep table schemas explicit and stable.
- Avoid mixed array/map tables unless plugin APIs require them.
- Keep options predictable; avoid unnecessary deep nesting.
- Preserve key names expected by plugin/LSP setup functions.

### Error handling and resilience
- Guard optional dependencies with `pcall(require, ...)`.
- Fail gracefully with early `return` if plugin/module is unavailable.
- Check capability support before invoking feature-specific LSP behavior.
- Prefer safe defaults over throwing startup-time errors.

### Editing hygiene
- Do not reformat unrelated files.
- Preserve `init.lua` module order unless dependency changes require reordering.
- When adding a plugin, update plugin declaration and its config module together.
- Keep changes focused; avoid opportunistic refactors.

## Suggested validation sequence after edits
1. `stylua --check .`
2. `nvim --headless +qa`
3. If plugins changed: `nvim --headless "+Lazy! sync" +qa`
4. If Go test integration changed: run one representative single-test `go test -run` command.

## Maintenance notes for future agents
- If Cursor/Copilot rule files are added later, merge them into this document.
- Keep this file aligned with actual repo tooling and commands.
- Prefer commands that are directly executable from shell.
