local classes = require("src.util.classes")
local Peca = require("src.models.peaces.interfaces.Peca")

local Peao = classes.class(Peca)

--Construtor
function Peao:init(posX, posY, cor, peso)
    self.super:init(posX, posY, cor, peso)
end

Peao.pinado = false
Peao.primeiro = true             --boolean para primeiro movimento (pode mover 2 casas)

--Override da superclasse Peca
function Peao:movimentoValido (x,y)
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
    --checar se primeiro==true
    if self.primeiro==true then
        --se validar o movimento, lembrar de setar primeiro = false
    end
    return true
end

function Peao:promovePeao ()
    local c = self.cor
    local x = self.posX
    local y = self.posY
    local p = 0.0                   --Inserir calculo de peso aqui
    self=nil
    rPromo = new Rainha(x,y,c,p)
end

return Peao