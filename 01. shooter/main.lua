io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end

function math.angle(x1, y1, x2, y2) return math.atan2(y2 - y1, x2 - x1) end

ship = {}
-- Liste d'éléments
listSprites = {}
listShoots = {}
listEnemies = {}

level = {}
table.insert(level, {0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(level, {0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0})
table.insert(level, {0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0})
table.insert(level, {0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(level, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(level, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(level, {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0})
table.insert(level, {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0})
table.insert(level, {0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0})
table.insert(level, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(level, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(level, {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(level, {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(level, {1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1})
table.insert(level, {2, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1})
table.insert(level, {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1})
table.insert(level, {1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2})
table.insert(level, {2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(level, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(level, {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0})
table.insert(level, {0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0})
table.insert(level, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(level, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(level, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(level, {0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0})
table.insert(level, {0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 2, 2, 0, 0})
table.insert(level, {0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0})

camera = {}
camera.posY = 0
camera.speed = 50

-- chargement des tiles de décor
imgTiles = {}
local i
for i = 1, 2 do
  imgTiles[i] = love.graphics.newImage("images/tile"..i..".png")
end

-- son du tir
sfxShoot = love.audio.newSource("sounds/shoot.wav", "static")

-- ENNEMIS

function addEnemy(pType, pX ,pY)
  local filename = ""

  -- charger le sprite correspondant au type d'ennemi que l'on souhaite
  if pType == 1 then
    filename = "enemy1"
  elseif pType == 2 then
    filename = "enemy2"
  elseif pType == 3 then
    filename = "enemy3"
  end

  local enemy = addSprite(filename, pX, pY)

  enemy.sleep = true
  enemy.time = 0
  enemy.type = pType

  if pType == 1 then
    enemy.velY = 200
    enemy.velX = 0
  elseif pType == 2 then
    local direction = math.random(1, 2)
    if direction == 1 then enemy.velX = 100 end
    if direction == 2 then enemy.velX = -100 end
    enemy.velY = 200
  elseif pType == 3 then
    enemy.velX = 0
    enemy.velY = camera.speed 
  end

  table.insert(listEnemies, enemy)
end

-- SPRITES

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

-- SHOOTS

function addShoot(pType, pFilename, pX, pY, pSpeedX, pSpeedY)
  local shoot = addSprite(pFilename, pX, pY)
  shoot.type = pType
  shoot.velX = pSpeedX
  shoot.velY = pSpeedY
  table.insert(listShoots, shoot)
  love.audio.play(sfxShoot)
end

----------
-- LOAD --
----------

function love.load()
  love.window.setMode(1024, 768)
  love.window.setTitle("Shoot'em Up")

  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  startGame()
end

function startGame()
  ship = addSprite("ship", width / 2, height / 2)
  ship.posY = love.graphics.getHeight() - (ship.height * 2)
  ship.posX = width / 2
  ship.speed = 300

  local row, col 
  col = 3
  row = 6
  addEnemy(1, col * 64, -(row * 64) - 32)
  col = 9
  row = 10
  addEnemy(2, col * 64, -(row * 64) - 32)
  col = 13
  row = 11
  addEnemy(3, col * 64, -(row * 64) - 32)

  camera.posY = 0
end

------------
-- UPDATE --
------------

function love.update(dt)

-- gestion de la caméra
  camera.posY = camera.posY + camera.speed * dt

-- gestion des tirs
  local i
  for i = #listShoots, 1, -1 do
    local shoot = listShoots[i]

--  -- déplacement des tirs
    shoot.posX = shoot.posX + shoot.velX * dt
    shoot.posY = shoot.posY + shoot.velY * dt

    if shoot.type = "enemy" then
      if collide(ship, shoot) then
        shoot.delete
        table.remove(listShoots, i)
      end
    end

-- -- supprimer les shoots hors de l'écran
    if shoot.posY < 0 or shoot.posY > height or shoot.posX < 0 or shoot.posY > width then
      shoot.delete = true
      table.remove(listShoots, i)
    end
  end

  -- gestion des ennemis
  for i=#listEnemies, 1, -1 do
    local enemy = listEnemies[i]

    -- activer l'ennemi s'il apparaît à lécran
    if enemy.posY > 0 then enemy.sleep = false end

    -- si l'ennemi apparaît à l'écran
    if enemy.sleep == false then
      enemy.posX = enemy.posX + enemy.velX * dt
      enemy.posY = enemy.posY + enemy.velY * dt
      enemy.time = enemy.time + 1

      if enemy.type == 1 or enemy.type == 2 then
        if enemy.time >= 40 then
          local velX, velY
          velX = 0
          velY = 400
          enemy.time = 0
          addShoot("enemy", "shoot2", enemy.posX, enemy.posY, velX, velY)
        end

      end

      if enemy.type == 3 then
        if enemy.time >= 30 then
          enemy.time = 0
          local velX, velY
          local angle
          angle = math.angle(enemy.posX, enemy.posY, ship.posX, ship.posY)
          velX = 300 * math.cos(angle)
          velY = 300 * math.sin(angle)
          addShoot("enemy", "shoot2", enemy.posX, enemy.posY, velX, velY)
        end
      end

    else
      enemy.posY = enemy.posY + camera.speed *dt
    end

    if enemy.posY > height then 
      enemy.delete = true 
      table.remove(listEnemies, i)
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

  -- affichage du niveau
  local nbRows = #level
  local row, col
  local x, y
  x = 0
  y = 0 + camera.posY
  for row = nbRows, 1, -1 do
    for col = 1, 16 do
      if level[row][col] > 0 then
        love.graphics.draw(imgTiles[level[row][col]], x, y, 0, 2, 2)
      end
      x = x + 64
    end
    x = 0
    y = y - 64
  end

  -- affichage des sprites
  local i
  for i = 1, #listSprites do
    local s = listSprites[i]
    love.graphics.draw(s.image, s.posX, s.posY, 0, 2, 2, s.width / 2, s.height / 2)
  end

  love.graphics.print("Nombre de tirs : "..#listShoots.." Nombre de sprites : "..#listSprites.." Nombre d'ennemis : "..#listEnemies, 0, 0)
end

function love.keypressed(key)
  if key == "space" then
    addShoot("ship", "shoot", ship.posX, ship.posY - ship.height, 0, -500)
  end
end


-- COLLISION

function collide(pSprite1, pSprite2)
  if pSprite1 == pSprite2 then return false end
  local distX = pSprite1.posX - pSprite2.posX
  local distY = pSprite1.posY - pSprite2.posY
  if math.abs(distX) < 
end
