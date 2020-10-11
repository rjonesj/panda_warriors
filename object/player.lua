Player = Object:extend()

function Player:new()
  self.image = love.graphics.newImage("img/panda.png")
  self.x = 300
  self.y = 20
  self.speed = 500
  self.width = self.image:getWidth()
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
  if love.keyboard.isDown("space") then
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
