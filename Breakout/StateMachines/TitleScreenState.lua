TitleScreenState = Class{__includes = BaseState}

local highlighted = 1

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('up') then
        highlighted = 1
    elseif love.keyboard.wasPressed('down') then
        highlighted = 2
    end
end

function TitleScreenState:render()
    love.graphics.draw(background, 0, 0, 0, const.VIRTUAL_WIDTH / background:getWidth(), const.VIRTUAL_HEIGHT / background:getHeight())

    love.graphics.setFont(gFont['large'])
    love.graphics.setColor(0.1, 0.15, 0.4)
    love.graphics.printf('Breakout', 0, const.VIRTUAL_HEIGHT / 3, const.VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFont['medium'])
    if highlighted == 1 then 
        love.graphics.setColor(1, 0.65, 0)
    end

    love.graphics.printf('Start', 0, const.VIRTUAL_HEIGHT / 1.8, const.VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(0.1, 0.15, 0.4)

    if highlighted == 2 then 
        love.graphics.setColor(1, 0.65, 0)
    end

    love.graphics.printf('High Score', 0, const.VIRTUAL_HEIGHT / 1.5, const.VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(0.1, 0.15, 0.4)
end