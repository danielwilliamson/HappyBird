-- 

local dw = director.displayWidth
local dh = director.displayHeight


local timernode = director:createNode({x=0,y=0})

local systemtimernode = director:createNode({x=0,y=0})

local scorelabel = director:createLabel( {x =director.displayWidth -200, y = director.displayHeight - 200 , text = "0", textXScale = 3.0, textYScale = 3.0, color=color.black, zOrder = 700})

local playerscore = 0

local systemEvents = {}


-- Collision event listener
function playerscoreCollision(event)
    dbg.print("Score")
    playerscore = playerscore +10
    scorelabel.text = playerscore
dbg.print(playerscore)
	if event.phase == "began" then
    local playerNode
		local scoreNode
		if event.nodeA.name == "player" then
			playerNode = event.nodeA
			scoreNode = event.nodeB
		else
			playerNode = event.nodeB
			scoreNode = event.nodeA
		end


end

 
end



-- Background
local bg = director:createSprite(0, 0, "textures/background.png")
bg.xScale = dw / bg.w
bg.yScale = dh / bg.h



local atlasplayer = director:createAtlas( {
    width = 192,
    height = 169,
    numFrames = 3,
    textureName = "textures/player_sprite.png",
  } )
  
  local animplayer = director:createAnimation( {
    start = 1,
    count = 3,
    atlas = atlasplayer,
    delay = 1/12,
    } )

  local player = director:createSprite( {
    x=director.displayCenterX - 100, y=director.displayCenterY,
    xAnchor=1, yAnchor=0,
    source=animplayer,
    zOrder =  100,
    
    } )
    
    physics:setGravity(0, -1500)
    physics:addNode(player, {restitution=-100, density= 20})
    
    
    
 local playernode = director:createNode({x=director.displayCenterX,y=director.displayCenterY,xAnchor=1, yAnchor=0, w =192, h=169, name = "player"})
physics:addNode(playernode, {isSensor=true, restitution=-100, density= 20})

local floor = director:createSprite( {
   x =0, y = 0,
   xAnchor=0, yAnchor=0,
   source="textures/ground.png",
   xScale = 100
 })
physics:addNode(floor, {type ="static", restitution=0})
tween:to(floor, {time=100, uvRect={x=1, y=0}, mode="repeat"} )



    




-- Touch

local flyup = function(event)
        if player.y <= director.displayHeight then
         player.physics:applyLinearImpulse(0, 2000)
        playernode.physics:applyLinearImpulse(0, 2000)

        end
        
end


function systemEvents:touch(event)
    if event.phase == "began" then
      
      flyup()
    
    end
  
    
    
    end


-- Add global listener for touch events
system:addEventListener("touch", systemEvents)


--Level



local polespawntimer = function(event)
math.randomseed(os.time())
local polescale = math.random(1, 7)
local polescale2
local scoreY



if polescale == 1 then
  polescale2 = 8
  scoreY=567
end
if polescale == 2 then
  polescale2 = 7
  scoreY=486
end
if polescale == 3 then
  polescale2 = 6
  scoreY=405
end
if polescale == 4 then
  polescale2 = 5
  scoreY=324
end
if polescale == 5 then
  polescale2 = 4
  scoreY=234
end
if polescale == 6 then
  polescale2 = 3
  scoreY=162
end
if polescale == 7 then
  polescale2 = 2
  scoreY=81
  end

pole = director:createSprite( { x=director.displayWidth, y=director.displayHeight, yScale=polescale,  xAnchor= 0, yAnchor= 1, zOrder = 200, source="textures/pipe.png", name="pole"})



pole2 = director:createSprite( { x = director.displayWidth, y=45, yScale= polescale2,  xAnchor= 0, yAnchor= 0, zOrder = 200, source="textures/pipe2.png", name="pole2"})

physics:addNode(pole, {isSensor = true})

physics:addNode(pole2, {isSensor = true})



score = director:createSprite( { x=pole.x + 320, y = scoreY +250, xAnchor= 0.5, yAnchor= 0.5, zOrder = 500, source="textures/score.png", name= "score"})

physics:addNode(score, {isSensor=true})

score:addEventListener("collision", playerscoreCollision)


tween:to(pole, { x=-284, y=director.displayHeight, time=7 })

tween:to(pole2, { x=-284, y=20, time=7})

tween:to(score, { x=-284, y= scoreY +250, time=6.5})

   
end
  timernode:addTimer(polespawntimer, 3, 0, 1)
 

-- Event listener: collision with ground

 
local systemtimer = function(event)
  
dbg.print(playernode.y)
  
if player.y < 41 then 
      
      timernode:pauseTimers()
      floor:pauseTweens()
      pole:pauseTweens()
      pole2:pauseTweens()
      player:pause()
      print("Collison")
      
      end
  end
    timernode:addTimer(systemtimer, 0.1, 0)
 
    
    playernode:addEventListener("collision", playerscoreCollision)
  

