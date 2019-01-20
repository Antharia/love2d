listSprites = {}

function addSprite(pFilename, pX, pY)
  sprite = {}
  sprite.delete = false
  sprite.posX = pX
  sprite.posY = pY
  sprite.image = love.graphics.newImages("img/"..pFilename..".png)
  sprite.width = sprite.image:getWidth()
  sprite.height = sprite.image:getHeight()
  sprite.frame =  1
  sprite.listFrames = {}
  sprite.maxFrames = 1
  table.insert(listSprites, sprite)
  return sprite
end

function drawSprites()
  local i
  for i = 1, #listSprites do
    local s = listSprites[i]
    love.graphics.draw(s.image, s.posX, s.posY, 0, 2, 2, s.width / 2, s.height / 2)
  end
end

function updateSprites(deltaTime)
  local i
  for i = #listSprites, 1, -1 do
    local s = listSprites[i]
    if s.maxFrames > 1 then
      s.frame = s.frame + 30 * deltaTime
      if math.floor(s.frame) > s.maxFrames then
        s.delete = true
      else
        s.image = s.listFrames[math.floor(s.frame)]
      end
    end
    if s.delete == true then
      table.remove(listSprites, i)
    end
  end
end

