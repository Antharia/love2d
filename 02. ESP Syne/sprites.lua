listSprites = {}

function addSprite(pFileName, pX, pY)
  sprite = {}
  sprite.posX = pX
  sprite.posY = pY
  sprite.delete = false
  sprite.image = love.graphics.newImage("visual/"..pFileName..".png")
  sprite.width = sprite.image:getWidth()
  sprite.height = sprite.image:getHeight()
  sprite.frame = 1
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

function updateSprites()
  for i = #listSprites, 1, -1 do
    local sprite = listSprites[i]
    -- sprite animé
    if sprite.maxFrames > 1 then
      sprite.frame = sprite.frame + 0.2
      if math.floor(sprite.frame) > sprite.maxFrames then
        sprite.delete = true
      else
        sprite.image = sprite.listFrames[math.floor(sprite.frame)]
      end
    end
    if sprite.delete == true then
      table.remove(listSprites, i )
    end
  end  
end

