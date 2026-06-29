Bird = Class {}

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

    self.mouseIsDown = false
end

function Bird:update(dt)
    self.dy = self.dy + const.GRAVITY * dt
    self.y = self.y + self.dy * dt

    local mousePressed = love.mouse.isDown(1) and not self.wasMouseDown
    self.wasMouseDown = love.mouse.isDown(1)

    if love.keyboard.wasPressed('space') or mousePressed then
        gSounds['jump']:play()
        self.dy = -180
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
    local obstaclePassed = self.x > pipe.x + pipe.width
    if obstaclePassed then
        return false
    end

    local collided = self.x + self.width >= pipe.x and self.y + self.height >= pipe.y
    return collided
end

function Bird:collidesWithUpperPipe(pipe)
    local obstaclePassed = self.x > pipe.x + pipe.width
    if obstaclePassed then
        return false
    end

    local collided = self.x + self.width >= pipe.x and self.y + self.height <= pipe.y
    return collided
end
