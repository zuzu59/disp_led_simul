-- global variables
nx=0
ny=0
zmatrix={}

dofile("./effects.lua")

-- input parameters ---------------------------------------
local radius = 10           -- led circle radius
local spacing_x = 40        -- spacing between center of leds (horizontal)
local spacing_y = 40        -- spacing between center of leds (vertical)
local padding = 20          -- space for the windows border
local screenFactor = 0.5    -- fraction of the screen to use
-- end of input parameters ---------------------------------

-- determine screen size
love.window.setMode(0, 0)
local sw = love.graphics.getWidth() * screenFactor
local sh = love.graphics.getHeight() * screenFactor

-- compute the max size of the window
local w = spacing_x * nx + 2 * padding
local h = spacing_y * ny + 2 * padding

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

-- set windows size to fit the led matrix
love.window.setMode(w, h, {fullscreen=false})

function love.draw()
  for i = 0, nx, 1
  do
    for j = 0, ny, 1
    do
      love.graphics.setColor(zmatrix[i][j].r, zmatrix[i][j].g, zmatrix[i][j].b)
      love.graphics.circle("fill", padding + i * spacing_x, padding + j * spacing_y, radius )
    end
  end
  wait=update_ledbuffer()
  love.timer.sleep(wait)
end