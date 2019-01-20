io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end

windowWidth = 1024
windowHeight = 768

require("sfx")
require("sprites")
require("collision")

function love.load()
  love.window.setMode(windowWidth, windowHeight)
  love.window.setTitle("GAME TITLE")

  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
end

function love.update(dt)
  updateSprites(dt)
end

function love.draw()
  drawSprites()
end

function love.keypressed(key)
  if key == "space" then
    print("Spacebar pressed")
  end
end


