local M = {}

---@class DailyNoteConfig
---@field keymap string
---@field directory string
---@field filetype? string
---@field templateFile? string

---@param dnc DailyNoteConfig
M.addDailyNoteShortcut = function(dnc)
  vim.keymap.set(
    "n",
    dnc.keymap,
    function()
      if dnc.filetype == nil then
        dnc.filetype = ".txt"
      end
      local dailyFileString = dnc.directory .. "/" .. os.date("%Y-%m-%d") .. dnc.filetype

      local dailyFileExists = io.open(dailyFileString, "r")
      if dailyFileExists ~= nil then
        vim.cmd("e " .. dailyFileString)
        return nil
      end

      local dailyFile, dlyFlErr = io.open(dailyFileString, "wb")
      if dailyFile == nil or dlyFlErr ~= nil then
        print("error opening dailyNotes new daily file: " .. dlyFlErr)
        return nil, dlyFlErr
      end

      -- handle template file
      if dnc.templateFile ~= nil then
        local templateFile, tmplErr = io.open(dnc.templateFile, "rb")
        if templateFile == nil then
          vim.print("error opening dailyNotes template file: " .. tmplErr)
          return nil, tmplErr
        end
        local template_content = templateFile:read("*all")
        dailyFile:write(template_content)
      end

      dailyFile:close()

      vim.cmd("e " .. dailyFileString)
    end,
    {})
  return nil
end

return M
