Bird = Class{}

local const = require "constants"

local frameIndex = 1
local timer = 0
local interval = 0.1

function Bird:init()
    self.frames = {
        love.graphics.newImage("/assets/yellowbird-downflap.png"),
        love.graphics.newImage("/assets/yellowbird-midflap.png"),
        love.graphics.newImage("/assets/yellowbird-upflap.png"),
        love.graphics.newImage("/assets/yellowbird-midflap.png")
    }

    self.width = self.frames[1]:getWidth()
    self.height = self.frames[1]:getHeight()

    self.x = const.VIRTUAL_WIDTH / 4 - self.width / 2
    self.y = const.VIRTUAL_HEIGHT / 2 - self.height / 2

    self.dy = 0
end

function Bird:update(dt)
    self.dy = self.dy + const.GRAVITY * dt
    self.y = self.y + self.dy * dt

    timer = timer + dt
    if timer > interval then
        timer = timer % interval
        frameIndex = frameIndex + 1

        if frameIndex > #self.frames then
            frameIndex = 1
        end
    end
end

function Bird:render()
    love.graphics.draw(self.frames[frameIndex], self.x, self.y)
end