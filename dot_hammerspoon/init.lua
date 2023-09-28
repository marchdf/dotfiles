-- Enable some PC-like commands, but disable in some apps
local hk_copy = hs.hotkey.bind({"ctrl"}, "c", nil, function() hs.eventtap.keyStroke({"cmd"}, "c") end)
local hk_cut = hs.hotkey.bind({"ctrl"}, "x", nil, function() hs.eventtap.keyStroke({"cmd"}, "x") end)
local hk_paste = hs.hotkey.bind({"ctrl"}, "v", nil, function() hs.eventtap.keyStroke({"cmd"}, "v") end)
local hk_save = hs.hotkey.bind({"ctrl"}, "s", nil, function() hs.eventtap.keyStroke({"cmd"}, "s") end)
local hk_undo = hs.hotkey.bind({"ctrl"}, "z", nil, function() hs.eventtap.keyStroke({"cmd"}, "z") end)
local hk_find = hs.hotkey.bind({"ctrl"}, "f", nil, function() hs.eventtap.keyStroke({"cmd"}, "f") end)
local hk_copy_uname = hs.hotkey.bind({"ctrl"}, "b", nil, function() hs.eventtap.keyStroke({"cmd"}, "b") end)

local function hk_enable()
  hk_copy:enable()
  hk_cut:enable()
  hk_paste:enable()
  hk_save:enable()
  hk_undo:enable()
  hk_find:enable()
end

local function hk_disable()
  hk_copy:disable()
  hk_cut:disable()
  hk_paste:disable()
  hk_save:disable()
  hk_undo:disable()
  hk_find:disable()
end

local wf=hs.window.filter
wf_terminal = wf.new{'Terminal', 'iTerm2', 'Emacs'}
wf_iterm2 = wf.new(false):setAppFilter('iTerm2',{allowTitles=1})
wf_keepass = wf.new(false):setAppFilter('KeePassXC',{allowTitles=1})

wf_terminal
    :subscribe(hs.window.filter.windowFocused, hk_disable)
    :subscribe(hs.window.filter.windowUnfocused, hk_enable)

wf_iterm2
    :subscribe(hs.window.filter.windowFocused, hk_disable)
    :subscribe(hs.window.filter.windowUnfocused, hk_enable)

wf_keepass
    :subscribe(hs.window.filter.windowFocused, function() hk_copy_uname:enable() end)
    :subscribe(hs.window.filter.windowUnfocused, function() hk_copy_uname:disable() end)

hk_enable()

-- Use side buttons on mouse to scroll
local back    = 3
local forward = 4
local pixels  = 30

local scrollDownTimer = hs.timer.new(1 / pixels, function()
  hs.eventtap.event.newScrollEvent({0, -1*pixels},{},'pixel'):post()
end)

local scrollUpTimer = hs.timer.new(1 / pixels, function()
  hs.eventtap.event.newScrollEvent({0, 1*pixels},{},'pixel'):post()
end)

local events = hs.eventtap.event.types
mouseTracker = hs.eventtap.new({ events.otherMouseDown, events.otherMouseUp }, function (e)
  local pressed = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])
  if pressed == back then
    if e:getType() == events.otherMouseUp then
      scrollDownTimer:stop()
    elseif e:getType() == events.otherMouseDown then
      scrollDownTimer:start()
      -- for the first scroll, don't wait until the timer expires
      local scroll = hs.eventtap.event.newScrollEvent({0, -1*pixels},{},'pixel')
    end
  elseif pressed == forward then
    if e:getType() == events.otherMouseUp then
      scrollUpTimer:stop()
    elseif e:getType() == events.otherMouseDown then
      scrollUpTimer:start()
      -- for the first scroll, don't wait until the timer expires
      local scroll = hs.eventtap.event.newScrollEvent({0, 1*pixels},{},'pixel')
    end
  else return false, {}
  end

  return true, { scroll }
end)
mouseTracker:start()