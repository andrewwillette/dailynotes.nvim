local find_map = function(lhs)
  local maps = vim.api.nvim_get_keymap('n')

  for _, map in ipairs(maps) do
    if map.lhs == lhs then
      return map
    end
  end
end

describe("dailynotes", function()
  it("can be required", function()
    require("dailynotes")
  end)

  it("sets the configured keymap correctly", function()
    local configuredKeyMap = ",t"
    local configuredDirectory = "~/tmp/notes"
    local configuredFileType = ".txt"
    local dailynotes = require("dailynotes")
    local hm = os.getenv("HOME")

    dailynotes.addDailyNoteShortcut({
      keymap = configuredKeyMap,
      directory = configuredDirectory,
      filetype = configuredFileType,
      templateFile = home .. "/tmp/dailyCapitalOneNotesTemplate.md",
    })
    local found = find_map(configuredKeyMap)

    assert.equals(found.lhs, configuredKeyMap)
    assert.truthy(found.lhs ~= nil)
  end)
end)
