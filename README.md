# dailynotes.nvim

A neovim plugin which allows the user to set keymaps to open "daily notes".

Example configuration:

```lua
local dailynotes = require("dailynotes")

-- absolute path required
local homedir = os.getenv("HOME")

dailynotes.addDailyNoteShortcut({
  keymap = "<leader>pn", 
  directory = homedir .. "/personal_notes"
  filetype = ".md",
})

-- optionally, you can provide the absolute filepath to a "template file" to populate new daily files
dailynotes.addDailyNoteShortcut({
  keymap = "<leader>pn", 
  directory = homedir .. "/personal_notes"
  filetype = ".md",
  templateFile = homedir .. "/personal_notes_template/dailytemplate.md",
})
```

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):
```lua
...
  "andrewwillette/dailynotes.nvim",
...
```
