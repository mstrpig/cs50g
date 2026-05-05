Pipe = Class{}

local const = require "constants"

function Pipe:init()
    self.image = love.graphics.newImage("assets/pipe.png")

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = const.VIRTUAL_WIDTH
    self.y = 240
end

function Pipe:update(dt)
    self.x = self.x - 60 * dt
end

function Pipe:render()
    love.graphics.draw(self.image, self.x, self.y, 0, 1.5, 1.5)
end