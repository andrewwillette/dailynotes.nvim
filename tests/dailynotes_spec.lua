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

  it("baseline test", function()
    local configureddir = "~/tmp/notes"
    local configuredfiletype = ".txt"
    local dailynotes = require("dailynotes")
    local hm = os.getenv("HOME")

    dailynotes.opendailynote({
      directory = configureddir,
      filetype = configuredfiletype,
      templateFile = hm .. "/tmp/dailyCapitalOneNotesTemplate.md",
    })
  end)
end)
