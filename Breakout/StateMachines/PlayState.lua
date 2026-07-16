PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.paddle = Paddle()
    self.ball = Ball()
    self.bricks = LevelMaker.createMap(1)
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