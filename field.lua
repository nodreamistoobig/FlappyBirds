Field = {}
Field.__index = Field

function Field:create()
    local field = {}
    setmetatable(field, Field)
    math.randomseed(os.clock())
    field.period = pipeWidth
    field.frame = 0
    field.posibility = 0.2
    field.pipes = {}
    field.n = 20
    field.index = 1
    return field
end

function Field:draw()
	for k, v in pairs(self.pipes) do
        self.pipes[k]:update()
        self.pipes[k]:draw()
        if (bird:collision(self.pipes[k])) then
            gameStatus = "over"
            break
        end
        if (bird:getScore(self.pipes[k])) then
            score:add()
        end
    end
end


function Field:update()

    self.frame = self.frame + 1
	if (self.frame % self.period == 0) then
        if math.random(0, 1) < self.posibility then
            randomHeight = math.random(30, 250)
            randomOrientation = math.floor(math.random(0, 1))
            self.pipes[self.index] = Pipe:create(randomHeight, randomOrientation, 1)
            self.pipes[self.index]:draw()
            self.index = (self.index + 1) % self.n + 1
            self.posibility = self.posibility + 0.01
        end
 math.randomseed(os.clock())

        if self.posibility>0.5 and math.random(0, 1) < self.posibility then
            randomHeight = math.random(30, height - randomHeight - 100)
            nextOrientation = 1 - randomOrientation
            if randomHeight > pipeHeight then
                randomHeight = pipeHeight
            end
            self.pipes[self.index] = Pipe:create(randomHeight, nextOrientation, 1)
            self.pipes[self.index]:draw()
            self.index = (self.index + 1) % self.n + 1
        end
    end
end




Pipe = {}
Pipe.__index = Pipe

function Pipe:create(h, orient, color)
    local pipe = {}
    setmetatable(pipe, Pipe)

    if (orient == 1) then
        pipe.y = h
        pipe.orient = 3.142
        pipe.x = width + pipeWidth
    else
        pipe.y = height - h
        pipe.orient = 0
        pipe.x = width
    end

    pipe.color = color

    return pipe
end

function Pipe:draw()
	love.graphics.draw(pipeTypes[self.color], self.x, self.y, self.orient)
end

function Pipe:update()
	self.x = self.x-1
end