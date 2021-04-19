local classes = require("src.util.classes")
local Peca = require("src.models.peaces.interfaces.Peca")

local Rei = classes.class(Peca)

--Construtor
function Rei:init(posX, posY, cor, peso)
    self.super:init(posX, posY, cor, peso)
end

Rei.emCheque = false
Rei.roqueValidoR = false

function Rei:validaCheque ()
    --verifica se alguma peça está atacando o rei
    self.emCheque = false
end

function Rei:validaRoqueR ()
    if self.cor == "b" then
        if self.posX == 5 and self.posY == 1 then
            --checa se peças com x= 2, 3, 4, 6, 7 e y=1 estão vazias
            self.roqueValidoR = true
        elseif self.posX == 5 and self.posY == 8 then
            --checa se peças com x= 2, 3, 4, 6, 7 e y=8 estão vazias
            self.roqueValidoR = true
        end
    end
end

--Override da superclasse Peca
function Rei:movimentoValido (x,y)
    if x or y > 8 then
        return false
    elseif x or y < 1 then
        return false
    end
    --checa se casa vazia
    --checa colisão

    return true
end

return Rei
