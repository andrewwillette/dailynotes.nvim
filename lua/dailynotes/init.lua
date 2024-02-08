local M = {}
M._filetype = nil

M.init = function(filetype)
  -- handle both '.txt' and 'txt' arguments
  filetype = string.gsub(filetype, "%.", "")
  filetype = "." .. filetype

  M._filetype = filetype
  return nil
end

-- keymap: required, the keymap to use for the shortcut
-- directory: required, the directory to store the daily notes in
-- templateFileURI: optional, the URI of the template file to use for the daily note
M.addDailyNoteShortcut = function(keymap, directory, templateFileURI)

  if M._filetype == nil then
    M._filetype = ".txt"
  end

  local dailyFileString = directory .. "/" .. os.date("%Y-%m-%d") .. M._filetype
  local setKeymap = function() vim.keymap.set(
      "n",
      keymap,
      function()
        local dailyFileStringKM = directory .. "/" .. os.date("%Y-%m-%d") .. M._filetype
        vim.cmd("e " .. dailyFileStringKM)
      end,
      {})
  end

  -- if the file already exists, then simply add the keymapping and returnng and return
  local dailyFileExists = io.open(dailyFileString, "r")
  if dailyFileExists ~= nil then
    setKeymap()
    return nil
  end

  local dailyFile, dlyFlErr = io.open(dailyFileString, "wb")
  if dailyFile == nil or dlyFlErr ~= nil then
    print("error opening dailyNotes new daily file: " .. dlyFlErr)
    return nil, dlyFlErr
  end

  -- handle template file
  if templateFileURI ~= nil then
    local templateFile, tmplErr = io.open(templateFileURI, "rb")
    if templateFile == nil then
      print("error opening dailyNotes template file: " .. tmplErr)
      return nil, tmplErr
    end
    local template_content = templateFile:read("*all")
    dailyFile:write(template_content)
  end

  dailyFile:close()
  setKeymap()
  return nil
end

return M
