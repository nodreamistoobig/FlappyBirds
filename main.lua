require("bird")
require("field")
require("score")


function love.load()	
	love.window.setTitle("Flappy Birds")
	background = love.graphics.newImage("assets/sprites/background-day.png")
	message = love.graphics.newImage("assets/sprites/message.png")
	over = love.graphics.newImage("assets/sprites/gameover.png")

	pipeTypes = {}   
    pipeTypes[1] = love.graphics.newImage("assets/sprites/pipe-green.png")
    pipeTypes[2] = love.graphics.newImage("assets/sprites/pipe-red.png")
    pipeHeight = pipeTypes[1]:getHeight()
    pipeWidth = pipeTypes[1]:getWidth()

	width = background:getWidth() 
	height = background:getHeight() 

	love.window.setMode(width, height)
	bird = Bird:create()
	field = Field:create()
	pipe = Pipe:create(96, 1, 1)

	score = Score:create()

	gameStatus = "message"
end

function love.update()
	if (gameStatus == "play") then
		bird:update()
		field:update()
		score:update()
		score:draw()
		if bird.y + bird.height > height then
			gameStatus = "over"
		end
	elseif love.keyboard.isDown("space") then
		gameStatus = "play"
		bird.x = width/3
		bird.y = height/2
		field.pipes = {}
		field.posibility = 0.2
		score.value = 0
		for i = 1, 4 do
			score.digits[i] = 0
		end
	end
end

function love.draw()
	love.graphics.draw(background, 0, 0)
	if (gameStatus == "play") then
		bird:draw()
		field:draw()
		score:draw()
	elseif (gameStatus == "message") then
		love.graphics.draw(message, width/5, height/4)
	elseif (gameStatus == "over") then
		love.graphics.draw(over, width/6, height/4)
	end
end