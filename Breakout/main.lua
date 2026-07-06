push = require "push"
Class = require "class"

const = require "constants"

function love.load()
    math.randomseed(os.clock())
    love.window.setTitle("Breakout")

    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(const.VIRTUAL_WIDTH, const.VIRTUAL_HEIGHT, const.WINDOW_WIDTH, const.WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end