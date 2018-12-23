io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end

ship = {}
-- Liste d'éléments
listSprites = {}
listShoots = {}
listEnemies = {}

sfxShoot = love.audio.newSource("sounds/shoot.wav", "static")

function addEnemy(pType, pX ,pY)
  
  local filename = ""
  
  if pType == 1 then
    filename = "enemy1.png"
  elseif pType == 2 then
    filename = "enemy2.png"
  end
    
  local enemy = addSprite(filename, pX, pY)
  
  table.insert(listEnemies, enemy)
end


function addSprite(pFileName, pX, pY)
  sprite = {}
  sprite.posX = pX
  sprite.posY = pY
  sprite.delete = false
  sprite.image = love.graphics.newImage("images/"..pFileName..".png")
  sprite.width = sprite.image:getWidth()
  sprite.height = sprite.image:getHeight()

  table.insert(listSprites, sprite)

  return sprite
end

----------
-- LOAD --
----------

function love.load()
  love.window.setMode(1024, 768)
  love.window.setTitle("Shoot'em Up")

  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  ship = addSprite("ship", width / 2, height / 2)
  ship.posY = love.graphics.getHeight() - (ship.height * 2)
  ship.speed = 300
end

------------
-- UPDATE --
------------

function love.update(dt)

-- gestion des tirs
  local i
  for i = #listShoots, 1, -1 do
    local shoot = listShoots[i]
    shoot.posY = shoot.posY + shoot.velY * dt
-- -- supprimer les shoots hors de l'écran
    if shoot.posY < 0 or shoot.posY > height then
      shoot.delete = true
      table.remove(listShoots, i)
    end
  end

-- suppression des sprites
  for i = #listSprites, 1, -1 do
    if listSprites[i].delete == true then
      table.remove(listSprites, i )
    end
  end

-- gestion du clavier
  if love.keyboard.isDown("up") and ship.posY > 0 then
    ship.posY = ship.posY - ship.speed * dt
  elseif love.keyboard.isDown("right") and ship.posY < width then
    ship.posX = ship.posX + ship.speed * dt
  elseif love.keyboard.isDown("down") and ship.posY < height then
    ship.posY = ship.posY + ship.speed * dt
  elseif love.keyboard.isDown("left") and ship.posX > 0 then
    ship.posX = ship.posX - ship.speed * dt
  end

end

----------
-- DRAW --
----------

function love.draw()

  local i
  for i = 1, #listSprites do
    local s = listSprites[i]
    love.graphics.draw(s.image, s.posX, s.posY, 0, 2, 2, s.width / 2, s.height / 2)
  end

  love.graphics.print("Nombre de tirs : "..#listShoots.." Nombre de sprites : "..#listSprites, 0, 0)
end

function love.keypressed(key)
  if key == "space" then
    local shoot = addSprite("shoot", ship.posX, ship.posY - (ship.height * 2) / 2)
    shoot.velY = -500
    table.insert(listShoots, shoot)
    love.audio.play(sfxShoot)
  end

end