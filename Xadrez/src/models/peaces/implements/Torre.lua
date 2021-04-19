local classes = require("src.util.classes")
local Peca = require("src.models.peaces.interfaces.Peca")

local Torre = classes.class(Peca)

--Construtor
function Torre:init(posX, posY, cor, peso)
    self.super:init(posX, posY, cor, peso)
end

Torre.pinado = false
Torre.roqueValidoT = false

function Torre:validaRoque ()
    if self.cor == "b" then
        if self.posX == 1 and self.posY == 1 then
            --checar se peças entre (1,1) e (5,1) estão vazias
            self.roqueValidoT = true
        elseif self.posX == 8 and self.posY == 1 then
            --checar se peças entre (5,1) e (8,1) estão vazias
            self.roqueValidoT = true
        end
    end
end

--Override da superclasse Peca
function Torre:movimentoValido (x,y)
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

return Torre