local classes = require("src.util.classes")
local Peca = require("src.models.peaces.interfaces.Peca")

local Cavalo = classes.class(Peca)

--Construtor
function Cavalo:init(posX, posY, cor, peso)
    self.super:init(posX, posY, cor, peso)
end

Cavalo.pinado = false

--Override da superclasse Peca
function Cavalo:movimentoValido (x,y)
    if x or y > 8 then
        return false
    elseif x or y < 1 then
        return false
    end
    --checa se casa vazia
    --checa colisão
    if self.pinado==true then
        return false
    end
    return true
end

return Cavalo