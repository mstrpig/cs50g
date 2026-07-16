Ball = Class{}

const = require 'constants'

function Ball:init()
    self.image = love.graphics.newImage('Assets/Sprites/ball.png')

    self.width = self.image.getWidth(self.image) * 1.5
    self.height = self.image.getHeight(self.image) * 1.5
    
    self.x = const.VIRTUAL_WIDTH / 2 - self.width / 2
    self.y = const.VIRTUAL_HEIGHT / 2 - self.height / 2

    self.dx = math.random(2) == 1 and 300 or -300
    self.dy = math.random(-100, 100)
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