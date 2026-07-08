PlayState = Class{__includes = BaseState}

function PlayState:render()
    love.graphics.draw(background, 0, 0, 0, const.VIRTUAL_WIDTH / background:getWidth(), const.VIRTUAL_HEIGHT / background:getHeight())
end