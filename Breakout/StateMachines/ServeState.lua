ServeState = Class{__includes = BaseState}

function ServeState:update(dt)
    self.paddle:update(dt)
    self.ball.x = self.paddle.x + self.paddle.width / 2 - self.ball.width/2
    self.ball.y = self.paddle.y - self.ball.height
    self.ball.dy = math.random(-300, -150)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play', {
            paddle = self.paddle,
            ball = self.ball,
            bricks = self.bricks,
            hearts = self.hearts,
            score = self.score
        })
    end
end

function ServeState:render()
    love.graphics.draw(background, 0, 0, 0, const.VIRTUAL_WIDTH / background:getWidth(), const.VIRTUAL_HEIGHT / background:getHeight())
    self.paddle:render()
    self.ball:render()
    
    for _, brick in pairs(self.bricks) do
    brick:render()
    end

    renderHearts(self.hearts)

    love.graphics.setFont(gFont['small'])
    love.graphics.setColor(0.1, 0.15, 0.4)
    love.graphics.printf('Score: ' ..tostring(self.score), 0, const.VIRTUAL_HEIGHT / 10, const.VIRTUAL_WIDTH / 10)
end

function ServeState:enter(params)
    self.paddle = params.paddle
    self.ball = params.ball
    self.bricks = params.bricks
    self.hearts = params.hearts
    self.score = params.score
end