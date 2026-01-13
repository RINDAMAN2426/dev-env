# Neovim Configuration

A minimal, fast Neovim configuration with modern LSP, testing, and UI features.

## Features

- **Plugin Management**: lazy.nvim with auto-bootstrap
- **LSP Support**: TypeScript, Lua, Python, Biome, and more
- **Syntax Highlighting**: Tree-sitter based with folding support
- **File Explorer**: Neo-tree with Git integration
- **Fuzzy Finding**: Telescope for files, grep, buffers
- **Test Runner**: Neotest with multi-framework support (Jest, Vitest, Pytest, Go, Mocha)
- **Diagnostics**: Trouble.nvim for error browsing
- **Auto-completion**: nvim-cmp with LSP, buffer, and path sources
- **Git Integration**: Gitsigns for inline git status
- **UI Enhancements**: Custom statusline, buffer line, indent guides

## Installation

### Prerequisites

```bash
# macOS
brew install neovim tree-sitter

# Install language servers as needed
npm install -g typescript-language-server
npm install -g @biomejs/biome
```

### Setup

1. Clone this configuration:
```bash
git clone <your-repo-url> ~/.config/nvim
```

2. Launch Neovim:
```bash
nvim
```

3. lazy.nvim will automatically bootstrap and install all plugins on first launch.

## Configuration Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── core/
│   │   ├── colors.lua         # Color scheme setup
│   │   ├── options.lua        # Vim options
│   │   ├── ui.lua             # UI configuration
│   │   ├── lsp.lua            # LSP base setup
│   │   └── keymaps.lua        # Global keymaps
│   └── plugins/
│       ├── manager.lua        # lazy.nvim bootstrap
│       └── specs/
│           ├── init.lua       # Plugin imports
│           ├── bufferline.lua # Buffer tabs
│           ├── cmp.lua        # Auto-completion
│           ├── diagnostics.lua # Trouble.nvim
│           ├── explorer.lua   # Neo-tree
│           ├── git.lua        # Git integration
│           ├── lsp.lua        # Language servers
│           ├── neotest.lua    # Test runner
│           ├── telescope.lua  # Fuzzy finder
│           ├── treesitter.lua # Syntax highlighting
│           └── ui.lua         # UI plugins
└── README.md                  # This file
```

## Key Mappings

Leader key: `<Space>`

### File & Navigation

| Key | Description |
|-----|-------------|
| `<leader>p` | Find Git files (Telescope) |
| `<leader>fp` | Find all files (Telescope) |
| `<leader>ff` | Live grep (search text in files) |
| `<leader>fb` | Find buffers (Telescope) |
| `<leader>b` | Toggle Neo-tree file explorer |
| `<leader>]` | Next buffer |
| `<leader>[` | Previous buffer |
| `<leader>x` | Close current buffer |
| `<C-s>` | Save file |

### LSP & Code Actions

| Key | Description |
|-----|-------------|
| `<leader>ca` | Code action (fixes, refactorings) 💡 |
| `<leader>rn` | Rename symbol |
| `<leader>fm` | Format buffer |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<leader>k` | Signature help |
| `gl` | Show diagnostic details |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

### Diagnostics (Trouble)

| Key | Description |
|-----|-------------|
| `<leader>dx` | Show all diagnostics |
| `<leader>dw` | Show buffer diagnostics |
| `<leader>dl` | Location list |
| `<leader>dq` | Quickfix list |

### Testing (Neotest)

| Key | Description |
|-----|-------------|
| `<leader>ts` | Open test summary |
| `<leader>tt` | Run tests in current file |
| `<leader>tT` | Run all tests |
| `<leader>tr` | Run test nearest to cursor |
| `<leader>tl` | Run last test |
| `<leader>to` | Show test output |
| `<leader>tO` | Toggle test output panel |
| `<leader>tw` | Toggle watch mode |
| `<leader>td` | Debug test at cursor |
| `<leader>tc` | Reload Neotest (for monorepo) |

## LSP Configuration

### Configured Language Servers

- **TypeScript/JavaScript**: `ts_ls` (tsserver)
- **Lua**: `lua_ls` with Neovim API support
- **Python**: `pyright`
- **Biome**: `biome` (JavaScript/TypeScript linting & formatting)

### Code Actions

Code actions provide quick fixes and refactorings. Press `<leader>ca` when your cursor is on:

#### Auto-import Example (TypeScript)
```typescript
// Cursor on 'useState' with no import
const [count, setCount] = useState(0);
//                         ^^^^^^^^ error

// Press <leader>ca → Select "Add import from 'react'"
// Result:
import { useState } from 'react';
```

#### Quick Fix Example (Python)
```python
# Cursor on typo
print(messge)  # NameError
#     ^^^^^^

# Press <leader>ca → Select "Change to 'message'"
```

#### Extract Function Example
```javascript
// Visual select code block
const total = items.reduce((sum, item) => sum + item.price, 0);
const tax = total * 0.1;
const final = total + tax;

// Press <leader>ca → Select "Extract to function"
// Result:
function calculateTotal(items) {
  const total = items.reduce((sum, item) => sum + item.price, 0);
  const tax = total * 0.1;
  return total + tax;
}
```

### Biome Integration

With Biome LSP configured, you get:
- **Fix all**: Apply all safe fixes at once
- **Organize imports**: Sort and group imports
- **Remove unused**: Remove unused variables
- **Format**: Format with Biome rules

Press `<leader>ca` to see available Biome actions.

## Test Explorer

Neotest provides a unified testing interface for multiple frameworks.

### Supported Test Frameworks

- **Jest** - JavaScript/TypeScript (React, etc.)
- **Vitest** - JavaScript/TypeScript (Vite)
- **Mocha** - JavaScript/TypeScript ([neotest-mocha](https://github.com/adrigzr/neotest-mocha))
- **Pytest** - Python
- **Go Test** - Go
- **Plenary** - Lua (Neovim plugin development)

**Requirements:**
- Mocha v9.1.0 or higher
- Neotest 4.0.0 or higher (requires Neovim 0.9.0+)

### Basic Usage

```vim
" Open test summary
<leader>ts

" Run test file
<leader>tt

" Run test at cursor
<leader>tr

" Toggle watch mode (auto-run on save)
<leader>tw
```

### Test Summary Panel Keymaps

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

### Monorepo Support

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

#### Solution: Scope to Working Directory

This configuration restricts test discovery to your **current working directory**.

#### Workflow

1. **Navigate to your subrepo:**
```vim
:cd monorepo/backend-a
```
Or use Neo-tree (`<leader>b`) and press `cd` on the directory.

2. **Reload Neotest (optional):**
```vim
<leader>tc
```
This confirms the current directory as the test root.

3. **Open test summary:**
```vim
<leader>ts
```
Now only tests in `monorepo/backend-a/` will be shown.

#### Performance Comparison

**Before (scanning entire monorepo):**
```vim
:pwd
"/home/user/monorepo"

<leader>ts
" Shows: neotest-python Δ 1843 ✓ 0 ✖ 0 ● 0 ○ 0
" Includes: backends, data, python, experimentals, etc.
" Problem: Too many tests, slow discovery!
```

**After (scoped to subrepo):**
```vim
:cd backends/chat-service
<leader>tc
" Output: Neotest reloaded. Root: /home/user/monorepo/backends/chat-service

<leader>ts
" Shows: neotest-mocha Δ 23 ✓ 0 ✖ 0 ● 0 ○ 0
" Includes: Only tests in chat-service/
" Success: Fast and focused!
```

#### How It Works

##### Discovery Settings
```lua
discovery = {
  enabled = true,
  concurrent = 1,  -- Limit concurrent discovery
}
```

##### Adapter Root Directory
Each test adapter (Jest, Vitest, Pytest, Go, Mocha) is configured to:
- Use `vim.fn.getcwd()` as root
- Filter out parent directories
- Exclude `node_modules`, `.git`, etc.

##### Filter Function
```lua
filter_dir = function(name, rel_path, root)
  -- Only include paths within current cwd
  local cwd = vim.fn.getcwd()
  local full_path = root .. "/" .. rel_path .. "/" .. name
  return vim.startswith(full_path, cwd)
end
```

#### Quick Directory Change

1. Open Neo-tree: `<leader>b`
2. Navigate to subrepo
3. Press `cd` in Neo-tree to change working directory
4. Close Neo-tree: `<leader>b`
5. Open test summary: `<leader>ts`

#### Check Current Working Directory
```vim
:pwd
```

#### Troubleshooting

**Still scanning parent directories?**
```vim
" 1. Restart Neovim
" 2. Navigate to your subrepo
:cd your/subrepo

" 3. Reload Neotest
<leader>tc

" 4. Close and reopen summary
<leader>ts
<leader>ts
```

**Which test framework is detected?**

Look at the top of the summary panel:
- `neotest-mocha` - Mocha tests
- `neotest-jest` - Jest tests
- `neotest-vitest` - Vitest tests
- `neotest-python` - Python tests
- `neotest-go` - Go tests

**Mocha Configuration:**

Neotest-mocha automatically detects:
- `.mocharc.json`, `.mocharc.yml`, `.mocharc.js`
- `mocha` section in `package.json`
- Command-line arguments via `command_args`

## Tree-sitter

Tree-sitter provides fast syntax highlighting and code understanding.

### Configured Parsers

Automatically installed on first launch:
- **Languages**: Lua, Vim, Bash, Python, JavaScript, TypeScript, TSX
- **Data**: JSON, JSONC, YAML, TOML, XML
- **Web**: HTML, CSS, GraphQL
- **Infrastructure**: Terraform, HCL, Dockerfile, SQL
- **Docs**: Markdown, Markdown inline

### Features

- **Syntax Highlighting**: Semantic, context-aware highlighting
- **Code Folding**: Fold by syntax tree (`zc`, `zo`, `za`)
- **Text Objects**: Navigate by functions, classes, etc.
- **Rainbow Delimiters**: Color-matched brackets/parentheses

### Commands

```vim
:TSInstallInfo          " Show installed parsers
:TSInstall <language>   " Install parser
:TSUpdate              " Update all parsers
:checkhealth nvim-treesitter  " Health check
```

## UI Features

### Statusline

Custom minimal statusline showing:
- Current mode (NORMAL, INSERT, VISUAL, etc.)
- File path (relative to cwd)
- File type
- Cursor position (line:column)
- Total lines

### Buffer Line

Top buffer tabs with:
- File icons
- Modified indicators
- Close buttons
- Tab navigation

### Indent Guides

Visual indent lines for better code readability.

### Color Scheme

Uses `default` colorscheme with:
- True color support (`termguicolors`)
- Cursor line highlighting
- Sign column for LSP diagnostics

## Editor Options

### Display
- Line numbers (`number`)
- Cursor line highlight (`cursorline`)
- Sign column always visible (`signcolumn=yes`)
- Scroll offset of 8 lines (`scrolloff=8`)

### Editing
- 2-space indentation (`shiftwidth=2`)
- Spaces instead of tabs (`expandtab`)
- Smart indentation (`smartindent`)
- System clipboard integration (`clipboard=unnamedplus`)

### Search
- Case-insensitive by default (`ignorecase`)
- Smart case (case-sensitive if uppercase present) (`smartcase`)
- No highlight on search (`hlsearch=false`)

### Performance
- No swap files (`swapfile=false`)
- Fast update time 100ms (`updatetime=100`)
- Lazy redraw for macros (`lazyredraw`)

### Folding
- Tree-sitter based folding (`foldmethod=expr`)
- All folds open by default (`foldlevel=99`)

## Workflow Examples

### New to Codebase
```vim
<leader>p          " Find file in git
gd                 " Go to definition
gr                 " See all usages
K                  " Read documentation
```

### Fix Errors
```vim
<leader>dx         " Open diagnostics
]d                 " Next error
<leader>ca         " Apply fix
<leader>fm         " Format
```

### Test Driven Development
```vim
:cd backend/service
<leader>tc         " Set test root
<leader>ts         " Open test summary
<leader>tw         " Watch mode ON
" Edit code, tests auto-run!
```

### Refactoring
```vim
<leader>rn         " Rename variable
<leader>ca         " Extract function
<leader>fm         " Format code
:w                 " Save
```

### Quick Fix Workflow
```vim
]d                 " Jump to diagnostic
gl                 " See error details
<leader>ca         " Apply fix
]d                 " Next error
```

### Bulk Refactoring
```vim
<leader>rn         " Rename symbol
newFunctionName<CR>
" All references updated across workspace!
```

## Tips

### Format on Save

Already configured - files automatically format on save if LSP supports it.

### Auto-change to Buffer Directory

Not recommended for monorepo. Instead, explicitly set working directory:
```vim
:cd path/to/project
```

### Disable Auto-formatting

To temporarily disable:
```vim
:lua vim.g.disable_autoformat = true
```

### Check LSP Status

```vim
:LspInfo              " Show attached language servers
:checkhealth lsp      " LSP health check
```

### Plugin Management

```vim
:Lazy                 " Open lazy.nvim UI
:Lazy sync           " Update all plugins
:Lazy clean          " Remove unused plugins
```

---

**Happy coding! 🚀**
