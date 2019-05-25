-- global variables (zmatrix, nx, ny are taken from main.lua)
effects={}


-- input parameters ---------------------------------------
local nbled_max = 800        -- max number of number of leds 
local font_x = 8            -- font size (pixel horizontal)
local font_y = 8            -- font size (pixel vertical)
local nlines = 2            -- number of lines (will  then use all leds that can fit)
local effect_duration = 10  -- change effect every given seconds
-- end of input parameters ---------------------------------

-- dofile("./utils.lua");

-- load the effects to use
-- TODO: load all files in effects directory
dofile("./effects/effect1.lua")
dofile("./effects/effect2.lua")
local neffects = table.getn(effects)


-- led matrix dimensions
ny = font_y * nlines
nx = math.floor(nbled_max / ny)
local max_chars_per_line = math.floor(nx / font_x)


-- report final dimensions
print("no. effects:", neffects)
print("width  (leds):  ", nx )
print("height (leds):  ", ny )
print("number of leds: ", nx * ny)
print("number of lines:", nlines)
print(string.format("chars per line: %d  +  %d extra led columns", max_chars_per_line, nx - max_chars_per_line * font_x))

local generation = 0
for i = 0, nx, 1 do
  zmatrix[i] = {}
  for j = 0, ny, 1 do
    zmatrix[i][j] = {}
    zmatrix[i][j].r = 0
    zmatrix[i][j].g = 0
    zmatrix[i][j].b = 0
  end
end

local t0=os.time()
local effect_index = 1
local effect = effects[effect_index]
effect.init(effect.params)

function update_ledbuffer()
  local t1 = os.time()
  if (os.difftime(t1, t0) > effect_duration) then
    generation = 0
    t0 = t1
    effect_index = 1 + effect_index % neffects
    print("Changing effect. No effect is no. ", effect_index);
    effect = effects[effect_index]
    effect.init(effect.params)
  else
    generation = generation + 1
    effect.update(generation, effect.params)
  end
  return effect.wait
end