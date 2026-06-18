TitleScreenState = Class{__includes = BaseState}
local const = require "constants"

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function TitleScreenState:render()
    love.graphics.newFont('font.ttf', 20)
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf('Flappy Bird', 0, 100, const.VIRTUAL_WIDTH, 'center')
end