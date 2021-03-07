-----------------------------------------------------------------------------------------
--
-- tabuleiro.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local startTimePlayerOne = nil
local startTimePlayerTwo = nil
local lastTime = nil
local endTime = 3600
local currentTimePlayerOne = nil
local currentTimePlayerTwo = nil
local isPlayerOne = true

local function timer(isPlayerOne)
	if isPlayerOne then
		if lastTime == nil then 
			lastTime = os.time()
			currentTimePlayerOne = lastTime
			return
		end
		if currentTimePlayerOne < endTime then
			currentTimePlayerOne = os.difftime(os.time(),lastTime);
			lastTime = os.time()
			return
		end
	end
	else
		if currentTimePlayerTwo < endTime then
			currentTimePlayerTwo = os.time() - lastTime
			lastTime = os.time()
			return
		end
	end
end


--------------------------------------------
-- forward declarations and other locals
local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX

-- pasta que contém o png do tabuleiro
local CHESSBOARD_PATH = ""

-- caminho completo do arquivo png do tabuleiro
local CHESSBOARD_PNG = CHESSBOARD_PATH .. "tabuleiro_pretobranco.png"

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


function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view

	-- create a grey rectangle as the backdrop
	-- the physical screen will likely be a different shape than our defined content area
	-- since we are going to position the background from it's top, left corner, draw the
	-- background at the real top, left corner.
	local background = display.newRect( display.screenOriginX, display.screenOriginY, screenW, screenH )
	background.anchorX = 0 
	background.anchorY = 0
	background:setFillColor( .5 )

	--
	-- "checkerBoard" controla renderização do tabuleiro:

	local checkerboard = display.newImageRect(CHESSBOARD_PNG, 640, 640)
	checkerboard.x = display.contentCenterX
	checkerboard.y = display.contentCenterY
	



	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( checkerboard )

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


end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene