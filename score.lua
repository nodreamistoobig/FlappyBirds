Score = {}
Score.__index = Score

function Score:create()
    local score = {}
    setmetatable(score, Score)
    score.value = 0
    score.numbers = {}
    for i = 1, 9 do
        score.numbers[i] = love.graphics.newImage("assets/sprites/" .. tostring(i) .. ".png")
    end
    score.numbers[10] = love.graphics.newImage("assets/sprites/0.png")
    score.digits = {}
    for i = 1, 4 do
        score.digits[i] = 0
    end

    return score
end

function Score:update()
    local value = score.value
    for i = 1,4 do
        self.digits[i] = value % 10
        value = value - self.digits[i]
        value = value / 10
        if value == 0 then
            break
        end
    end
end

function Score:draw()
    local digitAmount = 1
    for i = 4,1, -1 do
        if (self.digits[i] ~= 0) then
            digitAmount = i
            break
        end
    end
    local gap = 30
    for i = 1, digitAmount, 1  do
        if digitAmount % 2 == 1 then
            mid = math.ceil(digitAmount/2)
        else
            mid = (digitAmount+1)/2
        end

        if score.digits[i] > 0 then
            love.graphics.draw(score.numbers[score.digits[i]], width/2 + gap*(mid-i), height/5)
        else
            love.graphics.draw(score.numbers[10], width/2 + gap*(mid-i), height/5)
        end
    end
 end

function Score:add()
    score.value = score.value + 1
end