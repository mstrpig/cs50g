push = require "push"
Class = require "class"

require "Bird"
require "Pipe"

local const = require "constants"

local mountainsBlueX = 0
local mountainsGrayX = 0

local upperPipes = {}
local lowerPipes = {}
local pipeSpawnTimer = 0

function love.load()
    math.randomseed(os.clock())
    love.window.setTitle("Flappy Bird")

    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(const.VIRTUAL_WIDTH, const.VIRTUAL_HEIGHT, const.WINDOW_WIDTH, const.WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    background = love.graphics.newImage("assets/bg/bg01.png")
    mountainsBlue = love.graphics.newImage("assets/bg/bg02.png")
    mountainsGray = love.graphics.newImage("assets/bg/bg03.png")
    bird = Bird()

    local y = math.random(150, const.VIRTUAL_HEIGHT - 50)
    table.insert(upperPipes, Pipe(y - 110, true))
    table.insert(lowerPipes, Pipe(y, false))
end

function love.update(dt)
    mountainsBlueX = (mountainsBlueX + 30 * dt) % background:getWidth()
    mountainsGrayX = (mountainsGrayX + 45 * dt) % background:getWidth()
    bird:update(dt)

    pipeSpawnTimer = pipeSpawnTimer + dt
    if pipeSpawnTimer >= 3.5 then
        pipeSpawnTimer = pipeSpawnTimer % 3.5
        local y = math.random(150, const.VIRTUAL_HEIGHT - 50)
        table.insert(upperPipes, Pipe(y - 110, true))
        table.insert(lowerPipes, Pipe(y, false))
    end

    -- Update upper pipes position and delete pipe when off-screen
    for k, pipe in pairs(upperPipes) do
        pipe:update(dt)

        if pipe.x + pipe.width * 1.5 < 0 then
            table.remove(upperPipes, k)
        end
    end

    -- Update lower pipes position and delete pipe when off-screen
    for k, pipe in pairs(lowerPipes) do
        pipe:update(dt)

        if pipe.x + pipe.width * 1.5 < 0 then
            table.remove(lowerPipes, k)
        end
    end

    for _, pipe in pairs(upperPipes) do
        if bird:collidesWithUpperPipe(pipe) then
            love.event.quit()
        end
    end

    for _, pipe in pairs(lowerPipes) do
        if bird:collidesWithLowerPipe(pipe) then
            love.event.quit()
        end
    end
end

function love.draw()
    push:apply("start")
    love.graphics.draw(background, 0, const.BG_Y_OFFSET)
    love.graphics.draw(mountainsBlue, -mountainsBlueX, const.BG_Y_OFFSET)
    love.graphics.draw(mountainsGray, -mountainsGrayX, const.BG_Y_OFFSET)
    bird:render()

    for _, pipe in pairs(upperPipes) do
        pipe:render()
    end

    for _, pipe in pairs(lowerPipes) do
        pipe:render()
    end

    push:apply("end")
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

    if key == "space" then
        bird.dy = -180
    end
end
