Bird = {}
Bird.__index = Bird

function Bird:create()
    local bird = {}
    setmetatable(bird, Bird)
    bird.x = width/3
    bird.y = height/2

    positions = {}
    positions[1] = love.graphics.newImage("assets/sprites/redbird-downflap.png")
    positions[2] = love.graphics.newImage("assets/sprites/redbird-midflap.png")
    positions[3] = love.graphics.newImage("assets/sprites/redbird-upflap.png")

    bird.height = positions[2]:getHeight()
    bird.width = positions[2]:getWidth()

    frame = 1
    gravity = 2

    return bird
end

function Bird:update()
	self.y = self.y + gravity
    if love.keyboard.isDown("space") and self.y>self.height/2 then
		self.y = self.y - 10
	end
end

function Bird:draw()
    frame = frame + 0.15
    pos = math.floor(frame%3) + 1
	love.graphics.draw(positions[pos], self.x, self.y)
end

function Bird:collision(pipe)
    if (pipe.orient == 0 and self.y + self.height > pipe.y) then
        if (self.x + self.width > pipe.x and self.x  < pipe.x + pipeWidth) then
            return true
        end
    elseif (pipe.orient > 0 and self.y  < pipe.y) then
        if (self.x + self.width > pipe.x - pipeWidth and self.x  < pipe.x) then
            return true
        end
    end
    return false
end

function Bird:getScore(pipe)
    if (pipe.orient == 0 and self.x == pipe.x + pipeWidth + 5) or (pipe.orient > 0 and self.x == pipe.x + 5) then
        return true
    end
    return false
end