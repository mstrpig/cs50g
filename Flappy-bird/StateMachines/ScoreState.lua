ScoreState = Class{__includes = BaseState}

const = require 'constants'

function ScoreState:update()
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function ScoreState:enter(params)
    self.score = params
end

function ScoreState:render()
    love.graphics.draw(background, 0, const.BG_Y_OFFSET)
    love.graphics.draw(mountainsBlue, 0, const.BG_Y_OFFSET)
    love.graphics.draw(mountainsGray, 0, const.BG_Y_OFFSET)

    drawText("Game Over", 40, const.VIRTUAL_WIDTH / 2, const.VIRTUAL_HEIGHT / 4, orange)
    drawText("Your score is: " ..self.score, 30, const.VIRTUAL_WIDTH / 2, const.VIRTUAL_HEIGHT / 2, orange)
    drawText("Press 'Enter' to continue", 20, const.VIRTUAL_WIDTH / 2, const.VIRTUAL_HEIGHT / 1.5, orange)
end