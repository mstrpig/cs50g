Brick = Class{}

function Brick:init(x, y, hitNumber)
    self.image = love.graphics.newImage('Assets/Sprites/brick.png')

    self.width = self.image.getWidth(self.image) * 1.5
    self.height = self.image.getHeight(self.image) * 1.5

    self.x = x
    self.y = y

    self.onScreen = true

    self.hitNumber = hitNumber
end

function Brick:wasHit()
    self.hitNumber = self.hitNumber - 1
    if self.hitNumber == 0 then
        self.onScreen = false
    end
end

function Brick:render()
    if self.onScreen == true then
        love.graphics.draw(self.image, self.x, self.y, 0, 1.5, 1.5)
    end
end