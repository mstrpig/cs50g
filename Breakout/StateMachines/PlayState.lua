PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.paddle = Paddle()
    self.ball = Ball()
end

function PlayState:update(dt)
    self.paddle:update(dt)
    self.ball:update(dt)

    self:collisionWithPaddle(dt)
    self:collisionWithWalls(dt)
end

function PlayState:render()
    love.graphics.draw(background, 0, 0, 0, const.VIRTUAL_WIDTH / background:getWidth(), const.VIRTUAL_HEIGHT / background:getHeight())
    self.paddle:render()
    self.ball:render()
end

function PlayState:collisionWithPaddle(dt)
    if self.ball.x <= self.paddle.x + self.paddle.width
        and self.ball.x + self.ball.width >= self.paddle.x
        and self.ball.y <= self.paddle.y + self.paddle.height
        and self.ball.y + self.ball.height >= self.paddle.y then
            self.ball.dy = - self.ball.dy
    end
end

function PlayState:collisionWithWalls(dt)
    if self.ball.x <= 0 then
        self.ball.dx = - self.ball.dx
    end

    if self.ball.y <= 0 then
        self.ball.dy = - self.ball.dy
    end

    if self.ball.x + self.ball.width >= const.VIRTUAL_WIDTH then
        self.ball.dx = - self.ball.dx
    end
end