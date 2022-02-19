# dailynotes.nvim

A Neovim plugin which allows the user to set keymaps to open daily notes. If the current day's notes don't exist, the file is written for first time.

As of February 2022, requires the Neovim nightly build.

Example configuration:

```lua
local dailyNotes = require("dailynotes")

dailyNotes.init(".norg")
dailyNotes.addDailyNoteShortcut("<leader>p", "/Users/andrewwillette/git/manual/general_notes/daily")
```
