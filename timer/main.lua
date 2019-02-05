love.graphics.setDefaultFilter("nearest")

function love.load()
  love.window.setMode(330, 200,
    {borderless = false,
      resizable = true,
      minwidth = 200,
      minheight = 100})
  start = math.floor(love.timer.getTime())
  totalMinutes = 30
  totalSeconds = totalMinutes * 60
  debug = false
  font = love.graphics.newFont("pixelmix.ttf")
  love.graphics.setFont(font)
end

function love.update(dt)
  height = love.graphics.getHeight()

  now = math.floor(love.timer.getTime())
  elapsedTime = now - start
  seconds = elapsedTime % 60
  if seconds < 10 then seconds = "0"..seconds end
  minutes = math.floor(elapsedTime / 60)
  if minutes < 10 then minutes = "0"..minutes end
  time = minutes..":"..seconds

  -- if love.keyboard.isDown("space") then
  --   if debug == false then debug = true end 
  -- end
end

function love.draw()
  if debug then
    love.graphics.print("start time : ".. start, 10, 10)
    love.graphics.print("Total seconds : "..totalSeconds, 10, 30)
    love.graphics.print("Now : "..now, 10, 50)
    love.graphics.print("Elapsed time : "..elapsedTime, 10, 70)
  end
  love.graphics.print(time, 30, height / 2, 0, 4, 4)
end

function love.keypressed(aKey)

end
