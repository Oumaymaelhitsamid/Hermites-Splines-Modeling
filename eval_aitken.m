% eval_aitken : évalue le point donnée par l'interpolation en t 
%   des noeuds nodes par l'algorithme de Aitken pour 
%   la paramétrisation parameters
function [points_dc] = eval_aitken(noeuds, par, t)
    matrice = noeuds(:, :);
    for i = 1:(size(noeuds, 2) - 1)
        for j = 1:(size(noeuds, 2) - i)
            denomi = par(j + i) - par(j);
            points_dc = (((par(j + i) - t) / denomi) * matrice(:, j) ) + (((t - par(j)) / denomi) * matrice(:, j + 1));
            matrice(:, j) = points_dc;
        end
    end
    points_dc = matrice(:, 1);
