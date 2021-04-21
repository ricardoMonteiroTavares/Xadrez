-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

local IconButton = require("src.models.buttons.IconButton")
local RectangleButton = require("src.models.buttons.RectangleButton")
local SettingsWindow = require("src.windows.SettingsWindow")

-- caminho para a tela que inicia o jogo
local GAME_SCENE = "\\src\\pages\\game\\game"

-- pasta que contém os botões
local BUTTON_PATH = "\\assets\\buttons\\"

-- caminho dos arquivos png
local SETTINGS_BUTTON_PNG = BUTTON_PATH .. "settingsButton\\settings.png"


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

-- Função que cria a janela de configurações
-- Retorno: void
local function settingsWindow()
	window = SettingsWindow:Create(display.contentCenterX, display.contentCenterY)
	pvpBtn:setEnabled( false )
	pviBtn:setEnabled( false )
	iviBtn:setEnabled( false )
	settingsBtn:setEnabled( false )
end

function scene:create( event )
	print("Criando a cena MENU");
	local sceneGroup = self.view
	
	local title = display.newText("Xadrez", display.contentCenterX, 200, FONT, 100);

	pvpBtn = RectangleButton:Create("Jogador vs Jogador", display.contentCenterX, (display.contentHeight - 300), onPlayBtnRelease)
	pviBtn = RectangleButton:Create("Jogador vs Computador", display.contentCenterX, (display.contentHeight - 200), onPlayBtnRelease)
	iviBtn = RectangleButton:Create("Computador vs Computador", display.contentCenterX, (display.contentHeight - 100), onPlayBtnRelease)

	settingsBtn = IconButton:Create(SETTINGS_BUTTON_PNG, 64, (display.contentWidth - 64),(display.contentHeight - 64), settingsWindow)
	
	-- all display objects must be inserted into group
	sceneGroup:insert( title )
	sceneGroup:insert( pvpBtn )
	sceneGroup:insert( pviBtn )
	sceneGroup:insert( iviBtn )
	sceneGroup:insert( settingsBtn )
end

function scene:show( event )
	print("Mostrando a cena MENU");
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
	print("Escondendo a cena MENU");
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
	print("Destruindo a cena MENU");
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
