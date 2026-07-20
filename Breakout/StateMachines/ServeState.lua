ServeState = Class{__includes = BaseState}

function ServeState:update()
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play', {
            paddle = self.paddle,
            ball = self.ball,
            bricks = self.bricks,
            hearts = self.hearts
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
end

function ServeState:enter(params)
    self.paddle = params.paddle
    self.ball = params.ball
    self.bricks = params.bricks
    self.hearts = params.hearts
end