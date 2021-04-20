widget = require( "widget" )

local IconButton = {}
local mt = {__index = IconButton}

-- Função que cria um IconButton
-- string       icon     -> Caminho do ícone
-- int          iconSize -> Tamanho do ícone
-- int	  		x_pos    -> Posição do botão no eixo x
-- int 	  		y_pos    -> Posição do botão no eixo y
-- Function 	func     -> Função a ser executada ao clicar no botão
-- Retorno: Button Widget 
function IconButton:Create(icon, iconSize, x_pos, y_pos, func)
    assert(type(icon) == "string" ,"O caminho do ícone do botão deve ser do tipo string")
    assert(type(iconSize) == "number" ,"O tamanho do ícone deve ser do tipo number")
    assert(type(x_pos) == "number" ,"A posição do eixo X do botão deve ser do tipo number")
    assert(type(y_pos) == "number" ,"A posição do eixo Y do botão deve ser do tipo number")
    assert(type(func) == "function" ,"O evento do botão deve ser do tipo function")
    
    local obj = {}

    obj.btn =  widget.newButton{
		defaultFile = icon,
		width = iconSize, 
		height = iconSize,
		onRelease = func	-- event listener function
	}
	obj.btn.x = x_pos
	obj.btn.y = y_pos
  
    setmetatable(obj, mt);
    return obj.btn
end

return IconButton