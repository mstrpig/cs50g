Paddle = Class{}

const = require 'constants'

function Paddle:init()
    self.image = love.graphics.newImage('Assets/Sprites/paddle.png')

    self.width = self.image:getWidth() * 1.5
    self.height = self.image:getHeight() * 1.5

    self.x = const.VIRTUAL_WIDTH / 2 - self.width / 2
    self.y = const.VIRTUAL_HEIGHT / 1.3 - self.height / 2

    self.dx = 0
end

function Paddle:update(dt)
    if love.keyboard.isDown('a') then
        self.dx = - const.PADDLE_SPEED * dt
        self.x = self.x + self.dx
        elseif love.keyboard.isDown('d') then
            self.dx = const.PADDLE_SPEED * dt
            self.x = self.x + self.dx
        end
    end

function Paddle:render()
    love.graphics.draw(self.image, self.x, self.y, 0, 1.5, 1.5)
end