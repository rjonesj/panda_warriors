Enemy = Object:extend()

function Enemy:new(y)
  self.image = love.graphics.newImage("img/snake_64.png")
  self.x = love.math.random(450)
  self.y = y
  self.speed = 100
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  self.dead = false
  self.spawnRate = love.math.random(0.2, 0.4)
  self.spawnTime = love.math.random(0.5, 1.5)
  self.spawnCounter = 0
  self.health = 100
end

function Enemy:update(dt)
  self.spawnCounter = self.spawnCounter + self.spawnRate * dt
  if self.spawnCounter > self.spawnTime then
    local row = love.math.random(1, 3)
    local rowY = (row * 100) + 200
    table.insert(listOfEnemies, Enemy(rowY ))
    self.spawnCounter = 0
  end  
  
  self.x = self.x + self.speed * dt
  
  local window_width = love.graphics.getWidth()
  
  if self.x < 0 then
    self.x = 0
    self.speed = -self.speed
  elseif self.x + self.width > window_width then
    self.x = window_width - self.width
    self.speed = -self.speed
  end
    
  if self.health <= 0 then
    self.dead = true
  end
  
  if enemyCount > maxEnemies then
    self.dead = true
  end
end

function Enemy:draw()
  if not self.dead then
    love.graphics.draw(self.image, self.x, self.y)  
  end  
end
