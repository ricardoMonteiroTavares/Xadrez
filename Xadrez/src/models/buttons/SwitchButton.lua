widget = require( "widget" )

-- pasta que contém os botões
local BUTTON_PATH = "\\assets\\buttons\\"

-- caminho dos arquivos png
local SWITCHER_BUTTON_PNG = BUTTON_PATH .. "switcher\\switches.png"

local SwitchButton = {}
local mt = {__index = SwitchButton}

function SwitchButton:Create(id, x_pos, y_pos, initialState, func)

    assert(type(id) == "string" ,"O id do botão deve ser do tipo string")
    assert(type(x_pos) == "number" ,"A posição do eixo X do botão deve ser do tipo number")
    assert(type(y_pos) == "number" ,"A posição do eixo Y do botão deve ser do tipo number")
	assert(type(initialState) == "boolean" ,"O initialState do botão deve ser do tipo boolean")
    assert(type(func) == "function" ,"O evento do botão deve ser do tipo function")

    local options = {
		frames = {
			{ x=0, y=0, width=64, height=28 },
			{ x=0, y=36, width=64, height=28 },
		},
		sheetContentWidth = 64,
		sheetContentHeight = 64
	}
	local onOffSwitchSheet = graphics.newImageSheet( SWITCHER_BUTTON_PNG, options )

    local obj = {}

    obj.btn = widget.newSwitch(
		{
			left = x_pos,
			top = y_pos,
			style = "checkbox",
			id = id,
			
			width = 64,
			height = 32,
			onPress = func,
			sheet = onOffSwitchSheet,
			initialSwitchState = initialState,
			frameOff = 1,
			frameOn = 2
		}
	)

    setmetatable(obj, mt);
    return obj.btn
end

return SwitchButton