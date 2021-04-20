widget = require( "widget" )
Color = require( "src.util.Color" )

-- pasta que contém os botões
local BUTTON_PATH = "\\assets\\buttons\\"

-- caminho dos arquivos png
local REC_BUTTON_PNG = BUTTON_PATH .. "rectangleButton\\rectangleButton.png"
local REC_BUTTON_PNG_OVER = BUTTON_PATH .. "rectangleButton\\rectangleButton_over.png"

local BUTTON_HEIGHT = 60
local BUTTON_WIDTH = 250

local FONT = "Times New Roman"

local RectangleButton = {}
local mt = {__index = RectangleButton}

-- Função que cria um RectangleButton
-- String 		title -> Título do botão
-- int	  		x_pos -> Posição do botão no eixo x
-- int 	  		y_pos -> Posição do botão no eixo y
-- Function 	func  -> Função a ser executada ao clicar no botão
-- Retorno: Button Widget 
function RectangleButton:Create(title, x_pos, y_pos, func)
   
    assert(type(title) == "string" ,"O título do botão deve ser do tipo string")
    assert(type(x_pos) == "number" ,"A posição do eixo X do botão deve ser do tipo number")
    assert(type(y_pos) == "number" ,"A posição do eixo Y do botão deve ser do tipo number")
    assert(type(func) == "function" ,"O evento do botão deve ser do tipo function")

    local obj = {}

    obj.btn =  widget.newButton{
        label = title,
		labelColor = { 
			default = Color:hexToRGB("fff"), 
			over = Color:hexToRGB("b58863")
		},
		fontSize = 20,
		font = FONT,
		defaultFile = REC_BUTTON_PNG,
		overFile = REC_BUTTON_PNG_OVER,
		width = BUTTON_WIDTH, 
		height = BUTTON_HEIGHT,
		onRelease = func	-- event listener function
	}
	obj.btn.x = x_pos
	obj.btn.y = y_pos
  
    setmetatable(obj, mt);
    return obj.btn
end

return RectangleButton