# disp_led_simul
Petite simulation d'un panneau d'affichage à LED RGB en LUA script

## Buts
Si on veut se fabriquer un *grand* panneau d'affichage avec des LED RGB, vient tout de suite le problème de combien de LED RGB va-t-on mettre en X et en Y afin de pouvoir avoir l'affichage compter.

Ce petit simulateur de panneau de LED RGB écrit en LUA va nous permettre de voir le résultat avant de commencer à souder :-)

Il a été écrit en LUA car le micro contrôleur utilisé pour ce projet sera un NodeMCU LUA !



## Installation
```
sudo add-apt-repository ppa:bartbes/love-stable
sudo apt update
sudo apt install lua love
```


## Utilisation
```
cd project folder
love .
```



## Sources
http://lua-users.org/wiki/LuaGraphics<br>
https://love2d.org/<br>
https://love2d.org/wiki/love.graphics<br>
