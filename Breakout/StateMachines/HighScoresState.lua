HighScoresState = Class {__includes = BaseState}

function HighScoresState:enter()
    self.highScores = loadHighScores()
end

function HighScoresState:update(dt)
    if love.keyboard.wasPressed('backspace') then
        gStateMachine:change('title')
    end
end

function HighScoresState:render()
    love.graphics.draw(background, 0, 0, 0, const.VIRTUAL_WIDTH / background:getWidth(), const.VIRTUAL_HEIGHT / background:getHeight())

    love.graphics.setFont(gFont['large'])
    love.graphics.setColor(0.1, 0.15, 0.4)
    love.graphics.printf('High Scores', 0, const.VIRTUAL_HEIGHT / 10, const.VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFont['small'])
    for i = 1, 10 do
        local rowSpacing = 25
        local y = const.VIRTUAL_HEIGHT / 4 + (i - 1) * rowSpacing
        love.graphics.print(
            tostring(i) .. '. ' .. self.highScores[i].name,
            const.VIRTUAL_WIDTH / 4, y
        )
        love.graphics.print(
            tostring(self.highScores[i].score),
            const.VIRTUAL_WIDTH / 1.5, y
        )
    end
end