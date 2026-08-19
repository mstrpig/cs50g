PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.paddle = Paddle()
    self.ball = Ball(self.paddle)
    self.bricks = LevelMaker.createMap(0)
    self.hearts = 3
    self.score = 0
    self.level = 0

    self.sparkleSystem = love.graphics.newParticleSystem(sparkle, 64)
    self.sparkleSystem:setParticleLifetime(0.5, 1)
    self.sparkleSystem:setLinearAcceleration(-15, 0, 15, 80)
    self.sparkleSystem:setEmissionArea('normal', 10, 10)
end

function PlayState:update(dt)
    self.paddle:update(dt)
    self.ball:update(dt)

    if self.ball:collisionWithPaddle(self.paddle) then
        gSounds['ball_hit_paddle_and_walls']:play()
        if self.ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
        self.ball.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - self.ball.x))

        elseif self.ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
            self.ball.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ball.x))
        end
    end

    self:collisionWithWalls()
    self:collisionWithBricks()
    self.sparkleSystem:update(dt)
    
    if self:checkVictory() == true then
        gSounds['win']:play()
        self.level = self.level + 1
        gStateMachine:change('victory', {
            paddle = self.paddle,
            ball = self.ball,
            score = self.score,
            level = self.level
        })
    end
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

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.sparkleSystem, 0, 0)
end

function PlayState:collisionWithWalls()
    if self.ball.x <= 0 then
        gSounds['ball_hit_paddle_and_walls']:play()
        self.ball.x = 0
        self.ball.dx = - self.ball.dx
    end

    if self.ball.y <= 0 then
        gSounds['ball_hit_paddle_and_walls']:play()
        self.ball.y = 0
        self.ball.dy = - self.ball.dy
    end

    if self.ball.x + self.ball.width >= const.VIRTUAL_WIDTH then
        gSounds['ball_hit_paddle_and_walls']:play()
        self.ball.x = const.VIRTUAL_WIDTH - self.ball.width
        self.ball.dx = - self.ball.dx
    end

    if self.ball.y + self.ball.height >= const.VIRTUAL_HEIGHT then
        self.hearts = self.hearts - 1
        if self.hearts == 0 then
            gSounds['lose']:play()
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

function PlayState:collisionWithBricks()
    for _, brick in pairs(self.bricks) do
        if brick.onScreen and self.ball:collisionWithBrick(brick) then
            brick:wasHit()
            gSounds['ball_hit_brick']:play()
            self.score = self.score + 10
            self.sparkleSystem:setPosition(brick.x + brick.width / 2, brick.y + brick.height / 2)
            self.sparkleSystem:emit(64)
            break
        end
    end
end

function PlayState:checkVictory()
    for _, brick in pairs(self.bricks) do
        if brick.onScreen then
            return false
        end
    end

    return true

end

function PlayState:enter(params)
    if params then
        self.paddle = params.paddle
        self.ball = params.ball
        self.bricks = params.bricks or LevelMaker.createMap(self.level)
        self.hearts = params.hearts or 3
        self.score = params.score or 0
        self.level = params.level or 1
    end
end