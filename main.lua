WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

push = require 'push'  --push is an external library
--table is the only data structure lua uses for its data uses its like python's 
--dictionary key : value pairs 

--[[runs when the game first starts up, only once; used to initialize the game
]]
function love.load()
    
   math.randomseed(os.time())
-- this filter is use to sharpen the screen text
   love.graphics.setDefaultFilter('nearest','nearest')

   smallFont = love.graphics.newFont('04B_03__.ttf',8)
   scoreFont = love.graphics.newFont('04B_03__.ttf',32)

   --player score variables 
   player1Score = 0
   player2Score = 0

   --variables for paddle on Y exis
   player1Y = 30
   player2Y = VIRTUAL_HEIGHT-40

   --Ball location variables
   ballX = VIRTUAL_WIDTH / 2 - 2
   ballY = VIRTUAL_HEIGHT / 2 -2

   --Ball velocity variables // Dx and Dy means delta time included
   ballDX = math.random(2) == 1 and -100 or 100
   ballDY = math.random(-50,50)

   --state variable for games current state
   gameState = 'start'


   push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
       fullscreen = false,
       vsync = true,
       resizable = false
   })

end



--[[called after update by LOVE, use to draw anything to the screen, updaated by other wise.
]]

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    
    elseif key == 'enter ' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        elseif gameState == 'play' then
            gameState = 'start'

            -- this variables duplicated here makes the resets its initial position at every start of the game
            ballX = VIRTUAL_WIDTH / 2 - 2
            ballY = VIRTUAL_HEIGHT / 2 -2

            ballDX = math.random(2) == 1 and -100 or 100
            ballDY = math.random(-50,50)
         
        end


    end
        
end


function love.draw()

   push:apply('start')
   --[[--the color values are sets in Love is 0 - 1 this range is mapped to 0 to 255
        0 being full dark and 1 being full white]]

   love.graphics.clear(40/255,45/255,52/255,1) 

   --creating the ball
   love.graphics.rectangle('fill',ballX , ballY , 5 , 5)
   --left paddle   X cordinate is horizontal y cordinate is vertical
   love.graphics.rectangle('fill',0,player1Y,5,20)
   --right paddle
   love.graphics.rectangle('fill',VIRTUAL_WIDTH-10,player2Y,5,20)
   
   love.graphics.setFont(smallFont)
   if gameState == 'start' then

        love.graphics.printf("Hello start state!",0, 20,VIRTUAL_WIDTH, "center" ) 

    elseif gameState == 'play'then

        love.graphics.printf("Hello play state!",0, 20,VIRTUAL_WIDTH, "center" ) 
        
   end

   love.graphics.setFont(scoreFont)
   love.graphics.print(player1Score,VIRTUAL_WIDTH/2-50,VIRTUAL_HEIGHT/3)
   love.graphics.print(player2Score,VIRTUAL_WIDTH/2+30,VIRTUAL_HEIGHT/3)

  

   push:apply('end')
end

-- all the movements and physics happens in this function  - it updates the position of objects in the 
--screen
function love.update(dt) -- delta time dt means rescale with frame rate of the machine in order to smooth movement
    if love.keyboard.isDown('w') then

        player1Y = math.max(0, player1Y + -PADDLE_SPEED * dt)

    elseif love.keyboard.isDown('s') then

        player1Y = math.min(VIRTUAL_HEIGHT -20,player1Y + PADDLE_SPEED *dt)

    end


    if love.keyboard.isDown('up')then

        player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt)

    elseif love.keyboard.isDown('down') then

        player2Y =  math.min(VIRTUAL_HEIGHT -20,player2Y + PADDLE_SPEED *dt)
    end

    if gameState == 'play' then
        
        --updating velocity to the ball object to move 

        ballX = ballX + ballDX * dt   
        ballY = ballY + ballDY * dt
    end


end

