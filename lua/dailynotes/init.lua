local M = {}
M._filetype = nil

M.init = function(filetype)
  M._filetype = filetype
  return nil
end

M.addDailyNoteShortcut = function(keymap, directory, templateFileURI)
  local dailyFileString = directory .. "/" .. os.date("%Y-%m-%d") .. M._filetype
  local dailyFileExists = io.open(dailyFileString, "r")
  -- if already exists, then just add the keymapping and return
  if dailyFileExists ~= nil then
    vim.keymap.set(
      "n",
      keymap,
      function()
        vim.cmd("e " .. dailyFileString)
      end,
      {})
    return nil
  end

  -- read template file
  local templateFile, err = io.open(templateFileURI, "rb")
  if templateFile then
    local template_content = templateFile:read("*all")

    local dailyFile, err2 = io.open(dailyFileString, "wb")
    if dailyFile then
      dailyFile:write(template_content)
      dailyFile:close()
      vim.keymap.set(
        "n",
        keymap,
        function()
          vim.cmd("e " .. dailyFileString)
        end,
        {})
    else
      print("error opening dailyNotes new daily file: " .. err2)
      return nil, err2
    end
  else
    print("error opening dailyNotes template file: " .. err)
    return nil, err
  end
  return nil
end

return M
