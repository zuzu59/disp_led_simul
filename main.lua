h=love.graphics.getHeight()
w=love.graphics.getWidth()
print(h,w)
padding = 20
h=h-2*padding
w=w-2*padding
disp_x = 50
disp_y = 15
spacing_x = w/disp_x
spacing_y = h/disp_y
radius = math.min(spacing_x, spacing_y)/2.1

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
      zmatrice[i][j][1] = (generation % 100) / 100
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
  love.timer.sleep(1/24)
end