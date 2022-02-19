local M = {}
local filetypec = nil
M.init = function(filetype)
    filetypec = filetype
    return nil
end
M.addDailyNoteShortcut = function(keymap, directory)
    vim.keymap.set(
    "n",
        keymap,
        function()
            --print(os.date("%x"))
            vim.cmd("e "..directory .. "/" .. os.date("%Y-%m-%d") .. filetypec)

        end,
        {})
    return nil
end
return M
