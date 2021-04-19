local composer = require( "composer" )
local scene = composer.newScene()

local classes = require("src.util.classes")
local Peca = classes.class()



local contador = 0
-- id da peça, variavel estatica da classe (contador de instancias)

-- Construtor
function Peca:init (posX, posY, cor, peso)
    self.posX = posX
    self.posY = posY
    self.cor = cor          --p para pretas, b para brancas
    self.peso = peso        --para a IA

    --incrementador de id
    contador = contador + 1
    self.id = contador
end

function Peca:getPecaID ()
    return "Animal<"..self.id..">"
end

--funçao abstrata sobreescrita nas subclasses
function Peca:movimentoValido (x, y)
    error ("Nao chame a função usando '.', pois não referencia ela mesma como parametro. Use ':' !")
    return false
end

function Peca:movePeca (x, y)
    if self:movimentoValido(x,y) then
        self.posX = x
        self.posY = y
        --checa se peao deve ser promovido
        if self:instanceOf(Peao) then
            if self.cor == "b" and y == 8 then
                self.promovePeao()
            elseif self.cor == "p" and y == 1 then
                self.promovePeao()
            end
        end
    end
end





--Criar scene ao criar peça, destruir ao perder a peça, renderizar sprites no show (acho que só)
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

end


function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end




scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return Peca