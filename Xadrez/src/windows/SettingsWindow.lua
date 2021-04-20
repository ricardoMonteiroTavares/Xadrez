IconButton = require("src.models.buttons.IconButton")
SwitchButton = require("src.models.buttons.SwitchButton")
Color = require( "src.util.Color" )

local widget = require( "widget" )

-- pasta que contém os botões
local BUTTON_PATH = "\\assets\\buttons\\"

-- caminho dos arquivos png
local CLOSE_BUTTON_PNG = BUTTON_PATH .. "closeButton\\close.png"

local FONT = "Times New Roman"

local SettingsWindow = {}
local mt = {__index = SettingsWindow}

function SettingsWindow:Create(x_pos, y_pos)

    assert(type(x_pos) == "number" ,"A posição do eixo X do botão deve ser do tipo number")
    assert(type(y_pos) == "number" ,"A posição do eixo Y do botão deve ser do tipo number")
    

    local backgroundColor = Color:hexToRGB("525252")
	local strokeColor = Color:hexToRGB("fff")

    local obj = {
        data = {
            Backgound_Music = true,
            Movement_Music = false
        }
    }
    
    obj.window = display.newGroup()	

    function close()
        obj.window:removeSelf()
        obj.window = nil
    end

    function onSwitchPress( event )
        local switch = event.target
        if switch.id == "Backgound_Music" then
            obj.data.Backgound_Music = switch.isOn
            print( "Switch with ID '"..switch.id.."' is on: "..tostring(obj.data.Backgound_Music) )
        elseif switch.id == "Movement_Music" then
            obj.data.Movement_Music = switch.isOn
            print( "Switch with ID '"..switch.id.."' is on: "..tostring(obj.data.Movement_Music) )
        else
            error("Error: ID Não encontrado")
        end
        
    end
	
	local myBox = display.newRect( 0, 0, 300, 300 )
	myBox.strokeWidth = 3
	myBox:setFillColor( backgroundColor[1], backgroundColor[2], backgroundColor[3])
	myBox:setStrokeColor( strokeColor[1], strokeColor[2], strokeColor[3])
	
    local title = display.newText("Configurações", 0, -120, FONT, 30)
	
	
	local backgoundMusic = SwitchButton:Create("Backgound_Music", -120, -80, obj.data.Backgound_Music, onSwitchPress) 
	local titleBackgoundMusic = display.newText("Música de Fundo", 25, -65, FONT, 20)
	
	local movementMusic = SwitchButton:Create("Movement_Music", -120, -30, obj.data.Movement_Music, onSwitchPress)
	local titleMovementMusic = display.newText("Som de Jogada", 20, -15, FONT, 20);

	local closeBtn = IconButton:Create(CLOSE_BUTTON_PNG, 32, 150, -150, close)--closeSettingsWindow)
	
	obj.window:insert( myBox )
	obj.window:insert( title )
	obj.window:insert( closeBtn )
	obj.window:insert( backgoundMusic )
	obj.window:insert( titleBackgoundMusic )
	obj.window:insert( movementMusic )
	obj.window:insert( titleMovementMusic )
	
	obj.window.x = x_pos
	obj.window.y = y_pos
	obj.window.anchorChildren = true
    
    setmetatable(obj, mt)

    return obj.window
end

return SettingsWindow