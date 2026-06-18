TitleScreenState = Class{__includes = BaseState}
local const = require "constants"

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function TitleScreenState:render()
    local font = 'assets/font.ttf'
    local largeFont = love.graphics.newFont(font, 40)
    love.graphics.setFont(largeFont)
    local nameText = "Flappy Bird"
    local nameTextWidth = largeFont:getWidth(nameText)
    local textX = const.VIRTUAL_WIDTH/2 - nameTextWidth/2
    local textY = const.VIRTUAL_HEIGHT/2
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.print(nameText, const.VIRTUAL_WIDTH/2 - nameTextWidth/2 + 3, const.VIRTUAL_HEIGHT/4 + 3)
    love.graphics.setColor(1, 0.84, 0)
    love.graphics.print(nameText, const.VIRTUAL_WIDTH/2 - nameTextWidth/2, const.VIRTUAL_HEIGHT/4)

    local middleFont = love.graphics.newFont(font, 30)
    love.graphics.setFont(middleFont)
    local nameText = "Press 'Enter' to start"
    local nameTextWidth = middleFont:getWidth(nameText)
    local textX = const.VIRTUAL_WIDTH/2 - nameTextWidth/2
    local textY = const.VIRTUAL_HEIGHT/2
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.print(nameText, const.VIRTUAL_WIDTH/2 - nameTextWidth/2 + 3, const.VIRTUAL_HEIGHT/2 + 3)
    love.graphics.setColor(1, 0.65, 0)
    love.graphics.print(nameText, const.VIRTUAL_WIDTH/2 - nameTextWidth/2, const.VIRTUAL_HEIGHT/2)

    local smallFont = love.graphics.newFont(font, 20)
    love.graphics.setFont(smallFont)
    local nameText = "By Maria Striletska"
    local nameTextWidth = smallFont:getWidth(nameText)
    local textX = const.VIRTUAL_WIDTH/2 - nameTextWidth/2
    local textY = const.VIRTUAL_HEIGHT/2
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.print(nameText, const.VIRTUAL_WIDTH/2 - nameTextWidth/2 + 3, const.VIRTUAL_HEIGHT/1.5 + 3)
    love.graphics.setColor(1, 0.65, 0)
    love.graphics.print(nameText, const.VIRTUAL_WIDTH/2 - nameTextWidth/2, const.VIRTUAL_HEIGHT/1.5) 
end