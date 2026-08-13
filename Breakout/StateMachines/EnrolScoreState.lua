EnrolScoreState = Class {__includes = BaseState}

function EnrolScoreState:init()
    self.highScore = loadHighScores()
    self.letters = { [1] = 65, [2] = 65, [3] = 65}
    self.highlightedLetter = 1
end

function EnrolScoreState:update(dt)
    if love.keyboard.wasPressed('up') then
        self.letters[self.highlightedLetter] = self.letters[self.highlightedLetter] + 1
        if self.letters[self.highlightedLetter] > 90 then
            self.letters[self.highlightedLetter] = 65
        end
        
    elseif love.keyboard.wasPressed('down') then
        self.letters[self.highlightedLetter] = self.letters[self.highlightedLetter] - 1
        if self.letters[self.highlightedLetter] < 65 then
            self.letters[self.highlightedLetter] = 90
        end
    
    elseif love.keyboard.wasPressed('right') then
        self.highlightedLetter = math.min(3, self.highlightedLetter + 1)
    elseif love.keyboard.wasPressed('left') then
        self.highlightedLetter = math.max(1, self.highlightedLetter - 1)
    elseif love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        local name = string.char(self.letters[1]) .. string.char(self.letters[2]) .. string.char(self.letters[3])
        saveHighScore(name, self.score)
        gStateMachine:change('play', {
            paddle = self.paddle,
            ball = self.ball,
        hearts = 3,
        score = 0,
        level = self.level
    })
    end
end

function EnrolScoreState:render()
    love.graphics.draw(background, 0, 0, 0, const.VIRTUAL_WIDTH / background:getWidth(), const.VIRTUAL_HEIGHT / background:getHeight())
    
    love.graphics.setFont(gFont['large'])
    love.graphics.setColor(0.1, 0.15, 0.4)
    love.graphics.printf('New High Score!', 0, const.VIRTUAL_HEIGHT / 4, const.VIRTUAL_WIDTH, 'center')
    
    love.graphics.setFont(gFont['medium'])
    love.graphics.printf('Your score: ' .. tostring(self.score), 0, const.VIRTUAL_HEIGHT / 2.5, const.VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFont['medium'])
    local lettersX = const.VIRTUAL_WIDTH / 2 - 60
    local lettersY = const.VIRTUAL_HEIGHT / 1.8
    for i = 1, 3 do
        if i == self.highlightedLetter then
            love.graphics.setColor(1, 0.65, 0)
        else
            love.graphics.setColor(0.1, 0.15, 0.4)
        end

        love.graphics.print(string.char(self.letters[i]), lettersX, lettersY)
        lettersX = lettersX + 60
    end
end

function EnrolScoreState:enter(params)
    self.paddle = params.paddle
    self.ball = params.ball
    self.score = params.score
    self.level = params.level
end