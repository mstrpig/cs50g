PlayState = Class{__includes = BaseState}

local const = require "constants"

function PlayState:init()
    self.bird = Bird()
    self.upperPipes = {}
    self.lowerPipes = {}
    self.pipeSpawnTimer = 0
    self.mountainsBlueX = 0
    self.mountainsGrayX = 0
    self.score = 0
    self.lastY = 0
    self.isCollisionDetected = false
    self:generatePipePair()
end

function PlayState:update(dt)
    self:updateBackgroundXPos(dt)
    self.bird:update(dt)

    self:spawnPipePair(dt, 2.3)

    self:moveAndCleanPipes(dt)

    self:collisionWithPipes()

    self:checkIfScored(dt)

    self:collisionWithScreenBorders()

    if self.isCollisionDetected == true then
        love.timer.sleep(1)
        gStateMachine:change('score', self.score)
    end
end

function PlayState:render()
    love.graphics.draw(background, 0, const.BG_Y_OFFSET)
    love.graphics.draw(mountainsBlue, -self.mountainsBlueX, const.BG_Y_OFFSET)
    love.graphics.draw(mountainsGray, -self.mountainsGrayX, const.BG_Y_OFFSET)
    
    self.bird:render()

    for _, pipe in pairs(self.upperPipes) do
        pipe:render()
    end

    for _, pipe in pairs(self.lowerPipes) do
        pipe:render()
    end

    self:scoreRender()
end

function PlayState:generatePipePair()
    local y = math.random(150, const.VIRTUAL_HEIGHT - 50)
    table.insert(self.upperPipes, Pipe(y - 110, true))
    table.insert(self.lowerPipes, Pipe(y, false))
end

function PlayState:updateBackgroundXPos(dt)
    self.mountainsBlueX = (self.mountainsBlueX + 30 * dt) % background:getWidth()
    self.mountainsGrayX = (self.mountainsGrayX + 45 * dt) % background:getWidth()
end

function PlayState:spawnPipePair(dt, spawnInterval)
    self.pipeSpawnTimer = self.pipeSpawnTimer + dt
    if self.pipeSpawnTimer >= spawnInterval then
        self.pipeSpawnTimer = self.pipeSpawnTimer % spawnInterval
        self:generatePipePair()
    end
end

function PlayState:moveAndCleanPipes(dt)
    for k, pipe in pairs(self.upperPipes) do
        pipe:update(dt)

        if pipe.x + pipe.width * 1.5 < 0 then
            table.remove(self.upperPipes, k)
        end
    end

    -- Update lower pipes position and delete pipe when off-screen
    for k, pipe in pairs(self.lowerPipes) do
        pipe:update(dt)

        if pipe.x + pipe.width * 1.5 < 0 then
            table.remove(self.lowerPipes, k)
        end
    end
end

function PlayState:collisionWithPipes()
    for _, pipe in pairs(self.upperPipes) do
        if self.bird:collidesWithUpperPipe(pipe) then
            gSounds['lose']:play()
            self.isCollisionDetected = true 
        end
    end

    for _, pipe in pairs(self.lowerPipes) do
        if self.bird:collidesWithLowerPipe(pipe) then
            gSounds['lose']:play()
            self.isCollisionDetected = true
        end
    end
end

function PlayState:checkIfScored(dt)
    for k, pipe in pairs(self.upperPipes) do
        local obstaclePassed = self.bird.x > pipe.x + pipe.width
        if obstaclePassed and not pipe.isScored then
            pipe.isScored = true
            self.score = self.score + 1
        end
    end
end

function PlayState:scoreRender()
    drawText("Score: " .. self.score, 20, const.VIRTUAL_WIDTH / 6, const.VIRTUAL_HEIGHT / 6, orange)
end

function PlayState:collisionWithScreenBorders()
    if self.bird.y <= 0 or self.bird.y + self.bird.height >= const.VIRTUAL_HEIGHT then
        gSounds['lose']:play()
        gStateMachine:change('score', self.score)
    end
end