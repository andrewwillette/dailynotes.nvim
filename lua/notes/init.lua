local M = {}

---@class DailyNoteConfig
---@field public directory string
---@field public filetype? string|nil
---@field public templatefile? string|nil

---@param dnc DailyNoteConfig
M.opendailynote = function(dnc)
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
  return nil
end

---@return string|nil date the date for the next occurrence of the provided weekday, or nil if an error occurs
---@return string|nil error message if the provided weekday is invalid, or nil otherwise
local nextdatefordayofweek = function(weekday)
  local today = os.date("*t")
  local day = 0
  weekday = weekday:sub(1, 1):upper() .. weekday:sub(2):lower()
  if weekday == "sunday" then
    day = 1
  elseif weekday == "Monday" then
    day = 2
  elseif weekday == "Tuesday" then
    day = 3
  elseif weekday == "Wednesday" then
    day = 4
  elseif weekday == "Thursday" then
    day = 5
  elseif weekday == "Friday" then
    day = 6
  elseif weekday == "Saturday" then
    day = 7
  else
    return nil, "invalid day of the week provided: " .. weekday
  end
  local daysuntilweekday = day - today.wday
  if daysuntilweekday < 0 then
    daysuntilweekday = daysuntilweekday + 7
  end
  local nextmeetingday = os.time { year = today.year, month = today.month, day = today.day + daysuntilweekday }
  ---@diagnostic disable-next-line: return-type-mismatch
  return os.date("%Y-%m-%d", nextmeetingday), nil
end

---@class WeeklyNoteConfig
---@field public meetingname string name of the weekly meeting, used in filename construction
---@field public directory string the location for the weekly meeting files to be stored
---@field public dayofweek string the day of the week the meeting is held, "Monday", "Tuesday", etc.
---@field public template? string|nil filepath to a "template" used for initializing new meeting notes
---@field public filetype? string|nil

---open a weekly note
---@param wnc WeeklyNoteConfig
---@return string|nil error message if an error occurs, or nil otherwise
M.openweeklynote = function(wnc)
  if wnc.filetype == nil then
    wnc.filetype = ".txt"
  end
  local nextmeetingdate, err = nextdatefordayofweek(wnc.dayofweek)
  if err ~= nil or nextmeetingdate == nil then
    vim.notify("error getting next meeting date: " .. err)
    return err
  end
  nextmeetingdate = nextmeetingdate:gsub("-", "_")
  local fullfilepath = wnc.directory .. "/" .. wnc.meetingname .. "_" .. nextmeetingdate .. wnc.filetype
  local fileexists = io.open(fullfilepath, "r")
  if fileexists ~= nil then
    vim.cmd("e " .. fullfilepath)
    return nil
  end
  local file, fileerr = io.open(fullfilepath, "wb")
  if file == nil or fileerr ~= nil then
    vim.notify("error opening weekly meeting notes new file: " .. fileerr)
    return fileerr
  end
  if wnc.template ~= nil then
    local templateFile, tmplErr = io.open(wnc.template, "rb")
    if templateFile == nil then
      vim.notify("error opening weekly meeting notes template file: " .. tmplErr)
      return tmplErr
    end
    local templatecontent = templateFile:read("*all")
    file:write(templatecontent)
  end
  file:close()
  vim.cmd("e " .. fullfilepath)
end

return M
