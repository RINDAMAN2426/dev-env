# Monorepo Testing Guide

## Problem
In a monorepo structure like:
```
monorepo/
├── python/       (pytest)
│   └── tests/
├── backend-a/    (mocha)
│   └── test/
├── frontend/     (jest/vitest)
│   └── __tests__/
└── services/
    └── go/       (go test)
```

Neotest would scan ALL subdirectories by default, which is slow and unnecessary.

## Supported Test Frameworks

- **Mocha** - JavaScript/TypeScript ([adrigzr/neotest-mocha](https://github.com/adrigzr/neotest-mocha))
- **Jest** - JavaScript/TypeScript (React, etc.)
- **Vitest** - JavaScript/TypeScript (Vite)
- **Pytest** - Python
- **Go Test** - Go
- **Plenary** - Lua (Neovim plugin development)

### Requirements
- Mocha v9.1.0 or higher
- Neotest 4.0.0 or higher (requires Neovim 0.9.0+)

## Solution
This configuration restricts test discovery to your **current working directory**.

## Usage

### 1. Navigate to your subrepo
```vim
:cd monorepo/a
```
or use Neo-tree (`<leader>b`) to change directory.

### 2. Set test root (optional)
```vim
<leader>tc
```
This confirms the current directory as the test root.

### 3. Open test summary
```vim
<leader>ts
```
Now only tests in `monorepo/a/` will be shown.

## How it works

### Discovery Settings
```lua
discovery = {
  enabled = true,
  concurrent = 1,  -- Limit concurrent discovery
}
```

### Adapter Root Directory
Each test adapter (Jest, Vitest, Pytest, Go) is configured to:
- Use `vim.fn.getcwd()` as root
- Filter out parent directories
- Exclude `node_modules`, `.git`, etc.

### Filter Function
```lua
filter_dir = function(name, rel_path, root)
  -- Only include paths within current cwd
  local cwd = vim.fn.getcwd()
  local full_path = root .. "/" .. rel_path .. "/" .. name
  return vim.startswith(full_path, cwd)
end
```

## Tips

### Quick directory change
1. Open Neo-tree: `<leader>b`
2. Navigate to subrepo
3. Press `cd` in Neo-tree to change working directory
4. Close Neo-tree: `<leader>b`
5. Open test summary: `<leader>ts`

### Check current working directory
```vim
:pwd
```

### Auto-change to buffer directory
Add to your config if you want vim to auto-cd to file's directory:
```lua
vim.opt.autochdir = true
```
(Not recommended for monorepo - better to explicitly set cwd)

## Keymaps

### Main Keymaps
| Key | Description |
|-----|-------------|
| `<leader>tc` | Reload neotest for current directory |
| `<leader>ts` | Open test summary (scoped to cwd) |
| `<leader>tt` | Run tests in current file |
| `<leader>tT` | Run all tests (in cwd) |
| `<leader>tr` | Run test nearest to cursor |
| `<leader>tl` | Run last test |
| `<leader>to` | Show test output |
| `<leader>tO` | Toggle test output panel |
| `<leader>tw` | Toggle watch mode |
| `<leader>td` | Debug test at cursor |

### Summary Panel Keymaps
When inside the test summary panel:

| Key | Description |
|-----|-------------|
| `<CR>` or Double-click | Expand/collapse directory or test suite |
| `i` | Jump to file (open test file in editor) |
| `r` | Run selected test |
| `d` | Debug selected test |
| `o` | Show test output |
| `w` | Toggle watch for test |
| `J` | Jump to next failed test |
| `K` | Jump to previous failed test |
| `e` | Expand all tests |
| `m` | Mark test |
| `R` | Run marked tests |
| `M` | Clear marked tests |
| `u` | Stop running tests |
| `q` | Close summary |

## Performance

Before: Scans entire monorepo (slow) - e.g., 1843 tests
After: Scans only current subrepo (fast) - e.g., 23 tests

Test discovery is now limited to your active workspace, significantly improving performance in large monorepos.

## Real Example

### Before (Scanning entire monorepo)
```vim
:pwd
"/home/user/monorepo"

<leader>ts
" Shows: neotest-python Δ 1843 ✓ 0 ✖ 0 ● 0 ○ 0
" Includes: backends, data, python, experimentals, etc.
" Problem: Too many tests!
```

### After (Scoped to subrepo)
```vim
:cd backends/chat-service
<leader>tc
" Output: Neotest reloaded. Root: /home/user/monorepo/backends/chat-service

<leader>ts
" Shows: neotest-mocha Δ 23 ✓ 0 ✖ 0 ● 0 ○ 0
" Includes: Only tests in chat-service/
" Success: Fast and focused!
```

## Using Summary Panel

1. Open summary: `<leader>ts`
2. Navigate with `j/k` or arrow keys
3. Expand/collapse directories with `<CR>` or double-click
4. Press `i` on a test file to open it in editor
5. Press `r` on a test to run it
6. Press `o` to see test output

## Troubleshooting

### Still scanning parent directories?
```vim
" 1. Restart Neovim
" 2. Navigate to your subrepo
:cd your/subrepo

" 3. Reload neotest
<leader>tc

" 4. Close and reopen summary
<leader>ts
<leader>ts
```

### Which test framework is detected?
Look at the top of the summary panel:
- `neotest-mocha` - Mocha tests
- `neotest-jest` - Jest tests
- `neotest-vitest` - Vitest tests
- `neotest-python` - Python tests
- `neotest-go` - Go tests

### Mocha Configuration
Neotest-mocha will automatically detect your Mocha configuration:
- `.mocharc.json`, `.mocharc.yml`, `.mocharc.js`
- `mocha` section in `package.json`
- Command-line arguments via `command_args`

The adapter uses JSON reporter to parse test results and integrates with Neotest's UI.
