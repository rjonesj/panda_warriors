Player = Object:extend()

function Player:new()
  self.image = love.graphics.newImage("img/panda_64.png")
  self.x = 300
  self.y = 20
  self.speed = 500
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
end

function Player:update(dt)
  if love.keyboard.isDown("left") then
    self.x = self.x - self.speed * dt
  elseif love.keyboard.isDown("right") then
    self.x = self.x + self.speed * dt
  end
  
  --Get the width of the window
  local window_width = love.graphics.getWidth()
  
  --If the x is too far to the left then..
  if self.x < 0 then
    --set x to 0
    self.x = 0
  --Repeat for right side
  elseif self.x + self.width > window_width then
    self.x = window_width - self.width
  end  
end

function Player:shootGun()
  if (mode == "auto" and love.keyboard.isDown("space")) or mode == "manual" then
    --Put a new instance of Bullet inside listOfBullets
    table.insert(listOfBullets, Bullet(self.x, self.y))
    --Engage the second cannon blaster
    table.insert(listOfBullets, Bullet((self.x+self.width)-10, self.y))
    --Play sound
    bullet_sfx:play()
  end
end

function Player:draw()
  love.graphics.draw(self.image, self.x, self.y)
end
