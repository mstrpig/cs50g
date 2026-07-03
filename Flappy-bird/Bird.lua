Bird = Class {}

local const = require "constants"

local frameIndex = 1
local timer = 0
local interval = 0.1
local scaleX = 1.5
local scaleY = 1.5

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

    self.mouseIsDown = false
end

function Bird:update(dt)
    self.dy = self.dy + const.GRAVITY * dt
    self.y = self.y + self.dy * dt

    local mousePressed = love.mouse.isDown(1) and not self.wasMouseDown
    self.wasMouseDown = love.mouse.isDown(1)

    if love.keyboard.wasPressed('space') or mousePressed then
        gSounds['jump']:play()
        self.dy = -330
    end

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
    love.graphics.draw(self.frames[frameIndex], self.x, self.y, 0, 1.5, 1.5)
end

function Bird:collidesWithLowerPipe(pipe)
    if self.x > pipe.x + pipe.width * scaleX then
        return false
    end

    local birdRight = self.x + self.width * scaleX
    local pipeRight = pipe.x + pipe.width * scaleX

    local horizontal = birdRight >= pipe.x and self.x <= pipeRight

    return horizontal and self.y + self.height * scaleY >= pipe.y
end

function Bird:collidesWithUpperPipe(pipe)
    if self.x > pipe.x + pipe.width * scaleX then
        return false
    end

    local birdRight = self.x + self.width * scaleX
    local pipeRight = pipe.x + pipe.width * scaleX

    local horizontal = birdRight >= pipe.x and self.x <= pipeRight

    return horizontal and self.y <= pipe.y
end
