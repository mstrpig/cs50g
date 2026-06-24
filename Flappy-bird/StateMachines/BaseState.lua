BaseState = Class{}

function BaseState:init() end
function BaseState:render() end
function BaseState:update(dt) end
function BaseState:enter(params) end
function BaseState:exit() end

function drawText(text, fontSize, x, y, textColor)
    local font = 'assets/font.ttf'
    local textFont = love.graphics.newFont(font, fontSize)
    love.graphics.setFont(textFont)
    local textWidth = textFont:getWidth(text)
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.print(text, x - textWidth / 2 + 3, y + 3)
    love.graphics.setColor(textColor)
    love.graphics.print(text, x - textWidth / 2, y)
end