local classes = require("classes")
local Peca = require("Peca")

local Rainha = classes.class(Peca)

--Construtor
function Rainha:init(posX, posY, cor, peso)
    self.super:init(posX, posY, cor, peso)
end

Rainha.pinado = false

--Override da superclasse Peca
function Rainha:movimentoValido (x,y)
    if x or y > 8 then
        return false
    elseif x or y < 1 then
        return false
    end
    --checa se casa vazia
    --checa colisão
    if self.pinado==true then
        --expandir para lidar com movimentos limitados
        return false
    end
    return true
end

return Rainha