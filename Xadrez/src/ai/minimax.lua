--[[
 * Performs the minimax algorithm to choose the best move: https://en.wikipedia.org/wiki/Minimax (pseudocode provided)
 * Recursively explores all possible moves up to a given depth, and evaluates the game board at the leaves.
 * 
 * Basic idea: maximize the minimum value of the position resulting from the opponent's possible following moves.
 * Optimization: alpha-beta pruning: https://en.wikipedia.org/wiki/Alpha%E2%80%93beta_pruning (pseudocode provided)
 * 
 * Inputs:
 *  - game:                 the game object.
 *  - depth:                the depth of the recursive tree of all possible moves (i.e. height limit).
 *  - isMaximizingPlayer:   true if the current layer is maximizing, false otherwise.
 *  - sum:                  the sum (evaluation) so far at the current layer.
 *  - color:                the color of the current player.
 * 
 * Output:
 *  the best move at the root of the current subtree.
 ]]--

require("src.ai.evaluation")

function minimax(game, depth, alpha, beta, isMaximizingPlayer, sum, color)
{
    positionCount =  positionCount + 1
    local children = game.ugly_moves({verbose: true}) -- verificar
    
    -- Sort moves randomly, so the same move isn't always picked on ties
    children.sort(function(a, b){return 0.5 - Math.random()}); -- trocar
    
    local currMove
    -- Maximum depth exceeded or node is a terminal node (no children)
    if ((depth === 0) or (children.length === 0)) then
        return {null, sum}
    end

    -- Find maximum/minimum from list of 'children' (possible moves)
    local maxValue = -(2^1024) -- Int MIN
    local minValue = (2^1024) -- Int MAX
    local bestMove
    for i = 0, #children, 1 do
    
        currMove = children[i]

        -- Note: in our case, the 'children' are simply modified game states
        local currPrettyMove = game.ugly_move(currMove) -- verificar
        local newSum = evaluateBoard(currPrettyMove, sum, color)
        local childBestMove, childValue = minimax(game, depth - 1, alpha, beta, (not isMaximizingPlayer), newSum, color)
        
        game.undo()
    
        if (isMaximizingPlayer) then
        
            if (childValue > maxValue) then
            
                maxValue = childValue
                bestMove = currPrettyMove
            end
            if (childValue > alpha) then
            
                alpha = childValue
            end
        else
            if (childValue < minValue) then
                minValue = childValue
                bestMove = currPrettyMove
            end
            if (childValue < beta) then
                beta = childValue
            end
        end

        -- Alpha-beta pruning
        if (alpha >= beta) then break end
    end

    if (isMaximizingPlayer) then
        return {bestMove, maxValue}
    else
        return {bestMove, minValue}
    end
end