# dailynotes.nvim

A neovim plugin which allows the user to set keymaps to open "daily notes".

Example configuration:

```lua
local dailyNotes = require("dailynotes")

-- absolute path required
local homedir = os.getenv("HOME")

dailyNotes.addDailyNoteShortcut({
  keymap = "<leader>pn", 
  directory = homedir .. "/personal_notes"
  filetype = ".md",
})

-- optionally, you can provide the absolute filepath to a "template file" to populate new daily files
dailyNotes.addDailyNoteShortcut({
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
