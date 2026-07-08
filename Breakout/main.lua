push = require 'push'
Class = require 'class'

const = require 'constants'
require 'StateMachine'
require 'StateMachines/BaseState'
require 'StateMachines/TitleScreenState'
require 'StateMAchines/PlayState'

function love.load()
    math.randomseed(os.clock())
    love.window.setTitle('Breakout')

    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(const.VIRTUAL_WIDTH, const.VIRTUAL_HEIGHT, const.WINDOW_WIDTH, const.WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    love.keyboard.keysPressed = {}

    gStateMachine = StateMachine{
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end
    }

    gStateMachine:change('title')

    gFont = {
        ['large'] = love.graphics.newFont('Assets/Font/font.ttf', 60),
        ['medium'] = love.graphics.newFont('Assets/Font/font.ttf', 40)
    }

    background = love.graphics.newImage('Assets/Background/main_bg.png')
end

function love.update(dt)
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:apply('start')
    gStateMachine:render()
    push:apply('end')
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    
    love.keyboard.keysPressed[key] = true
end