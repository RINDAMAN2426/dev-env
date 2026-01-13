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

## LSP & Code Actions

### Code Actions
Quick fixes, refactorings, and code improvements suggested by your LSP server.

#### Usage
1. Place cursor on code with suggestions (look for lightbulb 💡 or diagnostic)
2. Press `<leader>ca` to open code action menu
3. Select action with `j/k` and `<CR>` to apply

#### Common Code Actions
- **Auto-import** - Add missing imports
- **Quick fix** - Fix linter/compiler errors
- **Extract** - Extract to function/variable
- **Organize imports** - Sort and remove unused imports
- **Generate** - Generate getters/setters/constructors
- **Refactor** - Rename, move, inline, etc.

### LSP Keymaps

| Key | Description | Example Use Case |
|-----|-------------|------------------|
| `<leader>ca` | Code action | Fix import, extract function |
| `<leader>rn` | Rename symbol | Rename variable across files |
| `<leader>fm` | Format buffer | Auto-format code |
| `gd` | Go to definition | Jump to function definition |
| `gD` | Go to declaration | Jump to interface declaration |
| `gr` | Find references | See all usages |
| `gi` | Go to implementation | Jump to implementation |
| `K` | Hover documentation | Show type info |
| `<leader>k` | Signature help | Show function parameters |
| `gl` | Show diagnostic | Show error details |
| `[d` | Previous diagnostic | Jump to previous error |
| `]d` | Next diagnostic | Jump to next error |

### Code Action Examples

#### Auto-import (JavaScript/TypeScript)
```javascript
// Cursor on 'useState' with no import
const [count, setCount] = useState(0);
//                         ^^^^^^^^ undefined

// Press <leader>ca
// Select: "Add import from 'react'"
// Result:
import { useState } from 'react';
```

#### Quick fix (Python)
```python
# Cursor on undefined variable
print(messge)  # Typo!
#     ^^^^^^^ NameError

# Press <leader>ca
# Select: "Change to 'message'"
# Or: "Add 'messge = ...'
```

#### Extract function
```javascript
// Select code block in visual mode
const total = items.reduce((sum, item) => sum + item.price, 0);
const tax = total * 0.1;
const final = total + tax;

// Press <leader>ca
// Select: "Extract to function"
// Result:
function calculateTotal(items) {
  const total = items.reduce((sum, item) => sum + item.price, 0);
  const tax = total * 0.1;
  return total + tax;
}
```

### Biome Integration

Since Biome LSP is configured, you get additional actions:

- **Fix all** - Apply all safe fixes
- **Organize imports** - Sort and group imports
- **Remove unused** - Remove unused variables
- **Format** - Format with Biome rules

Press `<leader>ca` on any file to see available Biome actions.

### Tips

#### Quick Fix Workflow
```vim
" 1. Jump to diagnostic
]d

" 2. See error details
gl

" 3. Apply fix
<leader>ca

" 4. Next error
]d
```

#### Bulk Refactoring
```vim
" 1. Rename symbol
<leader>rn

" 2. Type new name
newFunctionName<CR>

" 3. All references updated across workspace!
```

#### Format on Save
Already configured in LSP setup - saves automatically format if LSP supports it.

## Quick Reference

### All Keymaps Summary

#### File & Navigation
- `<leader>p` - Git files
- `<leader>fp` - Find files
- `<leader>ff` - Live grep (search text)
- `<leader>fb` - Buffers
- `<leader>b` - Toggle file explorer
- `<leader>]` / `<leader>[` - Next/Previous buffer
- `<leader>x` - Close buffer
- `<C-s>` - Save file

#### LSP & Code
- `<leader>ca` - **Code action** 💡
- `<leader>rn` - Rename
- `<leader>fm` - Format
- `gd` / `gD` - Definition / Declaration
- `gr` / `gi` - References / Implementation
- `K` - Hover
- `gl` - Show diagnostic
- `[d` / `]d` - Prev/Next diagnostic

#### Testing (Neotest)
- `<leader>ts` - Test summary
- `<leader>tt` - Test file
- `<leader>tr` - Test nearest
- `<leader>tl` - Test last
- `<leader>tc` - **Reload for monorepo**

#### Diagnostics (Trouble)
- `<leader>dx` - All diagnostics
- `<leader>dw` - Buffer diagnostics
- `<leader>dl` - Location list
- `<leader>dq` - Quickfix list

### Workflow Examples

#### New to codebase
```vim
<leader>p          " Find file in git
gd                 " Go to definition
gr                 " See all usages
K                  " Read documentation
```

#### Fix errors
```vim
<leader>dx         " Open diagnostics
]d                 " Next error
<leader>ca         " Apply fix
<leader>fm         " Format
```

#### Test driven development
```vim
:cd backend/service
<leader>tc         " Set test root
<leader>ts         " Open test summary
<leader>tw         " Watch mode ON
" Edit code, tests auto-run!
```

#### Refactoring
```vim
<leader>rn         " Rename variable
<leader>ca         " Extract function
<leader>fm         " Format code
:w                 " Save
```

---

**Happy coding! 🚀**
