-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

-- pasta que contém os botões
local REC_BUTTON_PATH = "\\assets\\buttons\\rectangleButton\\"

-- caminho dos arquivos png
local REC_BUTTON_PNG = REC_BUTTON_PATH .. "rectangleButton.png"
local REC_BUTTON_PNG_OVER = REC_BUTTON_PATH .. "rectangleButton_over.png"

local BUTTON_HEIGHT = 96
local BUTTON_WIDTH = 400

--------------------------------------------

-- forward declarations and other locals
local pvpBtn
local pviBtn
local iviBtn

-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
	
	-- go to level1.lua scene
	composer.gotoScene( "level1", "fade", 500 )
	
	return true	-- indicates successful touch
end

-- Função que cria os botões
-- String title -> título do botão
-- int 	  y_pos -> posição do botão no eixo y
local function createButton(title, y_pos)
	local btn =  widget.newButton{
		label = title,
		labelColor = { default={ 1.0 }, over={ 0.5 } },
		defaultFile = REC_BUTTON_PNG,
		overFile = REC_BUTTON_PNG_OVER,
		width = BUTTON_WIDTH, 
		height = BUTTON_HEIGHT,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	btn.x = display.contentCenterX
	btn.y = y_pos
	return btn
end

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	-- local background = display.newImageRect( "background.jpg", display.actualContentWidth, display.actualContentHeight )
	-- background.anchorX = 0
	-- background.anchorY = 0
	-- background.x = 0 + display.screenOriginX 
	-- background.y = 0 + display.screenOriginY
	
	local title = display.newText("Xadrez", display.contentCenterX, 200, native.systemFont, 150);

	-- create a widget button (which will loads level1.lua on release)

	pvpBtn = createButton("Jogador vs Jogador", 		(display.contentHeight - 500))
	pviBtn = createButton("Jogador vs Computador", 		(display.contentHeight - 340))
	iviBtn = createButton("Computador vs Computador", 	(display.contentHeight - 180))
	
	-- all display objects must be inserted into group
	--sceneGroup:insert( background )
	sceneGroup:insert( title )
	sceneGroup:insert( pvpBtn )
	sceneGroup:insert( pviBtn )
	sceneGroup:insert( iviBtn )
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
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if pvpBtn then
		pvpBtn:removeSelf()	-- widgets must be manually removed
		pvpBtn = nil
	end

	if pviBtn then
		pviBtn:removeSelf()	-- widgets must be manually removed
		pviBtn = nil
	end

	if iviBtn then
		iviBtn:removeSelf()	-- widgets must be manually removed
		iviBtn = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
