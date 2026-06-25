CountDownState = Class{__includes = BaseState}

const = require "constants"

function CountDownState:init()
    self.count = 3
    self.timer = 0
end

function CountDownState:update(dt)
    self.timer = self.timer + dt

    if self.timer >= 1 then
        self.timer = self.timer % 1
        self.count = self.count - 1
    end

    if self.count == 0 then
        gStateMachine:change('play')
    end
end

function CountDownState:render()
    love.graphics.draw(background, 0, const.BG_Y_OFFSET)
    love.graphics.draw(mountainsBlue, 0, const.BG_Y_OFFSET)
    love.graphics.draw(mountainsGray, 0, const.BG_Y_OFFSET)
    
    drawText(self.count, 60, const.VIRTUAL_WIDTH / 2, const.VIRTUAL_HEIGHT / 3, orange)
end