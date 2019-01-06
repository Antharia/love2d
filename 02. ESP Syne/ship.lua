ship = addSprite("ship", love.graphics.getWidth() / 2, love.graphics.getHeight() - 50)
ship.speed = 400
listLasers = {}

function updateShip(deltaTime)
  shootLaser(deltaTime)
  moveShip(deltaTime)
end

function addLaser(pFilename, pPosX, pPosY, pVelX, pVelY)
  local laser = addSprite(pFilename, pPosX, pPosY)
  laser.type = pFilename
  laser.velX = pVelX
  laser.velY = pVelY
  laser.delete = false
  table.insert(listLasers, laser)
end

-- déplacement
function moveShip(deltaTime)
  if love.keyboard.isDown("up") and ship.posY - ship.height > 0 then
    ship.posY = ship.posY - ship.speed * deltaTime
  elseif love.keyboard.isDown("right") and ship.posX + ship.width < width then
    ship.posX = ship.posX + ship.speed * deltaTime
  elseif love.keyboard.isDown("down") and ship.posY  + ship.height < height then
    ship.posY = ship.posY + ship.speed * deltaTime
  elseif love.keyboard.isDown("left") and ship.posX - ship.width > 0 then
    ship.posX = ship.posX - ship.speed * deltaTime
  end  
end

-- tir
function shootLaser(deltaTime)
  local iLaser
  -- tous les lasers
  for iLaser = #listLasers, 1, -1 do
    -- tirs des lasers
    local laser = listLasers[iLaser]
    laser.posX = laser.posX + laser.velX * deltaTime
    laser.posY = laser.posY + laser.velY * deltaTime
    if (laser.posY < 0 or laser.posY > height or laser.posX < 0 or laser.posY > width) and laser.delete == false then
      laser.delete = true
      table.remove(listLasers, iLaser)
    end
    -- collision des lasers avec un ennemi
    for iEnemy = #listEnemies, 1, -1 do
      local enemy = listEnemies[iEnemy]
      if collide(laser, enemy) then
        local lSfxHit = sfxHit:clone()
        love.audio.play(lSfxHit)
        laser.delete = true
        table.remove(listLasers, iLaser)
        enemy.hp = enemy.hp - 1
        if enemy.hp <= 0 then
          local lSfxExplosion = sfxExplosion:clone()
          love.audio.play(lSfxExplosion)
          enemy.delete = true
          table.remove(listEnemies, iEnemy)
        end
      end 
    end
  end  
end


