Pipe = Class {}

local const = require "constants"

local scaleX = 1.5

function Pipe:init(y, inverted)
    self.image = love.graphics.newImage("assets/pipe.png")

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = const.VIRTUAL_WIDTH
    self.y = y

    self.scaleY = 1.5

    if inverted then
        self.scaleY = -self.scaleY
    end
end

function Pipe:update(dt)
    self.x = self.x - 60 * dt
end

function Pipe:render()
    love.graphics.draw(self.image, self.x, self.y, 0, scaleX, self.scaleY)
end
