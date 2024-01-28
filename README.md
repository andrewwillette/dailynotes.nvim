# dailynotes.nvim

A neovim plugin which allows the user to set keymaps to open "daily notes".

Example configuration:

```lua
local dailyNotes = require("dailynotes")
dailyNotes.init(".md")
-- absolute path required
local homedir = os.getenv("HOME")
dailyNotes.addDailyNoteShortcut("<leader>pn", homedir .. "/personal_notes")

-- optionally, you can provide the absolute filepath to a "template file" to populate new daily files
dailyNotes.addDailyNoteShortcut("<leader>pn", homedir .. "/personal_notes", homedir .. "/personal_notes/dailytemplate.md")
```

## Installation

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):
```lua
...
    use 'andrewwillette/dailynotes.nvim'
...
```

As of February 2022, requires the Neovim nightly build.

