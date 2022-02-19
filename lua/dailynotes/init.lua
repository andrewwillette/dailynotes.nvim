local M = {}
M._filetype = nil
M.init = function(filetype)
    M._filetype = filetype
    return nil
end
M.addDailyNoteShortcut = function(keymap, directory)
    vim.keymap.set(
    "n",
        keymap,
        function()
            vim.cmd("e "..directory .. "/" .. os.date("%Y-%m-%d") .. M._filetype)
        end,
        {})
    return nil
end
return M
