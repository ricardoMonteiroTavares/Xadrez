-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"

local nanosvg = require( "plugin.nanosvg" )


--------------------------------------------
-- path to the chessboard
local CHESSBOARD_PATH = "\\assets\\chessboard\\"

-- path to the pieces
local PIECES_PATH = "\\assets\\pieces\\"

-- complete path to the chessboard
local CHESSBOARD_PNG = CHESSBOARD_PATH .. "chessboard.png"

local startTimePlayerOne = nil
local startTimePlayerTwo = nil
local lastTime = nil
local endTime = 3600
local currentTimePlayerOne = 0
local currentTimePlayerTwo = 0
local isPlayerOne = true


-- "grid" controla o tamanho do tabuleiro, "cell" controla o tamanho de cada célula do tabuleiro
local GRID_WIDTH = 8
local GRID_HEIGHT = 8
local CELL_WIDTH = 80
local CELL_HEIGHT = 80

--
-- "grid" é o vetor 2D que controla o movimento das peças atráves de coordenadas no formato: grid[x][y]
local grid = {}
for i = 1, GRID_HEIGHT do
	grid[i] = {}
end

local function timerGame(isPlayerOne)
	if isPlayerOne then
		if lastTime == nil then 
			lastTime = os.time()
			currentTimePlayerOne = currentTimePlayerOne + os.time() - lastTime
			return
		end
		if currentTimePlayerOne < endTime then
			currentTimePlayerOne = currentTimePlayerOne + os.time() - lastTime
			lastTime = os.time()
			return
		end
	else
		if currentTimePlayerTwo < endTime then
			currentTimePlayerTwo = currentTimePlayerTwo + os.time() - lastTime
			lastTime = os.time()
			return
		end
	end
end

-- forward declarations and other locals
local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX

function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	timerP1 = display.newText("Player 1:  00:00", -500, 100, 500, 100 )
    timerP2 = display.newText("Player 2:  00:00", 1300, 100, 500, 100 )
	local minutes = math.floor( endTime / 60 )
    local seconds = endTime % 60
	limitTIme = display.newText(string.format("Limit time:  %02d:%02d",minutes, seconds),1250, 1200, 500, 100 )


	local sceneGroup = self.view

	-- We need physics started to add bodies, but we don't want the simulaton
	-- running until the scene is on the screen.
	physics.start()
	physics.pause()


	-- create a grey rectangle as the backdrop
	-- the physical screen will likely be a different shape than our defined content area
	-- since we are going to position the background from it's top, left corner, draw the
	-- background at the real top, left corner.
	local background = display.newRect( display.screenOriginX, display.screenOriginY, screenW, screenH )
	background.anchorX = 0 
	background.anchorY = 0
	background:setFillColor( .5 )
	
	local chessboard = display.newImageRect( CHESSBOARD_PNG, 640, 640) 
	chessboard.x = display.contentCenterX
	chessboard.y = display.contentCenterY


	local tex = nanosvg.newTexture(
	{
   		filename = PIECES_PATH .. "p1pawn.svg",
	})

	local p1rook = display.newImageRect( tex.filename, tex.baseDir, 60, 60) 
	
	p1rook.x = display.contentCenterX
	p1rook.y = display.contentCenterY
	tex:releaseSelf()
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( chessboard )
	sceneGroup:insert( p1rook )
end


function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

function update( event )
	timerGame(true)
	local minutes = math.floor( currentTimePlayerOne / 60 )
    local seconds = currentTimePlayerOne % 60
	timerP1.text = string.format("Player 1:  %02d:%02d",minutes, seconds)
	local minutes = math.floor( currentTimePlayerTwo / 60 )
    local seconds = currentTimePlayerTwo % 60
	timerP2.text = string.format("Player 2:  %02d:%02d",minutes, seconds)
end



---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
Runtime:addEventListener( "enterFrame", update )


-----------------------------------------------------------------------------------------

return scene