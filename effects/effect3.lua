local effect = {}
effect.name = "Color waves"
effect.wait = 1/20
effect.params = {
  text="Ciao",        -- text to write
  fg={r=1, g=1, b=0}, -- text color color
  bg={r=0, g=0, b=0}, -- background color
}
effect.update = function(gen, params)
  for j = 0, ny, 1
  do
    t = zmatrix[0][j]
    for i = 0, nx-1, 1
    do
      zmatrix[i][j] = zmatrix[i+1][j]
    end
    zmatrix[nx-1][j] = t
  end
end
effect.init = function(params) 
  for i = 0, nx, 1 do
    for j = 0, ny, 1 do
      zmatrix[i][j]=params.bg
      -- zmatrix[2][2]={r=1, g=1, b=1}
      plotstring8x8(params.text,1,1,params.fg,params.bg)
    end
  end
end

table.insert(effects, effect)
