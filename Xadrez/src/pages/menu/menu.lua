-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require( "widget" )
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
local SWITCHER_BUTTON_PNG = BUTTON_PATH .. "switcher\\switches.png"
local CLOSE_BUTTON_PNG = BUTTON_PATH .. "closeButton\\close.png"

local BUTTON_HEIGHT = 60
local BUTTON_WIDTH = 250

local FONT = "Times New Roman"
--------------------------------------------

-- forward declarations and other locals
local pvpBtn
local pviBtn
local iviBtn
local settingsBtn


local window
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
-- String 		title -> título do botão
-- int 	  		y_pos -> posição do botão no eixo y
-- Function 	func -> função a ser executada ao clicar no botão
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
		fontSize = 20,
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
local function createIconButton(icon, iconSize, x_pos, y_pos, func)
	
	assert(type(icon) == "string" ,"O caminho do ícone do botão deve ser do tipo string")
	assert(type(iconSize) == "number" ,"O tamanho do ícone deve ser do tipo number")
	assert(type(x_pos) == "number" ,"A posição do eixo X do botão deve ser do tipo number")
	assert(type(y_pos) == "number" ,"A posição do eixo Y do botão deve ser do tipo number")
	assert(type(func) == "function" ,"O evento do botão deve ser do tipo function")
	
	local btn =  widget.newButton{
		defaultFile = icon,
		width = iconSize, 
		height = iconSize,
		onRelease = func	-- event listener function
	}
	btn.x = x_pos
	btn.y = y_pos
	return btn
end

local function onSwitchPress( event )
    local switch = event.target
    print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
end

local function closeSettingsWindow()
	window:removeSelf()
	window = nil
end

local function settingsWindow()
	window = display.newGroup()
	
	local options = {
		frames = {
			{ x=0, y=0, width=64, height=28 },
			{ x=0, y=36, width=64, height=28 },
		},
		sheetContentWidth = 64,
		sheetContentHeight = 64
	}
	local onOffSwitchSheet = graphics.newImageSheet( SWITCHER_BUTTON_PNG, options )
	
	
	local myBox = display.newRect( 0, 0, 300, 300 )
	myBox:setFillColor( 1, 0, 0 )
	
	local title = display.newText("Configurações", 0, -120, FONT, 30);
	
	
	local backgoundMusic = widget.newSwitch(
		{
			left = -120,
			top = -80,
			style = "checkbox",
			id = "Backgound_Music",
			
			width = 64,
			height = 32,
			onPress = onSwitchPress,
			sheet = onOffSwitchSheet,
			frameOff = 1,
			frameOn = 2
		}
	)
	local titleBackgoundMusic = display.newText("Música de Fundo", 25, -65, FONT, 20);
	
	local movementMusic = widget.newSwitch(
		{
			left = -120,
			top = -30,
			style = "checkbox",
			id = "Movement_Music",
			
			width = 64,
			height = 32,
			onPress = onSwitchPress,
			sheet = onOffSwitchSheet,
			frameOff = 1,
			frameOn = 2
		}
	)
	local titleMovementMusic = display.newText("Som de Jogada", 20, -15, FONT, 20);

	local closeBtn = createIconButton(CLOSE_BUTTON_PNG, 32, 150, -150, closeSettingsWindow)
	
	window:insert( myBox )
	window:insert( title )
	window:insert( closeBtn )
	window:insert( backgoundMusic )
	window:insert( titleBackgoundMusic )
	window:insert( movementMusic )
	window:insert( titleMovementMusic )
	
	window.x = display.contentCenterX
	window.y = display.contentCenterY
	window.anchorChildren = true
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
	
	local title = display.newText("Xadrez", display.contentCenterX, 200, FONT, 100);

	-- create a widget button (which will loads level1.lua on release)

	pvpBtn = createButton("Jogador vs Jogador", 		(display.contentHeight - 300), onPlayBtnRelease)
	pviBtn = createButton("Jogador vs Computador", 		(display.contentHeight - 200), onPlayBtnRelease)
	iviBtn = createButton("Computador vs Computador", 	(display.contentHeight - 100), onPlayBtnRelease)

	settingsBtn = createIconButton(SETTINGS_BUTTON_PNG, 64, (display.contentWidth - 64),(display.contentHeight - 64), settingsWindow)
	
	-- all display objects must be inserted into group
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
