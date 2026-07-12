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
            b = Brick((x-1) * xOffset + 8 + (13 - numCols) * yOffset, y * yOffset)
            table.insert(bricks, b)
        end
    end
    
    return bricks

end