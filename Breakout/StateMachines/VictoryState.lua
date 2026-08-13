VictoryState = Class{__includes = BaseState}

function VictoryState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        self.ball.x = self.paddle.x + self.paddle.width / 2 - self.ball.width/2
        self.ball.y = self.paddle.y - self.ball.height
        self.ball.dy = math.random(-300, -150)
        
        if scoreQualifies(self.score) then
            gStateMachine:change('enroll', {
                paddle = self.paddle,
                ball = self.ball,
                score = self.score,
                level = self.level
            })
            else gStateMachine:change('play', {
                paddle = self.paddle,
                ball = self.ball,
                hearts = 3,
                score = 0,
                level = self.level
            })

        end
    end
end

function VictoryState:render()
    love.graphics.draw(background, 0, 0, 0, const.VIRTUAL_WIDTH / background:getWidth(), const.VIRTUAL_HEIGHT / background:getHeight())
    self.paddle:render()
    self.ball:render()

    love.graphics.setFont(gFont['large'])
    love.graphics.setColor(0.1, 0.15, 0.4)
    love.graphics.printf('You Won!', 0, const.VIRTUAL_HEIGHT / 2.5, const.VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFont['medium'])
    love.graphics.printf('Your score: ' ..tostring(self.score), 0, const.VIRTUAL_HEIGHT / 1.8, const.VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFont['small'])
    love.graphics.printf('You completed level ' ..tostring(self.level) ..'. Press "Enter" to continue', 0, const.VIRTUAL_HEIGHT / 1.5, const.VIRTUAL_WIDTH, 'center')
end

function VictoryState:enter(params)
    self.paddle = params.paddle
    self.ball = params.ball
    self.score = params.score
    self.level = params.level
end