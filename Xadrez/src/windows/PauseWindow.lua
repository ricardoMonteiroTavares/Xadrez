-- Imports
IconButton = require("src.models.buttons.IconButton")
RectangleButton = require("src.models.buttons.RectangleButton")
Color = require( "src.util.Color" )
toBoolean = require('src.util.toboolean')
widget = require( "widget" )

-- Pasta que contém os botões
local BUTTON_PATH = "\\assets\\buttons\\"

-- Caminho dos arquivos png
local CLOSE_BUTTON_PNG = BUTTON_PATH .. "closeButton\\close.png"

local FONT = "Times New Roman"

-- Caminho para o arquivo a ser manipulado
local PATH = system.pathForFile( "settings.conf", system.ResourceDirectory )

local PauseWindow = {}
local mt = {__index = PauseWindow}

function PauseWindow:Create(x_pos, y_pos)

    assert(type(x_pos) == "number" ,"A posição do eixo X do botão deve ser do tipo number")
    assert(type(y_pos) == "number" ,"A posição do eixo Y do botão deve ser do tipo number")

    local backgroundColor = Color:hexToRGB("525252")
	local strokeColor = Color:hexToRGB("fff")

    local obj = {}
    
    obj.window = display.newGroup()	

    -- Função que encerra a janela
    function close()
        print("Apagando a janela de pause");
        obj.window:removeSelf()
        obj.window = nil
    end
	

	local myBox = display.newRect( 0, 0, 300, 300 )
	myBox.strokeWidth = 3
	myBox:setFillColor( backgroundColor[1], backgroundColor[2], backgroundColor[3])
	myBox:setStrokeColor( strokeColor[1], strokeColor[2], strokeColor[3])
	
    local title = display.newText("Pause", 0, -120, FONT, 30)
	
	local desistBtn = RectangleButton:Create("Desistir", -120, -80, close) 

	local closeBtn = IconButton:Create(CLOSE_BUTTON_PNG, 32, 150, -150, close)
	
	obj.window:insert( myBox )
	obj.window:insert( title )
	obj.window:insert( closeBtn )
	obj.window:insert( desistBtn )
	
	obj.window.x = x_pos
	obj.window.y = y_pos
	obj.window.anchorChildren = true
    
    setmetatable(obj, mt)

    return obj.window
end

return PauseWindow