push = require "push"
Class = require "class"

local const = require "constants"

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

end

function love.draw()
    push:apply("start")
    love.graphics.draw(background, 0, const.BG_X_OFFSET)
    love.graphics.draw(mountainsBlue, 0, const.BG_X_OFFSET)
    love.graphics.draw(mountainsGray, 0, const.BG_X_OFFSET)
    push:apply("end")
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end