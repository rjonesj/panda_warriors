function love.load()
  Object = require "lib.classic"
  tick = require "lib.tick"
  
  require "object.player"
  require "object.enemy"
  require "object.bullet"
  
  player = Player()
  --enemy = Enemy()
  listOfBullets = {}
  listOfEnemies = {}
  table.insert(listOfEnemies, Enemy())
  table.insert(listOfEnemies, Enemy())
  table.insert(listOfEnemies, Enemy())
  enemyCount = 3
  
  local drawInterval = 0.2
  event = tick.recur(fireGun, drawInterval)
end

function fireGun() 
  player:shootGun()
end


function love.update(dt)
  
  tick.update(dt)
  player:update(dt)
  --enemy:update(dt)
  
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
  --enemy:draw()
  
  for i,v in ipairs(listOfEnemies) do
    v:draw(dt)
  end
       
  for i,v in ipairs(listOfBullets) do
    v:draw(dt)
  end  
  
  if enemyCount == 0 then
    love.graphics.print("YOU WIN!", 100, 300, 0, 2, 2)
  end
end