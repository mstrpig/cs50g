push = require 'push'
Class = require 'class'

const = require 'constants'
require 'StateMachine'
require 'StateMachines/BaseState'
require 'StateMachines/TitleScreenState'
require 'StateMachines/PlayState'
require 'StateMachines/ServeState'
require 'StateMachines/GameOverState'
require 'StateMachines/VictoryState'
require 'StateMachines/HighScoresState'

require 'Paddle'
require 'Ball'
require 'Brick'
require 'LevelMaker'

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
        ['play'] = function() return PlayState() end,
        ['serve'] = function() return ServeState() end,
        ['lose'] = function() return GameOverState() end,
        ['victory'] = function() return VictoryState() end,
        ['scores'] = function() return HighScoresState() end
    }

    gStateMachine:change('title')

    gFont = {
        ['large'] = love.graphics.newFont('Assets/Font/font.ttf', 60),
        ['medium'] = love.graphics.newFont('Assets/Font/font.ttf', 40),
        ['small'] = love.graphics.newFont('Assets/Font/font.ttf', 20)
    }

    background = love.graphics.newImage('Assets/Background/main_bg.png')
    fullHeart = love.graphics.newImage('Assets/Sprites/fullHeart.png')
    emptyHeart = love.graphics.newImage('Assets/Sprites/emptyHeart.png')
    sparkle = love.graphics.newImage('Assets/Sprites/sparkle.png')
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

function renderHearts(hearts)
    local heartsX = const.VIRTUAL_WIDTH - 70
    local heartsY = const.VIRTUAL_HEIGHT / 10
    local heartWidth = fullHeart:getWidth() * 1.5

    for i = 1, hearts do
        love.graphics.draw(fullHeart, heartsX, heartsY, 0, 1.5, 1.5)
        heartsX = heartsX + heartWidth
    end

    for i = 1, 3 - hearts do
        love.graphics.draw(emptyHeart, heartsX, heartsY, 0, 1.5, 1.5)
        heartsX = heartsX + heartWidth
    end
end

function loadHighScores()
    love.filesystem.setIdentity('Breakout')

    if not love.filesystem.getInfo('Breakout.lst') then
        local scores = ''
        for i = 10, 1, -1 do
            scores = scores .. 'STR\n'
            scores = scores .. tostring(i * 1000) .. '\n'
        end
        
        love.filesystem.write('Breakout.lst', scores)
    
    end

    local name = true
    local counter = 1
    local scores = {}

    for i = 1, 10 do
        scores[i] = {name = nil, score = nil}
    end

    for line in love.filesystem.lines('Breakout.lst') do
        if name then 
            scores[counter].name = string.sub(line, 1, 3)
        else
            scores[counter].score = tonumber(line)
            counter = counter + 1
        end

        name = not name

    end

    return scores

end