function love.load()
  Object = require "lib.classic"
  tick = require "lib.tick"
  
  require "object.player"
  require "object.enemy"
  require "object.bullet"
  
  player = Player()
  listOfBullets = {}
  listOfEnemies = {}
  table.insert(listOfEnemies, Enemy(300))
  table.insert(listOfEnemies, Enemy(400))
  table.insert(listOfEnemies, Enemy(500))
  enemyCount = 3
  maxEnemies = 7
  mode = "auto"
  drawInterval = 0.2
  enableDebug = false
  
  event = tick.recur(fireGun, drawInterval)
  
  bullet_sfx = love.audio.newSource("audio/bullet.wav", "static")
  bullet_sfx:setVolume(0.5) 
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
  
  if key == "f1" then
    love.event.quit("restart")
  end
  
  if key == "space" then
    if mode == "manual" then
      fireGun()
    end
  end 
  
  if key == "m" then
    if mode == "auto" then
      event:stop()
      mode = "manual"
    elseif mode == "manual" then
      event = tick.recur(fireGun, drawInterval)
      mode = "auto"    
    end    
  end
  
  if key == "d" then
    if enableDebug then
      enableDebug = false
    else
      enableDebug = true
    end
  end
end

function fireGun() 
  player:shootGun()
end

function love.update(dt)
  tick.update(dt)
  player:update(dt)
  
  enemyCount = 0
  for i,v in ipairs(listOfEnemies) do
    enemyCount = enemyCount + 1
    v:update(dt)     
    
    if v.dead then
      --Remove the enemy from list if dead
      table.remove(listOfEnemies, i)
    end
  end    
   
  bulletCount = 0 
  for i,v in ipairs(listOfBullets) do
    v:update(dt)
    for j,w in ipairs(listOfEnemies) do
      v:checkCollision(w)
    end
    
    if v.y > love.graphics.getHeight() then
      v.dead = true
    end
        
    if v.dead then
      --Remove the bullet from list if dead
      table.remove(listOfBullets, i)
    else
      bulletCount = bulletCount + 1
    end
  end    
end

function love.draw()
  player:draw()
  
  for i,v in ipairs(listOfEnemies) do
    if i <= maxEnemies then
      v:draw(dt)
    end    
  end
       
  for i,v in ipairs(listOfBullets) do
    v:draw(dt)
  end  
  
  if enemyCount == 0 then
    love.graphics.print("YOU WIN! PRESS F1 TO RESTART", 215, 300, 0, 2, 2)
  end
  
  if enableDebug then
    love.graphics.print("Bullet count: " .. bulletCount, 25, 100)
    love.graphics.print("Enemy count: " .. enemyCount, 25, 130)
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 25, 160)
  end
end