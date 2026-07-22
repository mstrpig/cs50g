PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.paddle = Paddle()
    self.ball = Ball(self.paddle)
    self.bricks = LevelMaker.createMap(1)
    self.hearts = 3
    self.score = 0
end

function PlayState:update(dt)
    self.paddle:update(dt)
    self.ball:update(dt)

    if self.ball:collision(self.paddle, dt) then
        if self.ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
        self.ball.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - self.ball.x))

        elseif self.ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
            self.ball.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ball.x))
        end
    end

    self:collisionWithWalls(dt)
    self:collisionWithBrick(dt)
end

function PlayState:render()
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

function PlayState:collisionWithWalls(dt)
    if self.ball.x <= 0 then
        self.ball.x = 0
        self.ball.dx = - self.ball.dx
    end

    if self.ball.y <= 0 then
        self.ball.y = 0
        self.ball.dy = - self.ball.dy
    end

    if self.ball.x + self.ball.width >= const.VIRTUAL_WIDTH then
        self.ball.x = const.VIRTUAL_WIDTH - self.ball.width
        self.ball.dx = - self.ball.dx
    end

    if self.ball.y + self.ball.height >= const.VIRTUAL_HEIGHT then
        self.hearts = self.hearts - 1
        self.ball.x = self.paddle.x + self.paddle.width / 2
        self.ball.y = self.paddle.y - self.ball.height
        if self.hearts == 0 then
            gStateMachine:change('lose', {score = self.score})
        else gStateMachine:change('serve', {
            paddle = self.paddle,
            ball = self.ball,
            bricks = self.bricks,
            hearts = self.hearts,
            score = self.score
        })
        end
    end
end

function PlayState:collisionWithBrick(dt)
    for _, brick in pairs(self.bricks) do
        if brick.onScreen
            and self.ball.x <= brick.x + brick.width
            and self.ball.x + self.ball.width >= brick.x
            and self.ball.y <= brick.y + brick.height
            and self.ball.y + self.ball.height >= brick.y
        then
            brick:wasHit()
            self.score = self.score + 10

            local dx = math.min(
                self.ball.x + self.ball.width - brick.x,
                brick.x + brick.width - self.ball.x
            )
            local dy = math.min(
                self.ball.y + self.ball.height - brick.y,
                brick.y + brick.height - self.ball.y
            )

            if dx < dy then self.ball.dx = -self.ball.dx
            else self.ball.dy = -self.ball.dy end

            break
        end
    end
end

function PlayState:enter(params)
    if params then
        self.paddle = params.paddle
        self.ball = params.ball
        self.bricks = params.bricks
        self.hearts = params.hearts
        self.score = params.score
    end
end