listEnemies = {}
local time

function addEnemy(pFilename, pPosX, pPosY)
  enemy = addSprite(pFilename, pPosX, pPosY)
  enemy.type = pFilename
  enemy.posX = pPosX
  enemy.posY = pPosY
  enemy.velX = nil
  enemy.velY = nil
  enemy.hp = nil

  if enemy.type == "enemy1" then
    enemy.velX = math.random(-30, 30)
    enemy.velY = math.random(120, 170)
    enemy.hp = 2
  end
  if enemy.type == "enemy2" then
    enemy.velX = 0
    enemy.velY = math.random(100, 200)
    enemy.hp = 3
    enemy.amplitude = math.random(50, 200)
  end

  table.insert(listEnemies, enemy)
end

function loadEnemies()
  time = 0
  addEnemy("enemy1", 100, -100)
  addEnemy("enemy1", 200, -200)
  addEnemy("enemy1", 300, -300)

  addEnemy("enemy1", 500, -300)
  addEnemy("enemy1", 650, -350)
  addEnemy("enemy1", 800, -400)


  addEnemy("enemy2", 100, -600)
  addEnemy("enemy2", 300, -700)
  addEnemy("enemy2", 500, -800)
  addEnemy("enemy2", 700, -900)

  addEnemy("enemy1", 500, -900)
  addEnemy("enemy1", 550, -1000)
  addEnemy("enemy1", 600, -1100)
  addEnemy("enemy1", 650, -1200)

  addEnemy("enemy2", 100, -1200)
  addEnemy("enemy2", 350, -1400)
  addEnemy("enemy2", 600, -1600)
  addEnemy("enemy2", 850, -1800)

  addEnemy("enemy1", 100, -1800)
  addEnemy("enemy1", 500, -1900)
  addEnemy("enemy1", 900, -2000)

end

function updateEnemies(deltaTime)
  time = time + deltaTime
  local i
  for i in ipairs(listEnemies) do
    local enemy = listEnemies[i]
    if enemy.type == "enemy2" then
      enemy.velX = enemy.amplitude * math.sin(time)
    end
    enemy.posX = enemy.posX + enemy.velX * deltaTime
    enemy.posY = enemy.posY + enemy.velY * deltaTime
  end
end
