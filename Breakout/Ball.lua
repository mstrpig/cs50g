Ball = Class{}

const = require 'constants'

function Ball:init(paddle)
    self.image = love.graphics.newImage('Assets/Sprites/ball.png')

    self.width = self.image.getWidth(self.image) * 1.5
    self.height = self.image.getHeight(self.image) * 1.5
    
    self.x = paddle.x + paddle.width / 2
    self.y = paddle.y - self.height

    self.dx = math.random(2) == 1 and 100 or -100
    self.dy = math.random(-300, -150)
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.draw(self.image, self.x, self.y, 0, 1.5, 1.5)
end

function Ball:collision(paddle, dt)
    if self.x <= paddle.x + paddle.width 
    and self.x + self.width >= paddle.x
    and self.y <= paddle.y + paddle.height
    and self.y + self.height >= paddle.y then

        local overlapX = math.min(self.x + self.width - paddle.x, paddle.x + paddle.width - self.x)
        local overlapY = math.min(self.y + self.height - paddle.y, paddle.y + paddle.height - self.y)

        if overlapX < overlapY then
            self.dx = - self.dx
        else
            self.dy = - self.dy
        end
        
        return true
    end
end