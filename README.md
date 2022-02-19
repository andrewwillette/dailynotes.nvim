# dailynotes.nvim

A neovim plugin which allows the user to set keymaps to open daily notes. If the current day's notes don't exist, the file is written for the first time.

Example configuration:

```lua
local dailyNotes = require("dailynotes")

dailyNotes.init(".norg")
dailyNotes.addDailyNoteShortcut("<leader>p", "/Users/andrewwillette/git/manual/general_notes/daily")
```

## Installation

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):
```lua
...
    use 'andrewwillette/dailynotes.nvim'
...
```

As of February 2022, requires the Neovim nightly build.

