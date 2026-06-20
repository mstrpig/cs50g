push = require "push"
Class = require "class"

require "Bird"
require "Pipe"

require "StateMachine"
require "StateMachines.BaseState"
require "StateMachines.TitleScreenState"
require "StateMachines.PlayState"

local const = require "constants"

function love.load()
    math.randomseed(os.clock())
    love.window.setTitle("Flappy Bird")

    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.keyboard.keysPressed = {}

    push:setupScreen(const.VIRTUAL_WIDTH, const.VIRTUAL_HEIGHT, const.WINDOW_WIDTH, const.WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    gStateMachine = StateMachine{
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end
    }
    gStateMachine:change('title')

    background = love.graphics.newImage("assets/bg/bg01.png")
    mountainsBlue = love.graphics.newImage("assets/bg/bg02.png")
    mountainsGray = love.graphics.newImage("assets/bg/bg03.png")
end

function love.update(dt)
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.draw()
    push:apply("start")

    gStateMachine:render()

    push:apply("end")
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    
    love.keyboard.keysPressed[key] = true
end
