-- number of leds 

-- font size
font_x = 5
font_y = 7

nlines = 1
nbled_max = 300

disp_y = font_y * nlines
disp_x = math.floor(nbled_max / disp_y)

-- char_par_line = math.floor(disp_x / font_x)


-- disp_x = font_x * nchar_x
print("width  (leds):  ", disp_x )
print("height (leds):  ", disp_y )
print("number of leds: ", disp_x * disp_y)
print("number of lines:", nlines)
print("chars per line:", disp_x / font_x)


disp_x = disp_x - 1
disp_y = disp_y - 1
radius = 10
spacing_x = 40
spacing_y = 40
screenFactor = 0.5

padding = 20
ar = 1.0 * disp_x / disp_y

-- determine screen size
ret = love.window.setMode(0, 0)
sw = love.graphics.getWidth() * screenFactor
sh = love.graphics.getHeight() * screenFactor

-- compute the max size of the window
w = spacing_x * disp_x + 2 * padding
h = spacing_y * disp_y + 2 * padding

-- if it is too large, then scale proportionally
if ( w > sw or h > sh ) then
  rw = sw / w
  rh = sh / h
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

love.window.setMode(w, h, {fullscreen=false})

h=h-2*padding
w=w-2*padding

generation = 0

zmatrice = {}

function updateMatrix()
  for i = 0, disp_x, 1
  do
    zmatrice[i] = {}
    for j = 0, disp_y, 1
    do
      -- zmatrice[i][j] = (i + j) % 1
      zmatrice[i][j] = {}
      zmatrice[i][j][0] = i/disp_x
      zmatrice[i][j][1] = (generation % 255) / 255
      zmatrice[i][j][2] = j/disp_y
      generation = generation + 1
    end
  end
end

function love.draw()
  updateMatrix()
  for i = 0, disp_x, 1
  do
    for j = 0, disp_y, 1
    do
      love.graphics.setColor(zmatrice[i][j][0], zmatrice[i][j][1], zmatrice[i][j][2])
      love.graphics.circle("fill", padding + i * spacing_x, padding + j * spacing_y, radius )
    end
  end
  love.timer.sleep(1/10)
end