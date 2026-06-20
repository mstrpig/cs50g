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
    self:generatePipePair()
end

function PlayState:update(dt)
    self.mountainsBlueX = (self.mountainsBlueX + 30 * dt) % background:getWidth()
    self.mountainsGrayX = (self.mountainsGrayX + 45 * dt) % background:getWidth()
    self.bird:update(dt)

    self.pipeSpawnTimer = self.pipeSpawnTimer + dt
    if self.pipeSpawnTimer >= 3.5 then
        self.pipeSpawnTimer = self.pipeSpawnTimer % 3.5
        self:generatePipePair()
    end

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

    for _, pipe in pairs(self.upperPipes) do
        if self.bird:collidesWithUpperPipe(pipe) then
            love.event.quit()
        end
    end

    for _, pipe in pairs(self.lowerPipes) do
        if self.bird:collidesWithLowerPipe(pipe) then
            love.event.quit()
        end
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

end

function PlayState:generatePipePair()
    local y = math.random(150, const.VIRTUAL_HEIGHT - 50)
    table.insert(self.upperPipes, Pipe(y - 110, true))
    table.insert(self.lowerPipes, Pipe(y, false))
end