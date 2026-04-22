Paddle = Class{}

local const = require "constants"

function Paddle:init(x, y, width, height, color)
    self.x = x
    self.y = y 
    self.width = width
    self.height = height
    self.color = color
end

function Paddle:moveDown(dt)
    self.y = math.min(const.VIRTUAL_HEIGHT - self.height, self.y + const.PADDLE_SPEED * dt)
end

function Paddle:moveUp(dt)
    self.y = math.max(0, self.y + -const.PADDLE_SPEED * dt)
end

function Paddle:render()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Paddle:reset(y)
    self.y = y
end

