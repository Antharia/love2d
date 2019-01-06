io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end

windowWidth = 1024
windowHeight = 768

require("sfx")
require("sprites")
require("ship")

require("level")
require("camera")
require("enemies")
require("collision")

function love.load()
  love.window.setMode(windowWidth, windowHeight)
  love.window.setTitle("Press Space")

  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  loadLevel(level)
  loadEnemies()
  -- bgm:play()
end

function love.update(dt)
  updateShip(dt)
  updateSprites()
  updateLevel(level, dt)
  updateEnemies(dt)
end

function love.draw()
  drawLevel(level)
  drawSprites()
end

function love.keypressed(key)
  if key == "space" then
    addLaser("laser", ship.posX, ship.posY - ship.height, 0, -500)
    local sfx = sfxLaser:clone()
    love.audio.play(sfx)
  end
end

