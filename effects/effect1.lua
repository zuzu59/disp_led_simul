local effect = {}
effect.name = "Color waves"
effect.wait = 1/60
effect.params = {
  f1=200, -- period for red
  f2=100, -- period for green
  f3=400  -- period for blue
}
effect.update = function(nx, ny, gen, params)
  for i = 0, nx, 1
  do
    for j = 0, ny, 1
    do
      zmatrix[i][j].r = math.sin(gen / params.f1 + i/nx)
      zmatrix[i][j].g = math.sin(gen / params.f2)
      zmatrix[i][j].b = math.sin(gen / params.f3 + j/ny)
    end
  end
end
effect.init = function(nx, ny, params) 
  effect.update(nx, ny, 0, params)
end

table.insert(effects, effect)
