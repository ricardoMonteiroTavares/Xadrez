-- Imports
IconButton = require("src.models.buttons.IconButton")
SwitchButton = require("src.models.buttons.SwitchButton")
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

local SettingsWindow = {}
local mt = {__index = SettingsWindow}

function SettingsWindow:Create(x_pos, y_pos)

    assert(type(x_pos) == "number" ,"A posição do eixo X do botão deve ser do tipo number")
    assert(type(y_pos) == "number" ,"A posição do eixo Y do botão deve ser do tipo number")
    
    -- Função que salva os dados no arquivo
    -- Table 	data  -> Tabela de Dados a serem salvos
    -- Retorno: void
    function saveData(data)
        local saveData = "Background_Music="..tostring(data.Background_Music).."\nMovement_Music="..tostring(data.Movement_Music)
        local file, errorString = io.open( PATH, "w" )
        
        if not file then
            error( "File error: " .. errorString )
        else
            file:write( saveData )
            io.close( file )
        end
        
        file = nil
    end

    -- Função que carrega os dados vindos do arquivo
    -- Retorno: Tabela de Dados de configuração
    function loadData()
        local data = {}
        local file, errorString = io.open( PATH, "r" )
        
        if not file then
            error( "File error: " .. errorString )
        else
            for line in file:lines() do

                local key, value = line:match("(%w+_%w+)=(%w+)");
                
                if key == "Background_Music" then
                    data.Background_Music = toBoolean(value)
                    print( "Carregou o ID ID '"..key.."' com o valor: "..tostring(data.Background_Music) )
                elseif key == "Movement_Music" then
                    data.Movement_Music = toBoolean(value)
                    print( "Carregou o ID '"..key.."' com o valor: "..tostring(data.Movement_Music) )
                else
                    error("Error: ID Não encontrado")
                    return {}
                end
            end

            io.close( file )
        end
        
        file = nil
        return data
    end

    local backgroundColor = Color:hexToRGB("525252")
	local strokeColor = Color:hexToRGB("fff")

    local obj = {}

    obj.data = loadData()
    
    obj.window = display.newGroup()	

    -- Função que encerra a janela
    function close()
        print("Apagando a janela de configurações");
        obj.window:removeSelf()
        obj.window = nil
        print("Inicio do Save")
        saveData(obj.data)
        print("Fim do Save")
    end

    -- Função que manipula os dados
    -- Event 	event  -> Evento que contém o id e o valor a ser salvo na tabela de dados
    -- Retorno: void
    function onSwitchPress( event )
        local switch = event.target
        if switch.id == "Background_Music" then
            obj.data.Background_Music = switch.isOn
            print( "Switch with ID '"..switch.id.."' is on: "..tostring(obj.data.Background_Music) )
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
	
	
	local backgoundMusic = SwitchButton:Create("Background_Music", -120, -80, obj.data.Background_Music, onSwitchPress) 
	local titleBackgoundMusic = display.newText("Música de Fundo", 25, -65, FONT, 20)
	
	local movementMusic = SwitchButton:Create("Movement_Music", -120, -30, obj.data.Movement_Music, onSwitchPress)
	local titleMovementMusic = display.newText("Som de Jogada", 20, -15, FONT, 20);

	local closeBtn = IconButton:Create(CLOSE_BUTTON_PNG, 32, 150, -150, close)
	
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