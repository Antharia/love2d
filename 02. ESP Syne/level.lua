level = {}

level.image = love.graphics.newImage("visual/level.png")
level.height = level.image:getHeight()
level.width = level.image:getWidth()
level.posX = 0

function loadLevel(pLevel)
  pLevel.posX = 0
  pLevel.posY = -pLevel.height * (width / level.width) + height
end


function drawLevel(pLevel)
  local sx = width / level.width
  local sy = sx
  love.graphics.draw(pLevel.image, pLevel.posX, pLevel.posY, 0, sx, sy)
end

function updateLevel(pLevel, deltaTime)
  if pLevel.posY >= 0 then
    pLevel.posY = 0
  else
    pLevel.posY = pLevel.posY + camera.speed * deltaTime
  end
end

