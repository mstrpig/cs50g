push = require "push"
Class = require "class"

require "Ball"
require "Paddle"

local const = require "constants"
local p1Score = 0
local p2Score = 0
local gameState = "start"
local winner = nil

function love.load()
    love.window.setTitle("Pong")

    love.graphics.setDefaultFilter('nearest', 'nearest')
    font = love.graphics.newFont('font.ttf', 20)
    love.graphics.setFont(font)
    
    push:setupScreen(const.VIRTUAL_WIDTH, const.VIRTUAL_HEIGHT, const.WINDOW_WIDTH, const.WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    paddle1 = Paddle(5, const.P1_START_Y_POS, 5, const.PADDLE_HEIGHT, {1, 0, 0})
    paddle2 = Paddle(390, const.P2_START_Y_POS, 5, const.PADDLE_HEIGHT, {0, 1, 0})
    ball = Ball(const.BALL_START_X_POS, const.BALL_START_Y_POS, const.BALL_SIZE, const.BALL_SIZE)
end

function love.update(dt)
    if gameState == "play" then
        if love.keyboard.isDown("w") then
            paddle1:moveUp(dt)
        elseif love.keyboard.isDown("s") then
            paddle1:moveDown(dt)
        end

        if love.keyboard.isDown("up") then
            paddle2:moveUp(dt)
        elseif love.keyboard.isDown("down") then
            paddle2:moveDown(dt)
        end

        ball:update(dt)

        if ball:collides(paddle1) then
            ball.dx = -ball.dx * const.PADDLE_SPEED_MULTIPLIER
            ball.x = paddle1.x + const.PADDLE_WIDTH
            ball:randomizeVerticalVelocity()
        end

        if ball:collides(paddle2) then
            ball.dx = -ball.dx * const.PADDLE_SPEED_MULTIPLIER
            ball.x = paddle2.x - const.BALL_SIZE
            ball:randomizeVerticalVelocity()
        end

        if ball.y <= 0 then
            ball.dy = -ball.dy
            ball.y = 0
        end

        if ball.y >= const.VIRTUAL_HEIGHT - const.BALL_SIZE then
            ball.dy = -ball.dy
            ball.y = const.VIRTUAL_HEIGHT - const.BALL_SIZE
        end

        if ball.x + const.BALL_SIZE < 0 then
            p2Score = p2Score + 1
            gameState = "serve"
        end
        
        if ball.x > const.VIRTUAL_WIDTH then
            p1Score = p1Score + 1
            gameState = "serve"
        end

        if p1Score >= const.WIN_SCORE then
            gameState = "win"
            winner = "Player 1"
        end

        if p2Score >= const.WIN_SCORE then
            gameState = "win"
            winner = "Player 2"
        end
    elseif gameState == "serve" then
        initObjectsPosition()
    elseif gameState == "win" then
        initObjectsPosition()
        p1Score = 0
        p2Score = 0
    end

end

function love.draw()
    push:apply("start")

    love.graphics.clear(0.1, 0.1, 0.1)

    local text = tostring(p1Score)
    local textScale = 2
    local textWidth = font:getWidth(text) * textScale

    love.graphics.print(text, 150, 50, 0, textScale, textScale)
    love.graphics.print(p2Score, const.VIRTUAL_WIDTH - 150 - textWidth, 50, 0, textScale, textScale)
    
    ball:render()
    paddle1:render()
    paddle2:render()

    if gameState == "start" then
        love.graphics.setColor(0.53, 0.81, 0.92)
        local pongText = "Pong"
        local pongTextScale = 1.5
        local pongTextWidth = font:getWidth(pongText) * pongTextScale
        love.graphics.print(pongText, const.VIRTUAL_WIDTH / 2 - pongTextWidth/ 2, 15, 0, pongTextScale, pongTextScale)

        local pressEnterText = "Press 'Enter' to start"
        local pressEnterTextWidth = font:getWidth(pressEnterText)
        love.graphics.setColor(1, 0.5, 0)
        love.graphics.print(pressEnterText, const.VIRTUAL_WIDTH / 2 - pressEnterTextWidth/ 2, 170)

        local nameText = "by Maria Striletska"
        local nameTextWidth = font:getWidth(nameText)
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.print(nameText,  const.VIRTUAL_WIDTH / 2 - nameTextWidth/ 2, const.VIRTUAL_HEIGHT - 30)
    
    elseif gameState == "serve" then
        local pointScoredText = "Point scored!\nPress 'Enter' to continue"
        love.graphics.setColor(1, 0.5, 0)
        love.graphics.printf(pointScoredText, 0, 170, const.VIRTUAL_WIDTH, "center")

    elseif gameState == "win" then
        local winText = winner .. " wins!\nPress 'Enter' to restart"
        love.graphics.setColor(1, 0.5, 0)
        love.graphics.printf(winText, 0, 170, const.VIRTUAL_WIDTH, "center")
    end

    push:apply("end")
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

    if key == "enter" or key == "return" then
        if gameState == "play" then
            gameState = "start"
            initObjectsPosition()
        else
            gameState = "play"
        end
    end
end

function initObjectsPosition()
    ball:reset()
    paddle1:reset(const.P1_START_Y_POS)
    paddle2:reset(const.P2_START_Y_POS)
end