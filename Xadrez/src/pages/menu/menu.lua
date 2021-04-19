-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

-- caminho para a tela que inicia o jogo
local GAME_SCENE = "\\src\\pages\\game\\game"

-- pasta que contém os botões
local BUTTON_PATH = "\\assets\\buttons\\"

-- caminho dos arquivos png
local REC_BUTTON_PNG = BUTTON_PATH .. "rectangleButton\\rectangleButton.png"
local REC_BUTTON_PNG_OVER = BUTTON_PATH .. "rectangleButton\\rectangleButton_over.png"
local SETTINGS_BUTTON_PNG = BUTTON_PATH .. "settingsButton\\settings.png"

local BUTTON_HEIGHT = 96
local BUTTON_WIDTH = 400

local FONT = "Times New Roman"
--------------------------------------------

-- forward declarations and other locals
local pvpBtn
local pviBtn
local iviBtn
local settingsBtn

-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
	
	-- go to game.lua scene
	composer.gotoScene( GAME_SCENE, "fade", 500 )
	
	return true	-- indicates successful touch
end

-- Função que converte um código de cor em hexadecimal sem o # em um código de cor decimal
-- String hex -> Cor em hexadecimal sem #
-- Retorno: rgb table
local function color(hex)
	assert(type(hex) == "string" ,"O código de cor deve ser do tipo string")
	
	if string.len(hex) == 6 then
		local r = tonumber(string.sub(hex,1,2), 16)/255
		local g = tonumber(string.sub(hex,3,4), 16)/255
		local b = tonumber(string.sub(hex,5,6), 16)/255

		return { r, g, b }
	
	elseif string.len(hex) == 3 then
		local r = (tonumber(string.sub(hex, 1, 1), 16) * 17)/255
		local g = (tonumber(string.sub(hex, 2, 2), 16) * 17)/255
		local b = (tonumber(string.sub(hex, 3, 3), 16) * 17)/255

		return { r, g, b }
	else
		error("O código de cor deve ter apenas 3 ou 6 caracteres.")
	end
end

-- Função que cria os botões
-- String title -> título do botão
-- int 	  y_pos -> posição do botão no eixo y
-- Retorno: Button Widget 
local function createButton(title, y_pos, func)
	
	assert(type(title) == "string" ,"O título do botão deve ser do tipo string")
	assert(type(y_pos) == "number" ,"A posição do eixo Y do botão deve ser do tipo number")
	assert(type(func) == "function" ,"O evento do botão deve ser do tipo function")
	
		local btn =  widget.newButton{
		label = title,
		labelColor = { 
			default = color("fff"), 
			over = color("b58863")
		},
		fontSize = 30,
		font = FONT,
		defaultFile = REC_BUTTON_PNG,
		overFile = REC_BUTTON_PNG_OVER,
		width = BUTTON_WIDTH, 
		height = BUTTON_HEIGHT,
		onRelease = func	-- event listener function
	}
	btn.x = display.contentCenterX
	btn.y = y_pos
	return btn
end

-- Função que cria o botão de configurações
-- int	  		x_pos -> posição do botão no eixo x
-- int 	  		y_pos -> posição do botão no eixo y
-- Function 	func -> função a ser executada ao clicar no botão
-- Retorno: Button Widget 
local function createSettingsButton(x_pos, y_pos, func)
	
	assert(type(x_pos) == "number" ,"A posição do eixo X do botão deve ser do tipo number")
	assert(type(y_pos) == "number" ,"A posição do eixo Y do botão deve ser do tipo number")
	assert(type(func) == "function" ,"O evento do botão deve ser do tipo function")
	
	local btn =  widget.newButton{
		defaultFile = SETTINGS_BUTTON_PNG,
		width = 64, 
		height = 64,
		onRelease = func	-- event listener function
	}
	btn.x = x_pos
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
	
	local title = display.newText("Xadrez", display.contentCenterX, 200, FONT, 200);

	-- create a widget button (which will loads level1.lua on release)

	pvpBtn = createButton("Jogador vs Jogador", 		(display.contentHeight - 500), onPlayBtnRelease)
	pviBtn = createButton("Jogador vs Computador", 		(display.contentHeight - 340), onPlayBtnRelease)
	iviBtn = createButton("Computador vs Computador", 	(display.contentHeight - 180), onPlayBtnRelease)
	settingsBtn = createSettingsButton((display.contentWidth - 64),(display.contentHeight - 64), onPlayBtnRelease)
	
	-- all display objects must be inserted into group
	--sceneGroup:insert( background )
	sceneGroup:insert( title )
	sceneGroup:insert( pvpBtn )
	sceneGroup:insert( pviBtn )
	sceneGroup:insert( iviBtn )
	sceneGroup:insert( settingsBtn )
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
