function love.load()
  Object = require "lib.classic"
  tick = require "lib.tick"
  
  require "object.player"
  require "object.enemy"
  require "object.bullet"
  
  player = Player()
  listOfBullets = {}
  listOfEnemies = {}
  table.insert(listOfEnemies, Enemy())
  table.insert(listOfEnemies, Enemy())
  table.insert(listOfEnemies, Enemy())
  enemyCount = 3
  maxEnemies = 7
  
  local drawInterval = 0.2
  event = tick.recur(fireGun, drawInterval)
  
  bullet_sfx = love.audio.newSource("audio/bullet.wav", "static")
  bullet_sfx:setVolume(0.5) 
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
      
  for i,v in ipairs(listOfBullets) do
    v:update(dt)
    for j,w in ipairs(listOfEnemies) do
      v:checkCollision(w)
    end
    
    if v.y > 600 then
      v.dead = true
    end
        
    if v.dead then
      --Remove the bullet from list if dead
      table.remove(listOfBullets, i)
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
end

function love.keypressed(key)
  if key == "f1" then
    love.event.quit("restart")
  end
end