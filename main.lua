-- global variables
zmatrix={}
effects={}

-- load the effects to use
dofile("./effects/effect1.lua")
dofile("./effects/effect2.lua")
local neffects = table.getn(effects)

-- dofile("bigmatrixfont.lua")

-- input parameters ---------------------------------------
local radius = 10           -- led circle radius
local spacing_x = 40        -- spacing between center of leds (horizontal)
local spacing_y = 40        -- spacing between center of leds (vertical)
local padding = 20          -- space for the windows border
local screenFactor = 0.5    -- fraction of the screen to use
local nbled_max = 800        -- max number of number of leds 
local font_x = 8            -- font size (pixel horizontal)
local font_y = 8            -- font size (pixel vertical)
local nlines = 2            -- number of lines (will  then use all leds that can fit)
local effect_duration = 10  -- change effect every given seconds
-- end of input parameters ---------------------------------


-- led matrix dimensions
local disp_y = font_y * nlines
local disp_x = math.floor(nbled_max / disp_y)
local max_chars_per_line = math.floor(disp_x / font_x)

disp_x = disp_x - 1
disp_y = disp_y - 1

-- determine screen size
love.window.setMode(0, 0)
local sw = love.graphics.getWidth() * screenFactor
local sh = love.graphics.getHeight() * screenFactor

-- compute the max size of the window
local w = spacing_x * disp_x + 2 * padding
local h = spacing_y * disp_y + 2 * padding

-- if it is too large, then scale proportionally
if ( w > sw or h > sh ) then
  local rw = sw / w
  local rh = sh / h
  print("rw = ", rw)
  print("rh = ", rh)
  rf = math.min(rw, rh)
  padding = padding * rf
  w = w * rf
  h = h * rf
  radius = radius * rf
  spacing_x = spacing_x * rf
  spacing_y = spacing_y * rf
end

-- report final dimensions
print("no. effects:", neffects)
print("led radius:", radius)
print("width  (leds):  ", disp_x )
print("height (leds):  ", disp_y )
print("number of leds: ", disp_x * disp_y)
print("number of lines:", nlines)
print(string.format("chars per line: %d  +  %d extra led columns", max_chars_per_line, disp_x - max_chars_per_line * font_x))

-- set windows size to fit the led matrix
love.window.setMode(w, h, {fullscreen=false})


local generation = 0
for i = 0, disp_x, 1 do
  zmatrix[i] = {}
  for j = 0, disp_y, 1 do
    zmatrix[i][j] = {}
    zmatrix[i][j].r = 0
    zmatrix[i][j].g = 0
    zmatrix[i][j].b = 0
  end
end

local t0=os.time()
local effect_index = 1

local effect = effects[effect_index]
effect.init(disp_x, disp_y, effect.params)

function love.draw()
  for i = 0, disp_x, 1
  do
    for j = 0, disp_y, 1
    do
      love.graphics.setColor(zmatrix[i][j].r, zmatrix[i][j].g, zmatrix[i][j].b)
      love.graphics.circle("fill", padding + i * spacing_x, padding + j * spacing_y, radius )
    end
  end

  love.timer.sleep(effect.wait)

  local t1 = os.time()
  if (os.difftime(t1, t0) > effect_duration) then
    generation = 0
    t0 = t1
    effect_index = 1 + effect_index % neffects
    print("Changing effect. No effect is no. ", effect_index);
    effect = effects[effect_index]
  else
    generation = generation + 1
    effect.update(disp_x, disp_y, generation, effect.params)
  end
end