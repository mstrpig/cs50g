LevelMaker = Class()

function LevelMaker.createMap(level)
    local tempBrick = Brick()
    local xOffset = tempBrick.width
    local yOffset = tempBrick.height
    local bricks = {}
    local numRows = math.random(1, 4)
    local numCols = math.random(5,10)

    for y = 1, numRows do
        for x = 1, numCols do
            local hitNumber = (numRows - y + 1) + level
            if math.random(1, 10) > 3 then
                b = Brick((x-1) * xOffset + (const.VIRTUAL_WIDTH - numCols * xOffset) / 2, y * yOffset, hitNumber)
                table.insert(bricks, b)
            end
        end
    end
    
    return bricks

end