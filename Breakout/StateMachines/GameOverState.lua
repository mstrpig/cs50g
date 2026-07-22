GameOverState = Class{__includes = BaseState}

const = require 'constants'

function GameOverState:update()
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function GameOverState:render()
    love.graphics.draw(background, 0, 0, 0, const.VIRTUAL_WIDTH / background:getWidth(), const.VIRTUAL_HEIGHT / background:getHeight())
    
    love.graphics.setFont(gFont['large'])
    love.graphics.setColor(0.1, 0.15, 0.4)

    love.graphics.printf('Game Over', 0, const.VIRTUAL_HEIGHT / 2.5, const.VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFont['medium'])
    love.graphics.printf('Your score: ' ..tostring(self.score), 0, const.VIRTUAL_HEIGHT / 1.8, const.VIRTUAL_WIDTH, 'center')
end

function GameOverState:enter(params)
    self.score = params.score
end