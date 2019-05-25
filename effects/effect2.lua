local effect = {}
effect.name = "Random colors"
effect.wait = 1/60
effect.params = {
  p=0.1   -- a pixel changes color with this probability
}
effect.update = function(gen, params)
  for i = 0, nx, 1
  do
    for j = 0, ny, 1
    do
      if (math.random() < params.p) then
        zmatrix[i][j].r = math.random()
        zmatrix[i][j].g = math.random()
        zmatrix[i][j].b = math.random()
      end
    end
  end
end
effect.init = function(params)
  effect.update(0, {p=1})
end

table.insert(effects, effect)
