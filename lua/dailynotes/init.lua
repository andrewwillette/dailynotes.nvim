local M = {}

---@class DailyNoteConfig
---@field keymap string
---@field directory string
---@field filetype? string
---@field templatefile? string

---@param dnc DailyNoteConfig
M.addDailyNoteShortcut = function(dnc)
  vim.keymap.set(
    "n",
    dnc.keymap,
    function()
      if dnc.filetype == nil then
        dnc.filetype = ".txt"
      end
      local dailyfileabsolute = dnc.directory .. "/" .. os.date("%Y-%m-%d") .. dnc.filetype

      local dailyfileexists = io.open(dailyfileabsolute, "r")
      if dailyfileexists ~= nil then
        vim.cmd("e " .. dailyfileabsolute)
        return nil
      end

      local dailyfile, dailyfileerr = io.open(dailyfileabsolute, "wb")
      if dailyfile == nil or dailyfileerr ~= nil then
        print("error opening dailyNotes new daily file: " .. dailyfileerr)
        return nil, dailyfileerr
      end

      -- handle template file
      if dnc.templatefile ~= nil then
        local templateFile, tmplErr = io.open(dnc.templatefile, "rb")
        if templateFile == nil then
          vim.print("error opening dailyNotes template file: " .. tmplErr)
          return nil, tmplErr
        end
        local templatecontent = templateFile:read("*all")
        dailyfile:write(templatecontent)
      end

      dailyfile:close()

      vim.cmd("e " .. dailyfileabsolute)
    end,
    {})
  return nil
end

return M
