TitleScreenState = Class{__includes = BaseState}
local const = require "constants"

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('count')
    end
end

function TitleScreenState:render()
    love.graphics.draw(background, 0, const.BG_Y_OFFSET)
    love.graphics.draw(mountainsBlue, 0, const.BG_Y_OFFSET)
    love.graphics.draw(mountainsGray, 0, const.BG_Y_OFFSET)

    yellow = {1, 0.84, 0}
    orange = {1, 0.65, 0}
    drawText("Flappy Bird", 40, const.VIRTUAL_WIDTH / 2, const.VIRTUAL_HEIGHT / 4, yellow)
    drawText("Press 'Enter' to start", 30, const.VIRTUAL_WIDTH / 2, const.VIRTUAL_HEIGHT / 2, orange)
    drawText("By Maria Striletska", 20, const.VIRTUAL_WIDTH / 2, const.VIRTUAL_HEIGHT / 1.5, orange)

end