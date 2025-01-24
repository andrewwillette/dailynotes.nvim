# notes.nvim

A neovim plugin for recurring note-taking!

Example configuration:

```lua
local dailynotes = require("dailynotes")

-- absolute path required
local homedir = os.getenv("HOME")

vim.keymap.set("n", "<leader>dn", function()
    dailynotes.opendailynote({
      keymap = "<leader>pn", 
      directory = homedir .. "/personal_notes"
      filetype = ".md",
    })
  end,
{ noremap = true })

-- optionally, you can provide the absolute filepath to a "template file" to populate new daily files
vim.keymap.set("n", "<leader>dn", function()
    dailynotes.opendailynote({
      keymap = "<leader>pn", 
      directory = homedir .. "/personal_notes"
      filetype = ".md",
      templateFile = homedir .. "/personal_notes_template/dailytemplate.md",
    })
  end,
{ noremap = true })
```
