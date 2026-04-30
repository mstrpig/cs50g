push = require "push"
Class = require "class"

local const = require "constants"

local mountainsBlueX = 0
local mountainsGrayX = 0

function love.load()
    love.window.setTitle("Flappy Bird")

    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    push:setupScreen(const.VIRTUAL_WIDTH, const.VIRTUAL_HEIGHT, const.WINDOW_WIDTH, const.WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    background = love.graphics.newImage("/assets/bg/bg01.png")
    mountainsBlue = love.graphics.newImage("/assets/bg/bg02.png")
    mountainsGray = love.graphics.newImage("/assets/bg/bg03.png")
end

function love.update(dt)
    mountainsBlueX = (mountainsBlueX + 30 * dt) % background:getWidth()
    mountainsGrayX = (mountainsGrayX + 60 * dt) % background:getWidth()
end

function love.draw()
    push:apply("start")
    love.graphics.draw(background, 0, const.BG_Y_OFFSET)
    love.graphics.draw(mountainsBlue, -mountainsBlueX, const.BG_Y_OFFSET)
    love.graphics.draw(mountainsGray, -mountainsGrayX, const.BG_Y_OFFSET)
    push:apply("end")
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end