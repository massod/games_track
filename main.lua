WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

push = require 'push'
--table is the only data structure lua uses for its data uses its like python's 
--dictionary key : value pairs 

--[[runs when the game first starts up, only once; used to initialize the game
]]
function love.load()

-- this filter is use to sharpen the screen text
   love.graphics.setDefaultFilter('nearest','nearest')

   smallFont = love.graphics.newFont('04B_03__.ttf',8)
   scoreFont = love.graphics.newFont('04B_03__.ttf',32)

   player1Score = 0
   player2Score = 0

   player1Y = 30
   player2Y = VIRTUAL_HEIGHT-40

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
    end
end


function love.draw()

   push:apply('start')
   --[[--the color values are sets in Love is 0 - 1 this range is mapped to 0 to 255
        0 being full dark and 1 being full white]]

   love.graphics.clear(40/255,45/255,52/255,1) 

   --creating the ball
   love.graphics.rectangle('fill',VIRTUAL_WIDTH/2-2,VIRTUAL_HEIGHT/2-2,5,5)
   --left paddle   X cordinate is horizontal y cordinate is vertical
   love.graphics.rectangle('fill',0,player1Y,5,20)
   --right paddle
   love.graphics.rectangle('fill',VIRTUAL_WIDTH-10,player2Y,5,20)
   
   love.graphics.setFont(smallFont)
   love.graphics.printf("Hello Pong!",0, 20,VIRTUAL_WIDTH, "center" ) 
   
   love.graphics.setFont(scoreFont)
   love.graphics.print(player1Score,VIRTUAL_WIDTH/2-50,VIRTUAL_HEIGHT/3)
   love.graphics.print(player2Score,VIRTUAL_WIDTH/2+30,VIRTUAL_HEIGHT/3)

  

   push:apply('end')
end

-- all the movements and physics happens in this function  - it updates the position of objects in the 
--screen
function love.update(dt) -- delta time dt means rescale with frame rate of the machine in order to smooth movement
    if love.keyboard.isDown('w') then
        player1Y = player1Y - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        player1Y = player1Y + PADDLE_SPEED *dt
    end

    if love.keyboard.isDown('up')then
        player2Y = player2Y - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        player2Y = player2Y + PADDLE_SPEED * dt
    end
end

