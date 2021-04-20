local Color = {}
local mt = {__index = Color}

function Color:new()
    return setmetatable({}, mt);
end

-- Função que converte um código de cor em hexadecimal sem o # em um código de cor decimal
-- String hex -> Cor em hexadecimal sem #
-- Retorno: rgb table
function Color:hexToRGB(hex)
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

return Color