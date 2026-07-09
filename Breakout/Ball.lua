Ball = Class{}

const = require 'constants'

function Ball:init()
    self.image = love.graphics.newImage('Assets/Sprites/ball.png')

    self.width = self.image.getWidth(self.image)
    self.height = self.image.getHeight(self.image)
    
    self.x = const.VIRTUAL_WIDTH / 2 - self.width / 2
    self.y = const.VIRTUAL_HEIGHT / 2 - self.height / 2

    self.dx = math.random(2) == 1 and 200 or -200
    self.dy = math.random(-100, 100)
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.draw(self.image, self.x, self.y, 0, 1.5, 1.5)
end