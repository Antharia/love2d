function collide(pSprite1, pSprite2)
  if pSprite1 == pSprite2 then return false end
  local distX = pSprite1.posX - pSprite2.posX
  local distY = pSprite1.posY - pSprite2.posY
  local boxAmount = 0.6 -- plus cette valeur est petite, plus la taille de la collision est petite
  if math.abs(distX) < (pSprite1.image:getWidth() + pSprite2.image:getWidth()) * boxAmount and
  math.abs(distY) < (pSprite1.image:getHeight() + pSprite1.image:getHeight()) * boxAmount then
    return true
  end
  return false
end