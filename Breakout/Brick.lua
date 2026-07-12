Brick = Class{}

function Brick:init(x, y)
    self.image = love.graphics.newImage('Assets/Sprites/brick.png')

    self.width = self.image.getWidth(self.image) * 1.5
    self.height = self.image.getHeight(self.image) * 1.5

    self.x = x
    self.y = y

    self.onScreen = true
end

function Brick:wasHit()
    self.onScreen = false
end

function Brick:render()
    if self.onScreen == true then
        love.graphics.draw(self.image, self.x, self.y, 0, 1.5, 1.5)
    end
end