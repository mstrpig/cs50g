TitleScreenState = Class{__includes = BaseState}
local const = require "constants"

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function TitleScreenState:render()
    love.graphics.draw(background, 0, const.BG_Y_OFFSET)
    love.graphics.draw(mountainsBlue, 0, const.BG_Y_OFFSET)
    love.graphics.draw(mountainsGray, 0, const.BG_Y_OFFSET)
    
    local function drawText(text, fontSize, y, textColor)
        local font = 'assets/font.ttf'
        local textFont = love.graphics.newFont(font, fontSize)
        love.graphics.setFont(textFont)
        local textWidth = textFont:getWidth(text)
        local textX = const.VIRTUAL_WIDTH / 2 - textWidth / 2
        local textY = const.VIRTUAL_HEIGHT / 2
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.print(text, const.VIRTUAL_WIDTH / 2 - textWidth / 2 + 3, y + 3)
        love.graphics.setColor(textColor)
        love.graphics.print(text, const.VIRTUAL_WIDTH / 2 - textWidth / 2, y)
    end

    local yellow = {1, 0.84, 0}
    local orange = {1, 0.65, 0}
    drawText("Flappy Bird", 40, const.VIRTUAL_HEIGHT / 4, yellow)
    drawText("Press 'Enter' to start", 30, const.VIRTUAL_HEIGHT / 2, orange)
    drawText("By Maria Striletska", 20, const.VIRTUAL_HEIGHT / 1.5, orange)

end