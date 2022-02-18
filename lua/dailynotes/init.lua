local M = {}
local filetypec = nil
M.init = function(filetype)
    filetypec = filetype
end
M.addDailyNoteShortcut = function(keymap,directory)
    print(filetypec)
    print(keymap)
    print(directory)
end
M.example = function()
    print("swagffff")
end
return M
