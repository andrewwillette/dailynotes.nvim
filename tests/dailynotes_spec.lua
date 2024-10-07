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
    local configuredkeymap = ",t"
    local configureddir = "~/tmp/notes"
    local configuredfiletype = ".txt"
    local dailynotes = require("dailynotes")
    local hm = os.getenv("HOME")

    dailynotes.addDailyNoteShortcut({
      keymap = configuredkeymap,
      directory = configureddir,
      filetype = configuredfiletype,
      templateFile = hm .. "/tmp/dailyCapitalOneNotesTemplate.md",
    })
    local found = find_map(configuredkeymap)

    assert.equals(found.lhs, configuredkeymap)
    assert.truthy(found.lhs ~= nil)
  end)
end)
